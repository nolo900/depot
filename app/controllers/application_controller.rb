class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorize


  # rescue_from ActiveRecord::RecordNotFound, with: :general_not_found_handler
  #   # handle not found error
  # rescue_from ActiveRecord::ActiveRecordError, with: :general_not_found_handler
  #   # handle other ActiveRecord errors
  # rescue_from StandardError, with: :general_not_found_handler
  #   # handle most other errors
  # rescue_from Exception, with: :general_not_found_handler
  #   # handle everything else

  protected
  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: 'Please login'
    end
  end

  private
  def general_not_found_handler
    info = "User hit invalid URL #{request.url}"
    logger.error(info)
    ErrorMailer.notify_admin(info).deliver_now
    redirect_to store_index_path, notice: 'Page Not Found'
  end

end
