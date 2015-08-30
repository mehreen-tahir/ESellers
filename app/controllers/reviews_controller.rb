class ReviewsController < ApplicationController
  before_filter :set_review, only: [:show, :edit, :update, :destroy]
  before_filter :set_product, except: [:index]
  before_filter :authenticate_user!, :except => [:show, :index]

  respond_to :html

  def index
    @reviews = Review.all
    respond_with(@reviews)
  end

  def show
    @review = Review.new
    respond_with(@review)
  end

  def new
    @review = Review.new
    respond_with(@review)
  end

  def edit
  end

  def create
    return false if @product.user == current_user
    @review = @product.reviews.new(params[:review])
    @review.user = current_user
    respond_to do |format|
      if  @review.save
        format.html { redirect_to @review.product, notice: 'Review was successfully created.' }
        format.js
      else
        format.html { render action: "new" }
        format.js
      end
    end
  end

  def update
    return false unless @review.user == current_user
    @review.update_attributes(params[:review])
    respond_with(@review.product)
  end

  def destroy
    return false unless @review.user == current_user or @review.product.user == current_user
    @review.destroy
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

end
