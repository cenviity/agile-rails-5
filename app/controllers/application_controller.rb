class ApplicationController < ActionController::Base
  before_action :authorise
  protect_from_forgery with: :exception
  
  protected
  
    def authorise
      unless User.find_by(id: session[:user_id])
        if request.format == Mime[:html]
          redirect_to login_url, notice: "Please log in"
        else
          authenticate_or_request_with_http_basic do |name, password|
            user = User.find_by(name: name)
            user&.authenticate(password)
          end
        end
      end
    end
end
