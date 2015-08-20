class Review < ActiveRecord::Base
  validates :description, presence: true
  attr_accessible :description, :product_id
  belongs_to :product
end
