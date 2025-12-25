FROM ruby:3.2

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install Ruby gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy app code
COPY . .

# Expose port (Render sets $PORT)
EXPOSE 3000

# Start app (run migrations at runtime, then boot)
CMD ["bash", "-c", "bundle exec rails db:migrate && bundle exec rails server -p $PORT -e production"]

