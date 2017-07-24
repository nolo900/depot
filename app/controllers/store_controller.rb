class StoreController < ApplicationController
  include VisitCounter
  before_action :set_visit_counter, only: [:index]

  def index
    @products = Product.order(:title)

    @counter = session[:visit_counter]
  end

end
