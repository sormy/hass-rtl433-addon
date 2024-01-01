ARG BUILD_FROM
FROM $BUILD_FROM

ARG RTL_433_VERSION=master

RUN apk update && apk upgrade
RUN apk add --no-cache python3 py3-pip git
RUN apk add --no-cache build-base libtool cmake pkgconf \
    openssl openssl-dev libusb libusb-dev librtlsdr librtlsdr-dev rtl-sdr
RUN git clone https://github.com/merbanan/rtl_433.git \
    -b $RTL_433_VERSION
RUN cd rtl_433 \
    && mkdir build \
    && cd build \
    && cmake --install-prefix / .. \
    && make \
    && make install \
    && cp -v ../examples/rtl_433_mqtt_hass.py /bin/rtl_433_mqtt_hass \
    && cd / \
    && rm -rf /rtl_433
RUN apk del git build-base libtool cmake pkgconf openssl-dev libusb-dev librtlsdr-dev
RUN apk cache clean

RUN python3 -m venv .venv \
    && source .venv/bin/activate \
    && pip3 install paho-mqtt

COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/run.sh"]