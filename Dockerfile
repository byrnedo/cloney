FROM alpine:3.16.2

RUN apk add --update --no-cache git bash openssh

COPY clone.sh /
COPY repos.txt /
COPY docker-entrypoint.sh /

RUN mkdir -p ~/.ssh && touch ~/.ssh/known_hosts

WORKDIR /

ENTRYPOINT [ "/docker-entrypoint.sh" ]