module ProductsHelper

  def format_price price
    number_to_currency(price)
  end

  def valid_user? user
    user == current_user
  end

end
