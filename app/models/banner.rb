# require 'carrierwave/orm/activerecord'
class Banner < ActiveRecord::Base
  #include CarrierWave::MiniMagick
  mount_uploader :image, ImageUploader
  validates :image, presence: true 
  validates :banner_name, presence: true 
  validates :author_name, presence: true
  validates :link, presence: true,  
						format: { with:  /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix , 
						message: "Link should be in Proper Format."}

end
 
  