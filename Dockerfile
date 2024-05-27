FROM alpine:3.20

LABEL org.opencontainers.image.authors="Simon Rupf <simon@rupf.net>" \
      org.opencontainers.image.source=https://github.com/simonrupf/docker-targrey \
      org.opencontainers.image.version="${VERSION}"

COPY src /
RUN echo https://dl-cdn.alpinelinux.org/alpine/v3.15/main >> /etc/apk/repositories && \
    apk upgrade --no-cache && \
    apk add --no-cache patch perl=5.34.2-r0 postgrey tzdata && \
    # taRgrey patch
    patch /usr/sbin/postgrey /targrey-*.patch && \
    rm /targrey-*.patch && \
    # update the whitelist, may change every few months
    wget -q https://postgrey.schweikert.ch/pub/postgrey_whitelist_clients -O /etc/postfix/postgrey_whitelist_clients && \
    apk del --no-cache patch

USER postgrey:nogroup

EXPOSE 10023/tcp
VOLUME /var/run /var/spool/postfix/postgrey

CMD ["/usr/sbin/postgrey", "-i", "0:10023", "--tarpit=125", "--targrey", "--retry-count=2", "--delay=1800", "--auto-whitelist-delay=3600"]
