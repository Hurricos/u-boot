#!/bin/sh

cd /u-boot

export SDK_DIR=/openwrt-sdk
export STAGING_DIR=${SDK_DIR}/staging_dir
export PATH=${STAGING_DIR}/toolchain-powerpc_8540_gcc-8.4.0_musl/bin:${PATH}

make P1020RDB-PC_NAND_defconfig

make -j $(nproc) ARCH=powerpc CROSS_COMPILE=powerpc-openwrt-linux-musl- u-boot.bin