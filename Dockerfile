FROM alpine:3.15
COPY src /
RUN apk upgrade --no-cache && \
    apk add --no-cache patch postgrey tzdata && \
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
