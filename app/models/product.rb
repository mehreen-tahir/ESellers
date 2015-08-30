class Product < ActiveRecord::Base
  PER_PAGE = 5
  attr_accessible :description, :price, :title, :images_attributes, :reviews_attributes,:user_id
  validates :title, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  has_many :images, as: :imageable, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :order_item, dependent: :destroy

  belongs_to :user
  accepts_nested_attributes_for :images, allow_destroy: true

  scope :ordered, -> { order("created_at DESC") }
end
