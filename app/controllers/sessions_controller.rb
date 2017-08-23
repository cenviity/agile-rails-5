class SessionsController < ApplicationController
  skip_before_action :authorise
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_login

  def new
  end

  def create
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    else
      invalid_login
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_index_url, notice: "Logged out"
  end
  
  private
  
    def user
      if User.count.zero?
        User.create!(name: params[:name], password: params[:password])
      else
        User.find_by(name: params[:name])
      end
    end
    
    def invalid_login
      redirect_to login_url, alert: "Invalid user/password combination"
    end
end
