class Message < ActiveRecord::Base
  mount_uploader :media, AvatarUploader
  belongs_to :group
  belongs_to :user,:class_name => 'User',:foreign_key => 'sender_id'
end

class CarrierStringIO < StringIO
  def original_filename
    # the real name does not matter
    "photo.jpeg"
  end

  def content_type
    # this should reflect real content type, but for this example it's ok
    "image/jpeg"
  end
end
