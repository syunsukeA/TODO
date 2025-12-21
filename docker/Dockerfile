FROM ruby:3.3

ENV APP_HOME=/app
WORKDIR ${APP_HOME}

RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  git \
  curl \
  && rm -rf /var/lib/apt/lists/*

RUN gem update --system && gem update && gem install bundler

COPY Gemfile Gemfile.lock ./
RUN bundle install || true

COPY . .

# EXPOSE 3000
CMD ["bash", "-lc", "bin/rails s -b 0.0.0.0 -p 3000"]

