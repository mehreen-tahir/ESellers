class Review < ActiveRecord::Base

  after_save :set_product_delta_flag
  after_destroy :set_product_delta_flag

  validates :description, presence: true
  attr_accessible :description, :product_id, :user_id
  belongs_to :product
  belongs_to :user

  private

  def set_product_delta_flag
    product.delta = true
    product.save
  end

end
