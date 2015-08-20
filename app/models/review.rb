class Review < ActiveRecord::Base
  validates :description, presence: true
  attr_accessible :description, :product_id, :user_id
  belongs_to :product
  belongs_to :user
end
