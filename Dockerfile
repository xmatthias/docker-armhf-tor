# run a tor socks proxy in a container
# docker build -t armhf_alpine_tor_proxy .
#
# docker run -d \
#   --restart always \
#   -v /etc/localtime:/etc/localtime:ro \
#   -p 127.0.0.1:9050:9050 \
#   -p 127.0.0.1:9051:9051 \
#   --name torproxy \
#   armhf_alpine_tor_proxy
#
# This container exposes 2 identical ports (9050, 9051) - use to have separate circuits
#
FROM container4armhf/armhf-alpine:latest

RUN echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories  \
    && apk --no-cache add \
    tor \
    && mkdir -p /etc/tor/ \
    && cat /dev/null > /etc/tor/torrc.default \
#   && echo "#AutomapHostsOnResolve 1" > /etc/tor/torrc.default \
#   && echo "TransPort 9040" > /etc/tor/torrc.default \
    && echo "SocksPort 0.0.0.0:9050" >> /etc/tor/torrc.default \
    && echo "SocksPort 0.0.0.0:9051" >> /etc/tor/torrc.default \
#   && echo "DNSPort 53530" > /etc/tor/torrc.default \
#   && echo "DNSPort 9053 " > /etc/tor/torrc.default \
    && chown -R tor /etc/tor

# expose socks port
EXPOSE 9050 9051

# alternative way for more complicated torrc files
# copy in our torrc file
#COPY torrc.default /etc/tor/torrc.default

#RUN chown -R tor /etc/tor

USER tor

ENTRYPOINT [ "tor" ]
CMD [ "-f", "/etc/tor/torrc.default" ]
