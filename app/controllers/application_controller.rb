class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_order
  helper_method :valid_user?
  helper_method :discounted_price

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

end
