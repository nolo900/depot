require 'test_helper'

class ShipmentMailerTest < ActionMailer::TestCase
  test "shipment_notification" do
    mail = ShipmentMailer.shipment_notification(orders(:one))
    assert_equal "Shipment Update", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /Programming Ruby 1.9/, mail.body.encoded
  end

end
