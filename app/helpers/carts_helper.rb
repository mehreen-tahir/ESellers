module CartsHelper

  def cart_total_price
    total_amount = current_order.order_items.collect(&:product).collect(&:price).sum
    number_to_currency(total_amount)
  end

end
