module VisitCounter

  private

    def set_visit_counter
      if session[:visit_counter].nil?
        session[:visit_counter] = 1
        return session[:visit_counter]
      end

      session[:visit_counter] = session[:visit_counter] + 1
    end

end