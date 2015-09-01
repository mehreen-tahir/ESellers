class Order < ActiveRecord::Base
  attr_accessible :session_id, :status, :orignal_price, :discounted_price, :is_discounted
  validates :orignal_price, numericality: { greater_than_or_equal_to: 0 }
  validates :discounted_price, numericality: { greater_than_or_equal_to: 0 }

  has_many :order_items, dependent: :destroy
end
