class ProductsController < ApplicationController
  before_filter :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]

  respond_to :html

  def index
    @products = Product.ordered.includes(:images).page(params[:page]).per(Product::PER_PAGE)
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
    if params[:product][:reviews_attributes].present? and params[:product][:reviews_attributes].first.last[:user_id].to_i == @product.user_id.to_i
       flash[:notice] = "You can't review your own product!"
    else
      @product.update_attributes(params[:product])
    end
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
