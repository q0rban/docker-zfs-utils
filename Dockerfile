ARG FROM_TAG

FROM debian:$FROM_TAG

RUN \
    apt-get update && \
    apt-get install build-essential autoconf automake libtool gawk alien fakeroot dkms libblkid-dev uuid-dev libudev-dev libssl-dev zlib1g-dev libaio-dev libattr1-dev libelf-dev python3 python3-dev python3-setuptools python3-cffi libffi-dev python3-packaging debhelper-compat dh-python po-debconf python3-all-dev python3-sphinx libpam0g-dev libcurl4-openssl-dev linux-headers-generic wget dh-sequence-dkms --yes && \
    mkdir -p /opt/zfs && \
    cd /opt/zfs && \
    wget https://github.com/openzfs/zfs/archive/refs/tags/zfs-2.2.3.tar.gz && \
    tar -zxf zfs-2.2.3.tar.gz && \
    cd zfs-zfs-2.2.3 && \
    wget https://patch-diff.githubusercontent.com/raw/openzfs/zfs/pull/15784.diff && \
    patch -p1 < 15784.diff && \
    ./autogen.sh && \
    ./configure && \
    make native-deb-utils && \
    apt-get install --yes --fix-missing \
      /opt/zfs/openzfs-libnvpair3_2.2.3-1_$(dpkg --print-architecture).deb \
      /opt/zfs/openzfs-zfsutils_2.2.3-1_$(dpkg --print-architecture).deb \
      /opt/zfs/openzfs-libuutil3_2.2.3-1_$(dpkg --print-architecture).deb \
      /opt/zfs/openzfs-libzpool5_2.2.3-1_$(dpkg --print-architecture).deb \
      /opt/zfs/openzfs-libzfs4_2.2.3-1_$(dpkg --print-architecture).deb && \
    rm -rf /opt/zfs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
