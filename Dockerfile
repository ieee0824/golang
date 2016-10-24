FROM ubuntu:16.04

MAINTAINER aoi shirase <https://github.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
        g++ \
        gcc \
        libc6-dev \
        make \
        pkg-config \
        git \
        build-essential \
        ca-certificates \
        curl \
        && rm -rf /var/lib/apt/lists/*

ENV GOVERSION 1.7.3
ENV WORKSPACE "/root/.workspace"

RUN mkdir -p $WORKSPACE
RUN git clone https://github.com/wfarr/goenv.git /root/.goenv
ENV PATH /root/.goenv/bin:$PATH
ENV PATH /root/.goenv/shims:$PATH

RUN eval "$(goenv init -)"

WORKDIR $WORKSPACE
RUN mkdir -p /root/.workspace/go
ENV GOPATH /root/.workspace/go
ENV PATH /root/.workspace/go/bin:$PATH

RUN goenv install $GOVERSION
RUN goenv global $GOVERSION

ENTRYPOINT ["go"]

CMD ["version"]
    
