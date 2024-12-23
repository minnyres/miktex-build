$ErrorActiONPreference = "Stop"

$fop_dir = "C:\ProgramData\chocolatey\lib\apache-fop\tools\fop-2.6\fop"
$env:path = "$vcpkg_dir\installed\x64-windows-release\bin;$qt_dir\bin;$fop_dir;$env:path;$msys2_dir\usr\bin"

# sed -i 's|!defined(MIKTEX_WINDOWS)|defined(MIKTEX_WINDOWS)|g' miktex\Libraries\3rd\fontconfig\source\src\fccompat.c
cd miktex
git apply ..\fix-use-system-fontconfig.patch
cd ..

cmake -B "build-x64" -G "Ninja" -DCMAKE_BUILD_TYPE=Release `
 -DCMAKE_INSTALL_PREFIX="$miktex_install" -DWITH_MIKTEX_API_DOC=OFF `
 -DCMAKE_TOOLCHAIN_FILE="$vcpkg_dir\scripts\buildsystems\vcpkg.cmake" -DVCPKG_TARGET_TRIPLET=x64-windows-release `
 -DUSE_SYSTEM_BZIP2=ON -DUSE_SYSTEM_CAIRO=ON -DUSE_SYSTEM_EXPAT=ON -DUSE_SYSTEM_FONTCONFIG=ON -DUSE_SYSTEM_FREETYPE2=ON -DUSE_SYSTEM_ICU=ON `
 -DUSE_SYSTEM_PIXMAN=ON -DUSE_SYSTEM_PNG=ON -DUSE_SYSTEM_ZLIB=ON -DUSE_SYSTEM_APR=ON -DUSE_SYSTEM_APRUTIL=ON -DUSE_SYSTEM_OPENSSL_CRYPTO=ON `
 -DCMAKE_CXX_FLAGS="/W0 /DWIN32" -DCMAKE_C_FLAGS="/W0 /DWIN32" miktex
cmake --build build-x64
cmake --install build-x64

cd "$miktex_install\texmf\miktex\bin\x64"
windeployqt miktex-texworks.exe
rm vc_redist.x64.exe