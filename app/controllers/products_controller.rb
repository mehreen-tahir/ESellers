class ProductsController < ApplicationController

  before_filter :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:show, :index]

  respond_to :html

  def index
    @products = Product.ordered.search_for_index(params)
    @order_item = current_order.order_items.new
    respond_with(@products)
  end

  def show
    @review = @product.reviews.new
    @order_item = current_order.order_items.new
    respond_with(@product)
  end

  def new
    @product = Product.new
    @image = @product.images.new
    respond_with(@product)
  end

  def edit
  end

  def create
    @product = Product.new(params[:product])
    @product.user = current_user
    @product.save
    flash[:success] = "Product Sucessfully Created"
    respond_with(@product)
  end

  def update
    @product.update_attributes(params[:product])
    flash[:success] = "Product Sucessfully Updated"
    respond_with(@product)
  end

  def destroy
    @product.destroy
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

end
