# stable and recent automated build
FROM lsiobase/alpine:latest

MAINTAINER ishkanan

# install and configure
RUN \
  echo "*** install openvpn server ***" && \
  apk add --no-cache --purge -uU \
    openvpn && \
  rm -rf /var/cache/apk/* /tmp/* && \
  echo "*** configure tun device ***" && \
  modprobe tun && \
  echo "tun" >> /etc/modules

# hook in to S6
COPY root/ /

# ports and volumes
EXPOSE 1194
VOLUME /etc/openvpn

