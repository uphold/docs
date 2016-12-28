FROM ruby:2.3.1-slim

WORKDIR /usr/src/app

ENV SLATE_VERSION=1.2.1

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential \
  && curl -L https://github.com/lord/slate/archive/v$SLATE_VERSION.tar.gz | tar -zxv -C /tmp \
  && mv /tmp/slate-$SLATE_VERSION/* /usr/src/app/ \
  && rm -rf /tmp/slate-$SLATE_VERSION \
  && bundle install \
  && apt-get purge -y build-essential \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 4567

COPY source ./source

CMD ["bundle", "exec", "middleman", "server"]
