class UserMailer < ActionMailer::Base

  default from: "paymentsupport@eseller.com"

  def order_transaction(user, order, cart_total)
    @user = user
    @order = order
    @cart_total_price = cart_total

    mail to:  @user.email, subject: "Payment recipet."
  end

end
