class StoreController < ApplicationController
  def index
    @products = Product.order(:title)

    @counter = session[:counter]
  end
end
