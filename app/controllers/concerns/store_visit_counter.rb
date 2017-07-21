module StoreVisits

  private

    def set_store_visit_counter
      @store_visit_counter = session[:store_visit_counter]
    end

end