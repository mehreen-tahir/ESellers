class Product < ActiveRecord::Base

  PER_PAGE = 9
  attr_accessible :description, :price, :title, :images_attributes, :reviews_attributes,:user_id, :delta
  validates :title, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  has_many :images, as: :imageable, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :order_item, dependent: :destroy

  belongs_to :user
  accepts_nested_attributes_for :images, allow_destroy: true

  scope :ordered, -> { order("created_at DESC") }

  define_index do
    indexes title
    indexes description
    indexes reviews.description, as: :review_description

    set_property delta: true
  end

  def self.search_for_index(params)
    params = {} if params.blank?
    search_params = default_search_options(params)
    search_params[:include] = :images
    Product.search params[:search], search_params
  end

  def self.default_search_options(pagination_options)
    {
       with: {},
       page: pagination_options[:page],
       per_page: Product::PER_PAGE
    }
  end

end
