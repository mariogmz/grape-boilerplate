FROM ruby:2.7.1-alpine
ENV APP_ROOT /var/www/current
ENV PORT 3000

# Dependencies
RUN apk --no-cache add build-base coreutils linux-headers autoconf \
                       zlib-dev libressl-dev libffi-dev yaml-dev

# Set working directory
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

# Add gems
RUN bundle config --global frozen 1
COPY Gemfile* $APP_ROOT/
RUN gem update --system && \
    gem install bundle
RUN bundle install

# Copy project files
COPY . $APP_ROOT

EXPOSE $PORT
CMD ["/bin/sh", "-c", "bundle exec rackup -p $PORT --host 0.0.0.0"]
