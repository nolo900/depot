SMTP_SETTINGS = {
    address: ENV.fetch("SMTP_ADDRESS"), # example: "smtp.sendgrid.net"
    authentication: :plain,
    domain: ENV.fetch("SMTP_DOMAIN"), # example: "heroku.com"
    enable_starttls_auto: true,
    #password: ENV.fetch("SMTP_PASSWORD"),
    password: ENV.fetch("GMAIL_PASSWORD"),
    #port: "587",
    port: 1025,
    #user_name: ENV.fetch("SMTP_USERNAME")
    user_name: ENV.fetch("GMAIL_USERNAME")
}