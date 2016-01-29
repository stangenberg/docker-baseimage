FROM gliderlabs/alpine:3.3

MAINTAINER Thorben Stangenberg <thorben@stangenberg.net>

COPY rootfs /

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.13.0.0/s6-overlay-amd64.tar.gz /tmp/s6-overlay.tar.gz
ADD https://github.com/janeczku/go-dnsmasq/releases/download/0.9.2/go-dnsmasq-min_linux-amd64 /usr/sbin/go-dnsmasq

RUN tar xvfz /tmp/s6-overlay.tar.gz -C / && \
  chmod 755 /usr/sbin/go-dnsmasq /etc/services.d/dns/run /etc/services.d/syslog/run && \
  mkdir /app && \
  echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
  addgroup -g 999 app && \
  adduser -D  -G app -s /bin/false -u 999 app

ENTRYPOINT ["/init"]

CMD []
