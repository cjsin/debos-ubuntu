ARG SUITE=jammy

FROM ubuntu:${SUITE}

# make the SUITE arg available to the build stage
ARG SUITE
ARG KVER

RUN echo "Apt Update" \
        && apt-get update \
    && echo "Install packages" \
        && apt-get -y install debootstrap debos fakemachine \
    && echo "Install kernel" \
        && apt-get -y install linux-image-${KVER} linux-modules-${KVER} linux-headers-${KVER}

RUN echo "Install golang" \
    && apt-get -y install golang

RUN echo "Find kernel modules" \
        && ls -al /lib/modules/ \
        && ls -al /usr/lib/modules/ \
        && ls -al /boot/ \
        && chmod a+r /boot/* \
        && uname -r \
        && depmod -a ${KVER}

# Debos buuild dependnecies for some reason it needs glib
RUN apt-get -y install \
    pkg-config \
    git \
    libglib2.0-dev \
    libostree-dev \
    qemu-system-x86 \
    qemu-user-static \
    systemd-container

RUN apt-get -y install \
    ca-certificates

# bsdextrautils provides 'column'
RUN apt-get -y install \
    bsdextrautils \
    strace \
    ltrace

COPY debos /usr/local/bin

COPY entrypoint.sh /entrypoint.sh

CMD [ ]

ENTRYPOINT [ "/entrypoint.sh" ]

