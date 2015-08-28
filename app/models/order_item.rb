class OrderItem < ActiveRecord::Base
  PER_PAGE = 25

  attr_accessible :product_id, :order_id

  belongs_to :order
  belongs_to :product

  scope :ordered, -> { order("created_at DESC") }
end
