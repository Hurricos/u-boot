FROM scratch as toolchain
ARG TOOLCHAIN_SRC=https://downloads.openwrt.org/releases/21.02.2/targets/mpc85xx/p1020/openwrt-sdk-21.02.2-mpc85xx-p1020_gcc-8.4.0_musl.Linux-x86_64.tar.xz
ADD "${TOOLCHAIN_SRC}" /toolchain.tar.xz

FROM alpine:latest as uboot
ARG UBOOT_SRC=https://gitlab.denx.de/u-boot/u-boot.git
RUN apk update && apk add git
RUN git clone "${UBOOT_SRC}" --branch master --depth 1 /u-boot

FROM        debian:10 AS builder
ARG         DEBIAN_FRONTEND=noninteractive
USER root

RUN echo 'deb http://deb.debian.org/debian testing main' \
		> /etc/apt/sources.list.d/testing.list && \
	apt-get update && \
	apt-get install -t buster -y \
		pwgen \
		locales \
		build-essential \
		git-core \
		subversion \
		libncurses5-dev \
		gawk \
        gcc-multilib \
		unzip \
		pv \
		gosu \
		signify-openbsd \
		python3 \
		wget \
		curl \
		screen \
		bison \
		flex \
		python3-distutils \
		swig \
		python3-dev \
		libssl-dev \
		rsync && \
	apt-get clean && \
	localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG=en_US.utf8

FROM       builder AS mpc85xx-uboot-builder

COPY --from=toolchain /toolchain.tar.xz /toolchain.tar.xz

RUN mkdir /openwrt-sdk /u-boot && \
    tar -xJf /toolchain.tar.xz --strip-components=1 -C /openwrt-sdk

COPY --from=uboot /u-boot /u-boot

ADD ./compile.sh /compile.sh

RUN [ "/compile.sh" ]

