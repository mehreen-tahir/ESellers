class Image < ActiveRecord::Base
  attr_accessible :imageable_id, :imageable_type, :photo
  belongs_to :iageable, polymorphic: true

  has_attached_file :photo, 
                    styles: { 
                      medium: "300x300!",
                      thumb: "100x100!",
                      small: "50x50!"
                    },
                    default_url: "/assets/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
end
