class Product < ActiveRecord::Base
  PER_PAGE = 5
  attr_accessible :description, :price, :title, :images_attributes

  has_many :images, as: :imageable
  belongs_to :user
  accepts_nested_attributes_for :images, allow_destroy: true

  scope :ordered, -> { order("created_at DESC") }
end
