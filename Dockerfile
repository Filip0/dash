FROM ruby:alpine

WORKDIR /dashboard

USER root

ENV GEM_HOME /dashboard/.bundle
ENV BUNDLE_PATH="$GEM_HOME" \
    BUNDLE_BIN="$GEM_HOME/bin" \
    BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH $BUNDLE_BIN:$PATH

RUN apk update
RUN apk add make gcc g++ nodejs

RUN gem install dashing bundler

COPY . /dashboard

RUN addgroup dashing \
    && adduser -S -G dashing dashing \
    && chown -R dashing:dashing /dashboard

USER dashing

RUN bundle

EXPOSE 3030

ENTRYPOINT ["dashing"]
CMD ["start", "-p", "3030"]

