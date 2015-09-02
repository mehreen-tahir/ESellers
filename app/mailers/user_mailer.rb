class UserMailer < ActionMailer::Base

  default from: "paymentsupport@eseller.com"

  def order_transaction(user, order)
    @user = user
    @order = order

    mail to:  @user.email, subject: "Payment recipet."
  end

end
