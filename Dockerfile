FROM alpine:3.8
MAINTAINER Jochen Schalanda <jochen+docker@schalanda.name>

ENV PROSODY_VERSION 0.10.2-r0

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Prosody IM Alpine Docker Image" \
      org.label-schema.description="Prosody IM Docker image based on Alpine Linux" \
      org.label-schema.url="https://prosody.im/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/joschi/docker-prosody-alpine" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0" \
      com.microscaling.docker.dockerfile="/Dockerfile" \
      com.microscaling.license="MIT"

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
