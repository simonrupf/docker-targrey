FROM alpine:3.10
RUN apk add --no-cache curl postgrey

# taRgrey patch
COPY src /
RUN patch /usr/sbin/postgrey /targrey-*.patch
RUN rm /targrey-*.patch

# update the whitelist, may change every few months
RUN curl -s https://postgrey.schweikert.ch/pub/postgrey_whitelist_clients > /etc/postfix/postgrey_whitelist_clients
RUN apk del --no-cache curl

USER postgrey:nogroup

EXPOSE 10023/tcp
VOLUME /var/run /var/spool/postfix/postgrey

CMD ["/usr/sbin/postgrey", "-i", "0:10023", "--tarpit=125", "--targrey", "--retry-count=2", "--delay=1800", "--auto-whitelist-delay=3600"]
