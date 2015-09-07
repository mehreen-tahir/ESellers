class OrderItemsController < ApplicationController

  def create
    @error = is_valid_order_item
    return false if @error.present?
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

  def is_valid_order_item
    product = params[:order_item]
    product_item = Product.find(product["product_id"])
    if current_order.order_items.exists?(product)
      return "Item is already in cart!"
    elsif Product.exists?(product["product_id"]) and valid_user? product_item.user
      return "You can not add your own item to cart!"
    end
  end

end
