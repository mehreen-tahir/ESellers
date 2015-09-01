class Discount < ActiveRecord::Base
  attr_accessible :coupon, :status, :discount_percentage
  scope :get_coupon, -> (coupon) { where(coupon: coupon, status: true) }
end
