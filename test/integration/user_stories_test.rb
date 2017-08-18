require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products
  fixtures :orders
  include ActiveJob::TestHelper

  test "buying a product" do

    start_order_count = Order.count
    ruby_book = products(:ruby)

    get '/'
    assert_response :success
    assert_select 'h1', 'Your Catalog'

    post '/line_items', params: {product_id: ruby_book.id}, xhr: true
    assert_response :success

    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product

    get '/orders/new'
    assert_response :success
    assert_select 'legend', 'Please enter your details'

    perform_enqueued_jobs do
      post '/orders', params: {
          order: {
              name: 'Dave Thomas',
              address: '123 Main Street',
              email: 'dave@example.org',
              pay_type: 'Check'
          }
      }

      follow_redirect!

      assert_response :success
      assert_select 'h1', 'Your Catalog'
      cart = Cart.find(session[:cart_id])
      assert_equal 0, cart.line_items.size

      assert_equal start_order_count + 1, Order.count
      order = Order.last

      assert_equal 'Dave Thomas', order.name
      assert_equal '123 Main Street', order.address
      assert_equal 'dave@example.org', order.email
      assert_equal 'Check', order.pay_type

      assert_equal 1, order.line_items.size
      line_item = order.line_items[0]
      assert_equal ruby_book, line_item.product

      mail = ActionMailer::Base.deliveries.last
      assert_equal ["dave@example.org"], mail.to
      assert_equal 'Sam Ruby <depot@example.com>', mail[:from].value
      assert_equal 'Order Confirmation', mail.subject
    end

  end

  test "update ship date" do
    order = orders(:one)

    get '/orders'
    assert_response :success
    assert_select 'h1', 'Orders'

    get "/orders/#{order.id}/edit"
    assert_response :success
    assert_select 'h1', 'Editing Order'

    perform_enqueued_jobs do
      patch "/orders/#{order.id}", params: {order: {id: order.id, ship_date: '2017-01-01'} }
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_select 'p', 'Order was successfully updated.'

      mail = ActionMailer::Base.deliveries.last
      assert_equal ["dave@example.org"], mail.to
      assert_equal 'Sam Ruby <depot@example.com>', mail[:from].value
      assert_equal 'Shipment Update', mail.subject
    end

  end

end
