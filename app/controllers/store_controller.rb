class StoreController < ApplicationController
  skip_before_action :authorise
  include CurrentCart
  before_action :set_cart
  
  def index
    if params[:set_locale]
      redirect_to store_index_url(locale: params[:set_locale])
    else
      @products = Product.where(locale: I18n.locale).order(:title)
    end
  end
end
