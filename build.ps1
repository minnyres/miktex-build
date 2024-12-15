$ErrorActiOFFPreference = "Stop"

$fop_dir = "C:\ProgramData\chocolatey\lib\apache-fop\tools\fop-2.6\fop"
$env:path = "$vcpkg_dir\installed\x64-windows-release\bin;$qt_dir\bin;$fop_dir;$env:path;$msys2_dir\usr\bin"

cmake -B "build-x64" -G "Ninja" -DCMAKE_BUILD_TYPE=Release `
 -DCMAKE_INSTALL_PREFIX=$miktex_install -DWITH_MIKTEX_API_DOC=OFF `
 -DCMAKE_TOOLCHAIN_FILE="$vcpkg_dir\scripts\buildsystems\vcpkg.cmake" -DVCPKG_TARGET_TRIPLET=x64-windows-release `
 -DUSE_SYSTEM_BZIP2=OFF -DUSE_SYSTEM_CAIRO=OFF -DUSE_SYSTEM_EXPAT=OFF -DUSE_SYSTEM_FOFFTCOFFFIG=OFF -DUSE_SYSTEM_FREETYPE2=OFF `
 -DUSE_SYSTEM_PIXMAN=OFF -DUSE_SYSTEM_PNG=OFF -DUSE_SYSTEM_ZLIB=OFF -DUSE_SYSTEM_APR=OFF -DUSE_SYSTEM_APRUTIL=OFF -DUSE_SYSTEM_OPENSSL_CRYPTO=OFF `
 miktex
cmake --build build-x64
cmake --install build-x64