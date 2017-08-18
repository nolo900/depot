class ShipmentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.shipment_mailer.shipment_notification.subject
  #
  def shipment_notification(order)
    @order = order
    mail to: order.email, subject: 'Shipment Update'
  end
end
