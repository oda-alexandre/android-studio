FROM openjdk:8-jdk

LABEL authors https://www.oda-alexandre.com

ENV USER android
ENV HOME /home/${USER}
ENV VERSION 3.6.1.0
ENV APP https://dl.google.com/dl/android/studio/ide-zips/${VERSION}/android-studio-ide-192.6241897-linux.tar.gz

RUN echo -e '\033[36;1m ******* INSTALL PACKAGES ******** \033[0m' && \
  apt update && apt install -y --no-install-recommends \
  sudo \
  usbutils \
  wget \
  libxext6 \
  libxrender1 \
  libxtst6 \
  lib32stdc++6 && \
  rm -rf /var/lib/apt/lists/*

RUN echo -e '\033[36;1m ******* ADD USER ******** \033[0m' && \
  useradd -d ${HOME} -m ${USER} && \
  passwd -d ${USER} && \
  adduser ${USER} sudo

RUN echo -e '\033[36;1m ******* SELECT USER ******** \033[0m'
USER ${USER}

RUN echo -e '\033[36;1m ******* SELECT WORKING SPACE ******** \033[0m'
WORKDIR ${HOME}

RUN echo -e '\033[36;1m ******* INSTALL APP ******** \033[0m' && \
  wget ${APP} -O ${HOME}/android-studio.tar.gz && \
  sudo tar zxvf android-studio.tar.gz && \
  rm -rf android-studio.tar.gz && \
  sudo apt-get --purge autoremove -y wget

RUN echo -e '\033[36;1m ******* SELECT WORKING SPACE ******** \033[0m'
WORKDIR ${HOME}/android-studio/bin

RUN echo -e '\033[36;1m ******* CONTAINER START COMMAND ******** \033[0m'
CMD ./studio.sh \