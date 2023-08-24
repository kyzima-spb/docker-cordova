ARG NODE_VERSION=18
ARG RELEASE=bookworm-slim

ARG ANDROID_CMDLINE_TOOLS_VERSION="latest"
ARG ANDROID_BUILD_TOOLS_VERSION="33.0.2"
ARG ANDROID_PLATFORM_VERSION="33"


FROM debian:bookworm-slim as installer

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /opt

RUN set -ex \
    && apt update \
    && apt install -yq --no-install-recommends \
        ca-certificates \
        wget \
        unzip


FROM installer as java-installer

ARG JABBA_INSTALL_URL="https://github.com/shyiko/jabba/raw/master/install.sh"
ARG JAVA_VERSION="openjdk@1.17-0"

RUN set -ex \
    && wget -qO- $JABBA_INSTALL_URL | JABBA_COMMAND="install ${JAVA_VERSION} -o /opt/jdk" bash


FROM installer as gradle-installer

ARG GRADLE_VERSION="8.3"
ARG GRADLE_BASE_URL="https://services.gradle.org/distributions"
ARG GRADLE_DOWNLOAD_URL="${GRADLE_BASE_URL}/gradle-${GRADLE_VERSION}-bin.zip"

RUN set -ex \
    && wget -qO gradle.zip $GRADLE_DOWNLOAD_URL \
    && unzip gradle.zip \
    && mv gradle-${GRADLE_VERSION} gradle


FROM installer as tools-installer

ARG ANDROID_CMDLINE_TOOLS_BASE_URl="https://dl.google.com/android/repository"
ARG ANDROID_CMDLINE_TOOLS_DOWNLOAD_URl="${ANDROID_CMDLINE_TOOLS_BASE_URl}/commandlinetools-linux-10406996_latest.zip"

RUN set -ex \
    && apt update \
    && apt install -yq --no-install-recommends openjdk-17-jdk-headless \
    && wget -qO cmdline-tools.zip $ANDROID_CMDLINE_TOOLS_DOWNLOAD_URl \
    && unzip cmdline-tools.zip

ARG ANDROID_CMDLINE_TOOLS_VERSION

RUN set -ex \
    && echo 'yes' | ./cmdline-tools/bin/sdkmanager --sdk_root=sdk \
        "cmdline-tools;${ANDROID_CMDLINE_TOOLS_VERSION}"


FROM node:$NODE_VERSION-$RELEASE

ENV DEBIAN_FRONTEND=noninteractive \
    JAVA_HOME=/opt/jdk \
    GRADLE_HOME=/opt/gradle \
    ANDROID_SDK_ROOT=/opt/android-sdk \
    ANDROID_HOME=/opt/android-sdk

WORKDIR /app

COPY --from=gradle-installer /opt/gradle /opt/gradle

ARG CORDOVA_VERSION

RUN set -ex  \
    && npm i -g \
        cordova@${CORDOVA_VERSION} \
        serve

COPY --from=java-installer /opt/jdk /opt/jdk
COPY --from=tools-installer /opt/sdk/cmdline-tools /opt/android-sdk/cmdline-tools

ARG ANDROID_CMDLINE_TOOLS_VERSION
ARG ANDROID_PLATFORM_VERSION
ARG ANDROID_BUILD_TOOLS_VERSION

ENV PATH \
$PATH:\
$JAVA_HOME/bin:\
$GRADLE_HOME/bin:\
$ANDROID_SDK_ROOT/cmdline-tools/${ANDROID_CMDLINE_TOOLS_VERSION}/bin:\
$ANDROID_SDK_ROOT/emulator:\
$ANDROID_SDK_ROOT/platform-tools:\
$ANDROID_SDK_ROOT/build-tools/$ANDROID_BUILD_TOOLS_VERSION

RUN set -ex \
    && echo 'yes' | sdkmanager \
        "platform-tools" \
        "platforms;android-${ANDROID_PLATFORM_VERSION}" \
        "build-tools;${ANDROID_BUILD_TOOLS_VERSION}"

COPY ./root /

USER node

ENTRYPOINT ["docker-entrypoint.sh"]
