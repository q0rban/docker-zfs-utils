ARG FROM_TAG

FROM debian:$FROM_TAG

RUN \
    sed -e 's/^Components: main$/& contrib/g' -i /etc/apt/sources.list.d/debian.sources && \
    apt-get update && \
    apt-get install --yes --no-install-recommends zfsutils-linux && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
