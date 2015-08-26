class UserController < ApplicationController
  before_filter :set_user, only: [:show]
  respond_to :html

  def show
    @products = @user.products.includes(:images).page(params[:page]).per(User::PER_PAGE)
  end

  def dashboard
    @products = current_user.products.includes(:images, :reviews)
    @reviews = current_user.reviews.includes(:product)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
