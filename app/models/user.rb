class User < ActiveRecord::Base
  
  mount_uploader :picture, AvatarUploader

  has_secure_password

	has_many :books, :dependent => :destroy
  has_many :invitations, :dependent => :destroy
  has_many :notifications, :dependent => :destroy
	has_many :reading_preferences, :dependent => :destroy
	has_many :devices, :dependent => :destroy
  #has_many :send_notifications, :dependent => :destroy, :class_name => 'Notification',:foreign_key => 'user_id', :dependent => :destroy
  has_many :recieve_notifications, :class_name => 'Notification',:foreign_key => 'reciever_id', :dependent => :destroy

	A = 'normal'
	B = 'facebook'
	C = 'google'

  validates :email, presence: true,  
						format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i , 
						message: "address should be valid."}
  validates_uniqueness_of :email, :message => "already exists."  

  validates :username, presence: true, :on => :create
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :username, :message => "already exists." , :on => :create

  def self.image_data(data)
    return nil unless data
    io = CarrierStringIO.new(Base64.decode64(data)) 
  end

  def update_via_social_media params
  	self.update_attributes(username: params[:username],gender: params[:gender],email: params[:email],picture: params[:picture], location: params[:location],latitude: params[:latitude], longitude: params[:longitude])
    unless self.devices.nil?
      Device.total_devices(params[:device_id],params[:device_type],self.id)
    end 
  end	

  def self.send_token user 
    @user = user  
    if @user
      @user.update_attributes(:reset_password_token => (SecureRandom.urlsafe_base64))
      UserMailer.reset_password_mail(@user).deliver
    end  
  end  

  def self.get_near_locations params 
      hash = Hash.new
      hash[:priority_first] = [] 
      hash[:priority_second] = []
      hash[:priority_third] = []
      hash[:priority_forth] = []
      hash[:priority_fifth] = []
      hash[:priority_sixth] = []
      hash[:priority_seventh] = []
      hash[:priority_eighth] = []

      params[:range] = "1" if params[:range] == "0" 
      @user = User.find(params[:user_id])
      @books = @user.books.near([params[:lat],params[:long]], params[:range], :units => :km)
      @user_preferences = @user.reading_preferences
      @books.each do |book|
        (User.all.reject{|u| u.id == @user.id}).each  do |other_user|
          other_user.books.each do |other_users_book|
            match_hash = {}
            if (other_user.reading_preferences.pluck(:title).include?(book.title) && @user_preferences.pluck(:title).include?(other_users_book.title))
                           
                            match_hash[:other_user_detail] = other_user.as_json(:only => [:picture,:username,:id])
                            match_hash[:book_to_give] = book.as_json(:only => [:title,:author,:genre])
                            match_hash[:book_to_get] = other_users_book.as_json(:only => [:title,:author,:genre])

                            hash[:priority_first]<<  match_hash
            
            elsif (other_user.reading_preferences.pluck(:author).include?(book.author) && @user_preferences.pluck(:author).include?(other_users_book.author))
              
                            match_hash[:other_user_detail] = other_user.as_json(:only => [:picture,:username,:id])
                            match_hash[:book_to_give] = book.as_json(:only => [:title,:author,:genre])
                            match_hash[:book_to_get] = other_users_book.as_json(:only => [:title,:author,:genre])

                            hash[:priority_second]<<  match_hash


            elsif (other_user.reading_preferences.pluck(:genre).include?(book.genre) && @user_preferences.pluck(:genre).include?(other_users_book.genre))       
                         
                            match_hash[:other_user_detail] = other_user.as_json(:only => [:picture,:username,:id])
                            match_hash[:book_to_give] = book.as_json(:only => [:title,:author,:genre])
                            match_hash[:book_to_get] = other_users_book.as_json(:only => [:title,:author,:genre])

                            hash[:priority_third]<<  match_hash

            elsif  (other_user.books.pluck(:author).include?(book.author) && @books.map(&:author).include?(other_users_book.author)) 
                            
                            match_hash[:other_user_detail] = other_user.as_json(:only => [:picture,:username,:id])
                            match_hash[:book_to_give] = book.as_json(:only => [:title,:author,:genre])
                            match_hash[:book_to_get] = other_users_book.as_json(:only => [:title,:author,:genre])

                            hash[:priority_forth]<<  match_hash

            elsif   (other_user.books.pluck(:genre).include?(book.genre) && @books.map(&:genre).include?(other_users_book.genre))  

                            match_hash[:other_user_detail] = other_user.as_json(:only => [:picture,:username,:id])
                            match_hash[:book_to_give] = book.as_json(:only => [:title,:author,:genre])
                            match_hash[:book_to_get] = other_users_book.as_json(:only => [:title,:author,:genre])

                            hash[:priority_fifth]<<  match_hash

            elsif not(((other_user.reading_preferences.pluck(:author) & @user_preferences.map(&:author)).blank?) && ((other_user.reading_preferences.pluck(:genre) & @user_preferences.map(&:genre)).blank?)) 

                            match_hash[:other_user_detail] = other_user.as_json(:only => [:picture,:username,:id])
                            match_hash[:book_to_give] = book.as_json(:only => [:title,:author,:genre])
                            match_hash[:book_to_get] = other_users_book.as_json(:only => [:title,:author,:genre])

                            hash[:priority_sixth]<<  match_hash
             
            elsif not((other_user.reading_preferences.pluck(:author) & @user_preferences.map(&:author)).blank?)
                
                            match_hash[:other_user_detail] = other_user.as_json(:only => [:picture,:username,:id])
                            match_hash[:book_to_give] = book.as_json(:only => [:title,:author,:genre])
                            match_hash[:book_to_get] = other_users_book.as_json(:only => [:title,:author,:genre])

                            hash[:priority_seventh]<<  match_hash

            else not((other_user.reading_preferences.pluck(:genre) & @user_preferences.map(&:genre)).blank?)          
                           

                            match_hash[:other_user_detail] = other_user.as_json(:only => [:picture,:username,:id])
                            match_hash[:book_to_give] = book.as_json(:only => [:title,:author,:genre])
                            match_hash[:book_to_get] = other_users_book.as_json(:only => [:title,:author,:genre])

                            hash[:priority_eighth]<<  match_hash
            end
          end
        end
      end
      return hash
  end

  private

  def self.dist params,lati,longi    
     distance_in_miles = Geocoder::Calculations.distance_between([ params[:lat],params[:long] ], [lati,longi])
     return @distance_in_km = (distance_in_miles/0.62137).round(2)
  end

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
