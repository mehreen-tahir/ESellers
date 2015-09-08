class User < ActiveRecord::Base
  validates :username, length: { minimum: 5 }

  PER_PAGE = 6

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :products, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one :image, as: :imageable, dependent: :destroy

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :image_attributes
  accepts_nested_attributes_for :image, allow_destroy: true

  def picture_url (*params)
    params.present? ? image.photo.url(params[0]) : image.photo.url
  end

end
