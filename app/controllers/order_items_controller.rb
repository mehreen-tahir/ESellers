class OrderItemsController < ApplicationController

  def create
    return false if current_order.order_items.exists?(params[:order_item])
    @order = current_order
    @order_item = @order.order_items.new(params[:order_item])
    @order_item.save
    session[:order_id] = @order.id
    update_cart_price
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    update_cart_price
  end

  private

  def update_cart_price
     order_price = current_order.order_items.collect(&:product).collect(&:price).sum
     current_order.update_attribute(:orignal_price, order_price)
  end

end
