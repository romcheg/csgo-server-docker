FROM ubuntu:bionic

LABEL authors="Roman Prykhodchenko"
LABEL maintainer="Roman Prykhodchenko"
LABEL description="CS:GO"
LABEL version="1.1.0"

ENV DEBIAN_FRONTEND=noninteractive


ENV CONF_DIR=/etc/csgo/vars
ENV PROVISIONING_DIR=/tmp/provisioning_scripts

ENV STEAM_USER=steam
ENV STEAM_USER_HOMEDIR=/home/${STEAM_USER}
ENV CS_GO_DIR=${STEAM_USER_HOMEDIR}/csgo



RUN apt-get clean && \
    apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
        locales \
        lib32stdc++6 \
        lib32gcc1 \
        wget \
        ca-certificates \
        net-tools \
        libsdl2-2.0-0 && \
    apt-get -y upgrade && \
    apt-get clean autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    locale-gen en_US.UTF-8

# set UTF-8 locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY config ${CONF_DIR}
COPY provisioning ${PROVISIONING_DIR}
RUN ${PROVISIONING_DIR}/provision.sh

USER ${STEAM_USER}
ENTRYPOINT ${STEAM_USER_HOMEDIR}/entrypoint.sh
WORKDIR ${STEAM_USER_HOMEDIR}
VOLUME ${CS_GO_DIR}/
