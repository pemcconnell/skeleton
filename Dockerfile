FROM golang:1.13.2-stretch as build
LABEL maintainer "Peter McConnell <me@petermcconnell.com>"

RUN apt-get update && apt-get install -y --no-install-recommends \
      curl="7.52.1-5+deb9u9" \
      shellcheck="0.4.4-4" \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/hadolint/hadolint/releases/download/v1.17.2/hadolint-Linux-x86_64 -o /usr/local/bin/hadolint \
    && chmod +x /usr/local/bin/hadolint
RUN git clone https://github.com/sstephenson/bats.git /tmp/bats \
    && /tmp/bats/install.sh /usr/local \
    && rm -rf /tmp/bats

RUN mkdir -p /go /.cache \
    && chmod 777 /.cache
WORKDIR /go
ENV GOPATH /go
COPY . /go

RUN go build -o foo
