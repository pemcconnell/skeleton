FROM golang:1.13.2-stretch as build
LABEL maintainer "Peter McConnell <me@petermcconnell.com>"

RUN apt-get update && apt-get install -y --no-install-recommends \
      curl="7.52.1-5+deb9u9" \
      shellcheck="0.4.4-4" \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/hadolint/hadolint/releases/download/v1.17.2/hadolint-Linux-x86_64 -o /usr/local/bin/hadolint \
    && chmod +x /usr/local/bin/hadolint
RUN curl -L https://github.com/sstephenson/bats/archive/v0.4.0.tar.gz -o /tmp/bats.tar.gz \
    && tar -C /tmp/ -xvf /tmp/bats.tar.gz \
    && cp -L /tmp/bats-0.4.0/bin/bats /usr/local/bin/bats \
    && chmod +x /usr/local/bin/bats \
    && rm -f /tmp/bats.tar.gz \
    && rm -rf /tmp/bats-0.4.0

RUN mkdir -p /go
WORKDIR /go
ENV GOPATH /go
COPY . /go

RUN go build -o foo
