# Load the Rails application.
require_relative 'application'

# pull in SMTP reference
require Rails.root.join('config/smtp')

# Initialize the Rails application.
Rails.application.initialize!