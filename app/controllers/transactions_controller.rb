class TransactionsController < ApplicationController

  before_filter :authenticate_user!

  def new
    gon.client_token = generate_client_token
  end

  def create
    @result = Braintree::Transaction.sale(
              amount: cart_total_price,
              payment_method_nonce: params[:payment_method_nonce])
    if @result.success?
      current_order.update_attributes(status: "completed", user_id: current_user.id)
      UserMailer.order_transaction(current_user, current_order, cart_total_price).deliver
      session.delete(:order_id)
      redirect_to root_url, notice: "Congraulations! Your transaction has been successfull!"
    else
      flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
      redirect_to :back
    end
  end

  private

  def generate_client_token
    Braintree::ClientToken.generate
  end

end
