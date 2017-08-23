class ApplicationController < ActionController::Base
  before_action :authorise
  protect_from_forgery with: :exception
  
  protected
  
    def authorise
      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: "Please log in"
      end
    end
end
