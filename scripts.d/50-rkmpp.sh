#!/bin/bash

# this is the upstream repo of mpp
# SCRIPT_REPO="https://github.com/rockchip-linux/mpp.git"
# SCRIPT_COMMIT="bebc9961103af2b53fb18175dd858b15a73c9ad8"

# this is a fork from nyanmisaka with some additional fixes
SCRIPT_REPO="https://github.com/halabut69/mpp.git"
SCRIPT_COMMIT="70b572a2c0906e284fa5a376ca5cda3649a18b02"
SCRIPT_BRANCH="jellyfin-mpp"

ffbuild_enabled() {
    [[ $ADDINS_STR == *-rk ]] && return 0
    return -1
}

ffbuild_dockerbuild() {
    mkdir bld
    cd bld

    cmake -DCMAKE_TOOLCHAIN_FILE="$FFBUILD_CMAKE_TOOLCHAIN" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$FFBUILD_PREFIX" -DBUILD_TEST=OFF -DBUILD_SHARED_LIBS=OFF ..
    make -j$(nproc)
    make install

    rm -rf $FFBUILD_PREFIX/lib/librockchip_mpp.so*
}

ffbuild_configure() {
    echo --enable-rkmpp
}

ffbuild_unconfigure() {
    echo --disable-rkmpp
}

ffbuild_libs() {
    echo -lstdc++
}
