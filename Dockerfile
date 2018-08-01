# stable and recent automated build
FROM lsiobase/alpine:latest

MAINTAINER ishkanan

# install and configure
RUN \
  echo "*** install openvpn server ***" && \
  apk add --no-cache --purge -uU \
    openvpn && \
  rm -rf /var/cache/apk/* /tmp/*

# overlay folder (S6 inject)
COPY root/ /

# volumes
VOLUME /etc/openvpn

