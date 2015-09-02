class CartsController < ApplicationController

  respond_to :html

  def show
    @order_items = current_order.order_items.ordered.page(params[:page]).per(OrderItem::PER_PAGE)
    @order_items.count == 0 ? (render "no_items.html.erb") : respond_with(@order_items)
  end

  def destroy
    current_order.destroy
  end

  def apply_discount
    return false if current_order.is_discounted
    @coupon = Discount.get_coupon(params[:coupun][:discount_coupon]).last
    if @coupon.present?
      @discounted_price = discounted_price @coupon.discount_percentage
      current_order.update_attributes(discounted_price: @discounted_price, is_discounted: true)
    end
  end

end
