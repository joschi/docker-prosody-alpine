FROM alpine:3.21@sha256:56fa17d2a7e7f168a043a2712e63aed1f8543aeafdcee47c58dcffe38ed51099
LABEL org.opencontainers.image.authors="jochen+docker@schalanda.name"

ENV PROSODY_VERSION=0.12.4-r2

RUN apk add --no-cache bash ca-certificates "prosody=${PROSODY_VERSION}"
RUN mkdir -p /etc/prosody/conf.d /usr/local/lib/prosody/modules

COPY prosody.cfg.lua /etc/prosody/prosody.cfg.lua
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80 443 5222 5269 5347 5280 5281
VOLUME ["/etc/prosody/", "/etc/prosody/conf.d/", "/usr/local/lib/prosody/modules/", "/var/lib/prosody/", "/var/run/prosody/prosody.pid"]

USER prosody
ENV __FLUSH_LOG=yes
CMD ["prosody"]
