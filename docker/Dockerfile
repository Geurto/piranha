ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /home/pi/src
RUN mkdir -p /home/pi/build
COPY . /home/pi/src
WORKDIR /home/pi/src

# apt installs
RUN apt-get update && apt-get install -y -qq --no-install-recommends  \
    `cat /home/pi/src/dependencies/apt.txt`\
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove \
    && apt-get clean


# install Arduino CLI @todo probably separate this to a different container
RUN if \
        [ "$(uname -m)" = "aarch64" ] ; then \
    echo "Downloading arm64 version of arduino-cli" && \
    wget -O arduino-cli.tar.bz2 https://downloads.arduino.cc/arduino-cli/arduino-cli_latest_Linux_ARM64.tar.gz; \
    fi

RUN if \
        [ "$(uname -m)" = "x86_64" ] ; then \
    echo "Downloading x86_64 version of arduino-cli" && \
    wget -O arduino-cli.tar.bz2 https://downloads.arduino.cc/arduino-cli/arduino-cli_latest_Linux_64bit.tar.gz; \
    fi

RUN tar -xf arduino-cli.tar.bz2 && \
    mv arduino-cli /usr/local/bin/arduino-cli && \
    rm arduino-cli.tar.bz2
RUN arduino-cli config init && \
    arduino-cli core update-index
RUN arduino-cli core install esp32:esp32