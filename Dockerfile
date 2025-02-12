# Use an official Ruby runtime as a parent image
FROM ruby:3.2.2

# Set the working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install bundler
RUN gem install bundler

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install Ruby dependencies
RUN bundle install

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Set the default command to run the app
CMD ["bundle", "exec", "ruby", "bin/research", "Quantum Machine Learning"]