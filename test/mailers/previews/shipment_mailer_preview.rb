# Preview all emails at http://localhost:3000/rails/mailers/shipment_mailer
class ShipmentMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/shipment_mailer/shipment_notification
  def shipment_notification
    ShipmentMailer.shipment_notification
  end

end
