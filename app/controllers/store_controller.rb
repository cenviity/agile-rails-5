class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    
    session[:counter] ||= 1
    session[:counter] += 1
    @index_views = session[:counter]
  end
end
