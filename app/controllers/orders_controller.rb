class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :ensure_cart_isnt_empty, only: :new
  before_action :set_order, only: [:show, :edit, :update]

  def index
    if current_user.admin?
      @orders = Order.all.order(created_at: :desc)
    else
      @orders = current_user.orders.order(created_at: :desc)
    end
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user

    begin
      Order.transaction do
        @order.add_line_items_from_cart(@cart)
        @order.save!
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        redirect_to orders_path, notice: 'Order was successfully created.'
      end
    rescue => e
      logger.error "Error creating order: #{e.message}"
      render :new
    end
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'Order has been updated'
    else
      render :edit
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:name, :email, :address, :payment_type)
    end

    def ensure_cart_isnt_empty
      if @cart.line_items.empty?
        redirect_to store_index_url, notice: 'Your cart is empty'
      end
    end

    def current_user
      @current_user ||= User.find(session[:user_id])
    end
end
