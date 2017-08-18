class ErrorMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.error_mailer.notify_admin.subject
  #
  def notify_admin(info)
    @info = info

    mail to: "abm@austinbmiles.com", subject: 'Application Error'
  end
end
