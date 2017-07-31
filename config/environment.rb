# Load the Rails application.
require_relative 'application'

# pull in SMTP reference
require Rails.root.join('config/smtp')

# Initialize the Rails application.
Rails.application.initialize!


Rails.application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = SMTP_SETTINGS
  config.action_mailer.default_url_options = { host: "localhost:3000" }
end