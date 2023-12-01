FROM alpine:3.18.5
MAINTAINER Jochen Schalanda <jochen+docker@schalanda.name>

ENV PROSODY_VERSION 0.12.3-r1

RUN apk add --no-cache bash "prosody=${PROSODY_VERSION}"
RUN mkdir -p /etc/prosody/conf.d /usr/local/lib/prosody/modules

COPY prosody.cfg.lua /etc/prosody/prosody.cfg.lua
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80 443 5222 5269 5347 5280 5281
VOLUME ["/etc/prosody/", "/etc/prosody/conf.d/", "/usr/local/lib/prosody/modules/", "/var/lib/prosody/", "/var/run/prosody/prosody.pid"]

USER prosody
ENV __FLUSH_LOG yes
CMD ["prosody"]
