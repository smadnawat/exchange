class User < ActiveRecord::Base
  # mount_uploader :image,ImageUploader
  has_secure_password

	has_many :books, :dependent => :destroy
	has_many :reading_preferences, :dependent => :destroy
	has_many :devices, :dependent => :destroy
  scope :users, -> { where(:is_block => false) }
  scope :blocked, -> { where(:is_block => true) }
	A = 'normal'
	B = 'facebook'
	C = 'google'

  validates :email, presence: true,  
						format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i , 
						message: "address should be valid."}
  validates_uniqueness_of :email, :message => "already exists."  

  def update_via_social_media params
  	self.update_attributes(username: params[:username],gender: params[:gender],email: params[:email],date_signup: params[:date_signup],picture: [:picture], location: params[:location],latitude: params[:latitude], longitude: params[:longitude])
    unless self.devices.nil?
      Device.total_devices(params[:device_id],params[:device_type],self.id)
      #self.devices.last.update_attributes(:device_id=>params[:device_id], :device_type=>params[:device_type])
    end 
  end	

  def self.create_via_social_media params
    p  "=-------------------#{params}"
  	@user = User.create!(params).permit!
    Device.total_devices(params[:device_id],params[:device_type],@user.id)
    return @user 				
  end

end
