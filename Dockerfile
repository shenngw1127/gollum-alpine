FROM ruby

ENV GOLLUM_VERSION=5.2.3

RUN apt-get -y update && apt-get -y install libicu-dev cmake && rm -rf /var/lib/apt/lists/*
RUN gem install github-linguist
RUN gem install gollum -v ${GOLLUM_VERSION}

WORKDIR /wiki

ENV GOLLUMARGS=""

ENTRYPOINT ["/bin/sh", "-c", "git init && gollum $GOLLUMARGS"]
EXPOSE 4567
