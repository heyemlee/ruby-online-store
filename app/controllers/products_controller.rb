class ProductsController < ApplicationController
  skip_before_action :authorize, only: [:index, :show, :search]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def search
    @query = params[:query].strip if params[:query].present?
    @products = Product.all

    if @query.present?
      @products = @products.where('lower(name) LIKE :query OR lower(description) LIKE :query', 
                                query: "%#{@query.downcase}%")
    end

    if params[:min_price].present?
      @products = @products.where('price >= ?', params[:min_price])
    end

    if params[:max_price].present?
      @products = @products.where('price <= ?', params[:max_price])
    end

    if params[:category].present?
      @products = @products.where(category: params[:category])
    end

    @products = @products.order(created_at: :desc)
    render :index
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: 'Product created successfully.'
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product has been deleted.'
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :image_url)
    end
end
