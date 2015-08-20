class ReviewsController < ApplicationController
  before_filter :set_review, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @reviews = Review.all
    respond_with(@reviews)
  end

  def show
    respond_with(@review)
  end

  def new
    @review = Review.new
    respond_with(@review)
  end

  def edit
  end

  def create
    @review = Review.new(params[:review])
    @review.product = @product
    @review.user = current_user
    @review.save
    respond_with(@review)
  end

  def update
    @review.update_attributes(params[:review])
    redirect_to @review.product
  end

  def destroy
    if @review.user.eql? current_user or @review.product.user.eql? current_user
      @review.destroy
    else
      flash[:notice] = "You do not have the acess to delete!"
    end
    redirect_to :back
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end
end
