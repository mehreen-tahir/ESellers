class Order < ActiveRecord::Base
  attr_accessible :session_id, :status

  has_many :order_items, dependent: :destroy
end
