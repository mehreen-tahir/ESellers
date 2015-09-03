class UserController < ApplicationController
  before_filter :set_user, only: [:show]
  respond_to :html

  def show
    @products = @user.products.includes(:images).page(params[:page]).per(User::PER_PAGE)
    @order_item = current_order.order_items.new
  end

  def dashboard
    @products = current_user.products.includes(:images, :reviews).page(params[:page]).per(User::PER_PAGE)
    @reviews = current_user.reviews.includes(:product).page(params[:reviews]).per(User::PER_PAGE)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
