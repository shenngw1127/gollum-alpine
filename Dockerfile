FROM ruby:3.0-alpine3.14
MAINTAINER wangsheng <shengw1127@gmail.com>

ARG GOLLUM_VERSION=5.2.3

# The default mirror (dl-cdn.alpinelinux.org) has issues sometimes for me
# More mirrors available here: mirrors.alpinelinux.org
RUN echo "https://mirror.csclub.uwaterloo.ca/alpine/v3.14/main" >/etc/apk/repositories && \
    echo "https://mirror.csclub.uwaterloo.ca/alpine/v3.14/community" >>/etc/apk/repositories
RUN apk update
RUN apk add --no-cache --virtual build-deps build-base
RUN apk add --no-cache icu-dev icu-libs
RUN apk add --no-cache cmake
RUN apk add --no-cache git

RUN gem install gollum -v ${GOLLUM_VERSION}
RUN gem install github-markdown && gem install github-linguist

RUN apk del cmake build-base build-deps icu-dev

# create a volume and
WORKDIR /wiki

ENV GOLLUMARGS=""

ENTRYPOINT ["/bin/sh", "-c", "git init && gollum $GOLLUMARGS"]
EXPOSE 4567
