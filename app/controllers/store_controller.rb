class StoreController < ApplicationController
  skip_before_action :authorize
  
  def index
    if params[:query].present?
      @products = Product.where('name LIKE ? OR description LIKE ?', 
                              "%#{params[:query]}%", 
                              "%#{params[:query]}%")
    else
      @products = Product.all
    end
    @cart = Cart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] = @cart.id
  end
end