FROM alpine:latest

RUN apk add --no-cache \
        bash \
        openssh-client

COPY tunnel.sh /tunnel.sh

CMD ["/tunnel.sh"]
