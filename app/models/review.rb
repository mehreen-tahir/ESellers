class Review < ActiveRecord::Base
  validates :description, presence: true
  attr_accessible :description
end
