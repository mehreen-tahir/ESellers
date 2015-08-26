class User < ActiveRecord::Base
  validates :username, length: { minimum: 5 }

  PER_PAGE = 10

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :products
  has_many :reviews
  has_one :image, as: :imageable, dependent: :destroy

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :image_attributes
  accepts_nested_attributes_for :image, allow_destroy: true

  def picture_url (*params)
    params.present? ? image.photo.url(params[0]) : image.photo.url
  end

end
