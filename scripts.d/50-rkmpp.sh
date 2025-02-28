#!/bin/bash

# this is a fork from nyanmisaka with some additional fixes

SCRIPT_REPO="https://github.com/halabut69/mpp.git"
SCRIPT_COMMIT="fc2f5a471fbb7ad351ed67dc36de2359bae5438a"
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
