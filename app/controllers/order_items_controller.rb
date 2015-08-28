class OrderItemsController < ApplicationController

  def create
    @order = current_order
    @order_item = @order.order_items.new(params[:order_item])
    @order_item.save
    session[:order_id] = @order.id
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    redirect_to :back
  end

end
