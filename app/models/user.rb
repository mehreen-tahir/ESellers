class User < ActiveRecord::Base
  validates :username, length: { minimum: 5 }
  # Include default devise modules. Others available are:
  #:lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :products
  has_many :reviews
  has_one :image, as: :imageable, dependent: :destroy
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :image_attributes
  accepts_nested_attributes_for :image, allow_destroy: true
  # attr_accessible :title, :body
  def picture_url (*params)
    params.present? ? image.photo.url(params[0]) : image.photo.url
  end
  # attr_accessible :title, :body
end
