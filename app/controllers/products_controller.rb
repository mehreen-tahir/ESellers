class ProductsController < ApplicationController
  before_filter :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]

  respond_to :html

  def index
    @products = Product.ordered.page(params[:page]).per(Product::PER_PAGE)
    respond_with(@products)
  end

  def show
    respond_with(@product)
  end

  def new
    @product = Product.new
    @image = @product.images.new
    @review = @product.reviews.new
    respond_with(@product)
  end

  def edit
  end

  def create
    @product = Product.new(params[:product])
    @product.user = current_user
    @product.save
    respond_with(@product)
  end

  def update
    @product.update_attributes(params[:product])
    respond_with(@product)
  end

  def destroy
    @product.destroy
    respond_with(@product)
  end

  def profile
    @products = Product.where("user_id = ?", current_user).ordered.includes(:images).page(params[:page]).per(Product::PER_PAGE)
    @reviews = Review.where("user_id = ?", current_user)
    respond_with(@products)
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end
end
