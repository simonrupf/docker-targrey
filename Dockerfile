FROM alpine:3.11
COPY src /
RUN apk upgrade --no-cache && \
    apk add --no-cache curl postgrey tzdata && \
    # taRgrey patch
    patch /usr/sbin/postgrey /targrey-*.patch && \
    rm /targrey-*.patch && \
    # update the whitelist, may change every few months
    curl -s https://postgrey.schweikert.ch/pub/postgrey_whitelist_clients > /etc/postfix/postgrey_whitelist_clients && \
    apk del --no-cache curl

USER postgrey:nogroup

EXPOSE 10023/tcp
VOLUME /var/run /var/spool/postfix/postgrey

CMD ["/usr/sbin/postgrey", "-i", "0:10023", "--tarpit=125", "--targrey", "--retry-count=2", "--delay=1800", "--auto-whitelist-delay=3600"]
