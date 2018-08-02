# stable and recent automated build
FROM lsiobase/alpine:latest

MAINTAINER ishkanan

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="ishkanan/alpine-openvpn" \
      org.label-schema.description="An Alpine-based OpenVPN Server image." \
      org.label-schema.url="https://hub.docker.com/r/ishkanan/alpine-openvpn/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/ishkanan/docker-alpine-openvpn" \
      org.label-schema.vendor="Anthony Ishkan" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

# install and configure
RUN \
  echo "*** install openvpn server ***" && \
  apk add --no-cache --purge -uU \
    openvpn \
    logrotate && \
  rm -rf /var/cache/apk/* /tmp/* && \
  echo "*** fix logrotate ***" && \
  sed -i "s#/var/log/messages {}.*# #g" /etc/logrotate.conf

# overlay folder (S6 inject)
COPY root/ /

# volumes
VOLUME /etc/openvpn
