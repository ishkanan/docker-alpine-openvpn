# docker-alpine-openvpn

[![](https://images.microbadger.com/badges/image/ishkanan/alpine-openvpn.svg)](https://microbadger.com/images/ishkanan/alpine-openvpn "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/commit/ishkanan/alpine-openvpn.svg)](https://microbadger.com/images/ishkanan/alpine-openvpn "Get your own commit badge on microbadger.com")

An [OpenVPN Server](https://openvpn.net/) docker image for x86-64 architecture based on [Alpine Linux](https://alpinelinux.org/) with [S6 overlay](https://github.com/just-containers/s6-overlay). Available on [DockerHub](https://hub.docker.com/r/ishkanan/alpine-openvpn/) and [GitHub](https://github.com/ishkanan/docker-alpine-openvpn/).

This image is based on the [Alpine S6 base image](https://hub.docker.com/r/lsiobase/alpine/) maintained by the [LinuxServer.io](https://www.linuxserver.io) team, and thus includes:

* Setting custom volume UID/GID
* Setting custom timezone


## Usage

Create via the CLI:

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

Create and run via a Docker Compose (v2.1) file:

```
...

  openvpn:
    image: ishkanan/alpine-openvpn
    container_name: openvpn
    volumes:
      - <path to data>:/etc/openvpn
    cap_add:
      - NET_ADMIN
    network_mode: "host"
    privileged: true
    environment:
      - PUID=<uid>
      - PGID=<gid>
      - TZ=<timezone>
...
```

## Parameters

| Parameter | Description |
| --- | --- |
| -v /etc/openvpn | Folder where OpenVPN expects to find a file named ```openvpn.conf```. Although the logs location is specified in the config file, a ```logs``` folder is created here if it doesn't exist (see Logging section). The image does not modify any other files in this volume, so it is safe to store things such as certificates, keys and other configuration items here. |
| -e PGID | Set GID for volumes. |
| -e PUID | Set UID for volumes. |
| -e TZ | Set a Linux-type timezone (e.g. ```Australia/Melbourne```). |


## Logging

OpenVPN logging configuration is specified in the configuration file. It is recommended practice to send logs to ```STDOUT``` and ```STDERR``` of process 1 so the Docker daemon can receive them. Since OpenVPN does not separate logs messages this way, all logs can be sent to ```STDOUT``` by adding this line to the config file:

```
log-append /proc/1/fd/1
```

The container creates a ```logs``` folder in the volume if it doesn't exist, which can be used for log files if the above method is not desired. Daily rotation of logs via ```logrotate``` has been configured for the ```logs``` folder.


## Networking

The container needs to be run in "host" networking mode. If that is not desired, create an image based on this one that exposes the desired ports and performs other configuration as required.

