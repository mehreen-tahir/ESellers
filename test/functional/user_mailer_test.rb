require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "order_transaction" do
    mail = UserMailer.order_transaction
    assert_equal "Order transaction", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
