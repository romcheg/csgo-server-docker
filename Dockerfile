FROM ubuntu:bionic

LABEL authors="Roman Prykhodchenko"
LABEL maintainer="Roman Prykhodchenko"
LABEL description="Dedicated server of CS:GO"
LABEL version="1.0.0"

ENV DEBIAN_FRONTEND=noninteractive
ENV STEAM_USER_HOMEDIR=/home/steam
ENV STEAM_PROVISIONING_SCRIPT=/tmp/provisioning_scripts/steam_provision.txt
ENV CS_ENTRYPOINT_SCRIPT=/tmp/provisioning_scripts/entrypoint.sh
ENV CS_ENTRYPOINT_SCRIPT_DST=${STEAM_USER_HOMEDIR}/entrypoint.sh

RUN apt-get clean && \
    apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
        locales \
        lib32stdc++6 \
        lib32gcc1 \
        wget \
        ca-certificates \
        net-tools && \
    apt-get clean autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    locale-gen en_US.UTF-8

# set UTF-8 locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY provisioning_scripts /tmp/provisioning_scripts
RUN /tmp/provisioning_scripts/provision.sh

USER ${STEAM_USER}

ENTRYPOINT ${CS_ENTRYPOINT_SCRIPT_DST}
