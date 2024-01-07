#!/bin/bash

# Function to display error messages
function display_error {
  echo "Error: $1" >&2
}
# Step 1: Install Ruby and Node.js
asdf install ruby 3.3.0 || display_error "Failed to install Ruby"
asdf global ruby 3.3.0
gem update --system
asdf install nodejs 20.10.0 || display_error "Failed to install Node.js"
asdf global nodejs 20.10.0

# Step 2: Install dependencies
npm install -g yarn || display_error "Failed to install Yarn"
gem install rails -v 7.1.2 || display_error "Failed to install Rails"

# Step 3: Setup PostgreSQL
sudo apt install postgresql libpq-dev || display_error "Failed to install PostgreSQL"

# Step 4: Gems and Tailwind CSS Setup
bundle install

rails tailwindcss:install || display_error "Failed to install Tailwind CSS"
rake db:create || display_error "Failed to create the database"
bin/importmap pin tailwindcss-stimulus-components || display_error "Failed to pin Tailwind CSS Stimulus Components"

# Step 5: Run the application
bin/dev || display_error "Failed to run the application"
