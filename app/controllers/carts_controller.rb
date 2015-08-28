class CartsController < ApplicationController

  respond_to :html

  def show
    @order_items = current_order.order_items.ordered.page(params[:page]).per(OrderItem::PER_PAGE)
    respond_with(@order_items)
  end

end
