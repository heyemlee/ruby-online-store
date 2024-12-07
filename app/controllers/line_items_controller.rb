class LineItemsController < ApplicationController
  include CurrentCart
  skip_before_action :authorize 
  before_action :set_cart
  before_action :set_line_item, only: [:update, :destroy]

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_index_url, notice: 'Product was successfully added to cart.' }
        format.js 
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @line_item.update(line_item_params)
      redirect_to @line_item.cart, notice: 'Quantity was successfully updated.'
    else
      redirect_to @line_item.cart, notice: 'Failed to update quantity.'
    end
  end

  def destroy
    cart = @line_item.cart
    @line_item.destroy
    redirect_to cart, notice: 'Item was successfully removed from cart.'
  end

  private
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def line_item_params
      params.require(:line_item).permit(:quantity)
    end
end
