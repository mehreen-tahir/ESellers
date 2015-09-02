class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_order
  helper_method :valid_user?
  helper_method :discounted_price
  helper_method :cart_total_price

  def current_order
    if session[:order_id].present? & Order.exists?(session[:order_id])
      Order.find(session[:order_id])
    else
      order = Order.create(status: "in_progress")
   end
  end

  def valid_user? user
    user == current_user
  end

  def discounted_price discount_percentage
    current_order.orignal_price * (1-(discount_percentage/100.to_f))
  end

  def cart_total_price
     current_order.is_discounted ? current_order.discounted_price : current_order.orignal_price
  end
end
