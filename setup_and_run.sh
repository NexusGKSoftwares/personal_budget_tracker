#!/bin/bash

# Navigate to the project directory
 

# Check Ruby version
echo "Checking Ruby version..."
ruby -v || { echo "Ruby is not installed. Please install Ruby to proceed."; exit 1; }

# Install dependencies
echo "Installing dependencies..."
bundle install || { echo "Failed to install dependencies. Check your Gemfile."; exit 1; }

# Set up the database
if [ -f "db/db_setup.rb" ]; then
  echo "Setting up the database..."
  ruby db/db_setup.rb || { echo "Database setup failed. Check db/db_setup.rb for issues."; exit 1; }
else
  echo "db_setup.rb not found. Running migrations..."
  if command -v rake &>/dev/null; then
    rake db:migrate || { echo "Migrations failed. Ensure Rake is configured correctly."; exit 1; }
  else
    echo "Rake is not installed. Install Rake with 'gem install rake' and try again."; exit 1;
  fi
fi

# Run the main program
if [ -f "main.rb" ]; then
  echo "Running the main program..."
  ruby main.rb || { echo "Failed to run main.rb. Check for issues in the file."; exit 1; }
else
  echo "main.rb not found in the project directory."
  exit 1
fi

echo "Setup and execution completed successfully!"
