class Product < ActiveRecord::Base
  PER_PAGE = 5
  attr_accessible :description, :price, :title, :images_attributes, :reviews_attributes,:user_id

  has_many :images, as: :imageable
  has_many :reviews
  belongs_to :user
  accepts_nested_attributes_for :images, allow_destroy: true

  scope :ordered, -> { order("created_at DESC") }
end
