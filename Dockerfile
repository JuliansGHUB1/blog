FROM ruby:3.2

WORKDIR /app

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

# CHANGED: force production mode during build
# (assets compiled in dev mode are ignored in prod)
ENV RAILS_ENV=production

# CHANGED: allow Rails to serve /public/assets in production
ENV RAILS_SERVE_STATIC_FILES=true

# CHANGED: THIS IS THE ACTUAL FIX
# precompile CSS/JS so they physically exist in the container
# SECRET_KEY_BASE_DUMMY avoids needing real credentials at build time
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

EXPOSE 3000

# CHANGED: removed db:migrate from CMD
# CMD should only start the server
CMD ["bash", "-c", "bundle exec rails server -b 0.0.0.0 -p $PORT"]

