# docker-alpine-openvpn
An [OpenVPN Server](https://openvpn.net/) docker image for x86-64 architecture based on [Alpine Linux](https://alpinelinux.org/) with [S6 overlay](https://github.com/just-containers/s6-overlay). Available on [DockerHub](https://hub.docker.com/r/ishkanan/alpine-openvpn/).

This image is based on the [Alpine S6 base image](https://hub.docker.com/r/lsiobase/alpine/) maintained by the [LinuxServer.io](https://www.linuxserver.io) team, and thus includes:

* Log rotation
* Setting custom volume UID/GID
* Setting custom timezone

## Networking

The container needs to be run in "host" networking mode. If that is not desired, create an image based on this one that exposes the desired ports and performs other configuration as required.

## Usage

```
docker create \
  --name=openvpn \
  -v <path to data>:/etc/openvpn \
  -e PGID=<gid> -e PUID=<uid>  \
  -e TZ=<timezone> \
  --cap-add=NET_ADMIN \
  --net=host --privileged
  ishkanan/alpine-openvpn
```

## Parameters

| Parameter | Description |
| --- | --- |
| -v /etc/openvpn | Folder where OpenVPN stores its config. Logs are stored in a ```logs``` subfolder. |
| -e PGID | Set GID for volumes. |
| -e PUID | Set UID for volumes. |

