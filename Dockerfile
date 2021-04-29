ARG BUILD_FROM=debian:buster-slim

FROM $BUILD_FROM

RUN apt-get update \
 && apt-get install -y wget \
                       gnupg2 \
 && wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add - \
 && wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/buster.list

RUN apt-get update \
 && apt-get install -y libffi-dev \
                       libxml2-dev \
                       libxslt1-dev \
                       zlib1g-dev \
                       build-essential \
                       python3-dbus \
                       python3-dev \
                       python3-gst-1.0 \
                       python3-lxml \
                       python3-pip \
                       python3-setuptools \
                       python3-wheel \
                       libasound2-dev \
                       libspotify-dev \
                       libavahi-client3 \
                       libavahi-common3 \
                       libc6 \
                       libexpat1 \
                       libflac8 \
                       libgcc1 \
                       libogg0 \
                       libopus0 \
                       libsoxr0 \
                       libstdc++6 \
                       libvorbis0a \
                       libvorbisenc2 \
 && rm -rf /var/lib/apt/lists/*

# Add git to get some Mopidy stuff straight from Github
#RUN apt-get update \
# && apt-get install -y git \
# && rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt
COPY snapserver_0.24.0-1_amd64.deb snapserver_0.24.0-1_amd64.deb

RUN pip3 install -r requirements.txt \
 && rm -rf ~/.cache/pip

RUN update-ca-certificates --fresh

RUN dpkg -i snapclient_0.24.0-1_armhf.deb

COPY mopidy.conf /root/.config/mopidy/

VOLUME ["/root/.cache/mopidy", "/root/.local/share/mopidy"]

ENV TZ=America/Toronto

EXPOSE 6600 6680

ENTRYPOINT ["mopidy"]
