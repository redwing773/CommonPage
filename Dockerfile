FROM alpine:3.15

LABEL name="portal-main"
LABEL version="0.1"

ENV GLIBC_VERSION 2.34-r0

RUN apk update
RUN apk upgrade
RUN apk add ca-certificates
RUN apk add --update curl && \
  curl -Lo /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
  curl -Lo glibc.apk "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" && \
  curl -Lo glibc-bin.apk "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" && \
  apk add glibc-bin.apk glibc.apk && \
  /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib && \
  echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
  apk del curl && \
  rm -rf glibc.apk glibc-bin.apk /var/cache/apk/*

RUN apk add openjdk11=11.0.17_p8-r0

RUN apk add libpcap

RUN mkdir -p /service

WORKDIR /service

ADD ./build/libs/*-SNAPSHOT.war /service/application.war
 
RUN echo -e "#!/bin/sh\njava -jar -\$XMS -\$XMX -Dsun.net.inetaddr.ttl=5 /service/application.war --spring.profiles.active=\$STAGE -Dspring.profiles.active=$STAGE -Dsun.net.inetaddr.ttl=5" > /service/start.sh
 
RUN chmod +x /service/start.sh
 
EXPOSE 8080
 
CMD ["/service/start.sh"]
