class ReviewsController < ApplicationController

  before_filter :set_review, only: [:show, :edit, :update, :destroy]
  before_filter :set_product, except: [:index]

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
    @error = is_valid_review_user?
    return false if @error.present?
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
    return false unless valid_user?(@review.user)
    flash[:success] = "Review Sucessfully Updated"
    @review.update_attributes(params[:review])
    respond_with(@review.product)
  end

  def destroy
    return false unless valid_user?(@review.user) or valid_user?(@review.product.user)
    @review.destroy
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    def is_valid_review_user?
      if !(user_signed_in?)
        return "You need to Sign in before proceeding!"
      elsif valid_user?(@product.user)
        return "You can't review your own product!"
      end
    end

end
