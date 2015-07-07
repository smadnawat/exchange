class User < ActiveRecord::Base
  
  mount_uploader :picture, AvatarUploader
  has_secure_password
	has_many :books, :dependent => :destroy
  has_many :invitations, :dependent => :destroy
  has_many :notices, :dependent => :destroy
	has_many :reading_preferences, :dependent => :destroy
	has_many :devices, :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  has_many :ratings, :class_name => "Rating", :foreign_key => :ratable_id, dependent: :destroy
  has_many :recieve_notifications, :class_name => 'Notice',:foreign_key => 'reciever_id', :dependent => :destroy
  has_and_belongs_to_many :groups ,:join_table => "users_groups"
  has_many :messages, :class_name => 'Message',:foreign_key => 'sender_id',dependent: :destroy

  scope :users, -> { where(:is_block => false) }
  scope :blocked, -> { where(:is_block => true) }
	A = 'normal'
	B = 'facebook'
	C = 'google'

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode 
  before_save :about_me_update, :if => :new_record?
  before_save :weekly_date_update, :if => :new_record?
  validates :email, presence: true,  
						format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i , 
						message: "address should be valid."}
  validates_uniqueness_of :email, :message => "already exists."  
  validates :username, presence: true, :on => :create
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :username, :message => "already exists." , :on => :create
  accepts_nested_attributes_for :reading_preferences


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
      @user.update_attributes(:reset_password_token => Random.new.bytes(4).bytes.join[0,4])
      UserMailer.reset_password_mail(@user).deliver
    end  
  end  

  def about_me_update
      self.about_me = " "
  end

  def weekly_date_update
      self.weekly_date = Date.current    
  end

  def self.get_near_matches params 
      hash = Hash.new
      priority_first = [] 
      priority_second = []
      priority_third = []
      priority_forth = []
      priority_fifth = []
      priority_sixth = []
      priority_seventh = []
      priority_eighth = [] 
      priority_nineth = []

      @user = User.includes(:books,:reading_preferences).where(:id => params[:user_id]).first
      @books_max_range = @user.books.near([params[:lat],params[:long]], params[:range_end], :units => :km)
      @books_min_range = @user.books.near([params[:lat],params[:long]], params[:range_start], :units => :km)
      @books = @books_max_range - @books_min_range
      @user_preferences = @user.reading_preferences
      @user_author_pref = @user.author_prefernce
      @user_genre_pref = @user.genre_preference
      other_users = (User.includes(:books,:reading_preferences,:ratings).near([params[:lat],params[:long]], params[:range_end], :units => :km).reject{|u| u.id == @user.id})

      if @books.present? 
      @books.each do |book|
        other_users.each  do |other_user|
          if other_user.books.present?
            other_user.books.each do |other_users_book|

                if (other_user.reading_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:title).include?(book.title) && @user_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:title).include?(other_users_book.title))
                         
                          priority_first<<  self.matches_detail(other_user, book, other_users_book) 
                
                elsif (other_user.reading_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:author).include?(book.author) && @user_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:author).include?(other_users_book.author)) 
                         
                          priority_second<<  self.matches_detail(other_user, book, other_users_book)
                
                elsif (other_user.reading_preferences.map{|x| x if x.genre_deactivated == false}.compact.map(&:genre).include?(book.genre) && @user_preferences.map{|x| x if x.genre_deactivated == false}.compact.map(&:genre).include?(other_users_book.genre))        
                          
                          priority_third<<  self.matches_detail(other_user, book, other_users_book)

                elsif ((['Computer Books and Technology Books','Engineering Books','Study Guides & Test Prep','Education & Training','Medical Books and Reference'] & other_user.reading_preferences.map(&:genre)).include?(book.genre)) && (other_user.reading_preferences.map(&:isbn13).include?(book.isbn13)) 
                          
                          priority_forth<< self.matches_detail_for_genre_cases(other_user, book)

                elsif (other_user.books.map(&:author).include?(book.author) && @books.map(&:author).include?(other_users_book.author)) 
                         
                          priority_fifth<<   self.matches_detail(other_user, book, other_users_book)
               
                elsif (other_user.books.map(&:genre).include?(book.genre) && @books.map(&:genre).include?(other_users_book.genre))  
                          
                          priority_sixth<<   self.matches_detail(other_user, book, other_users_book)

                end
            end
          end
        end
      end 

     elsif @books.blank? 
             @user_max_range = (User.near([params[:lat],params[:long]], params[:range_end], :units => :km).reject{|u| u.id == @user.id})
             @user_min_range = (User.near([params[:lat],params[:long]], params[:range_start], :units => :km).reject{|u| u.id == @user.id})
             @other_user = @user_max_range - @user_min_range unless @user_max_range.blank? && @user_min_range.blank?
           
           if @other_user.present?
               @other_user.each do |other_userss|
                  if other_userss.books.blank?

                      if not(((other_userss.reading_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:author) & @user_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:author)).blank?) && ((other_userss.reading_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:genre) & @user_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:genre)).blank?)) 
                       
                        priority_seventh<<  self.match_hash_detail(other_userss)   
                      
                      elsif not((other_userss.reading_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:author) & @user_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:author)).blank?)
                        
                        priority_eighth<<  self.match_hash_detail(other_userss)
                      
                      elsif not((other_userss.reading_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:genre) & @user_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:genre)).blank?)          
                        
                        priority_nineth<<  self.match_hash_detail(other_userss)
                      
                      end
                  end
               end
           end
     end
      hash[:matches] = priority_first + priority_second + priority_third + priority_forth + priority_fifth + priority_sixth + priority_seventh + priority_eighth + priority_nineth
      return hash,hash[:matches].count
  end

  def self.matches_detail(other_user, book, other_users_book)
    match_hash = {}
    dis = other_user.distance.round(2)
    match_hash[:other_user_detail] = other_user.as_json(:only => [:picture,:username,:id]).merge(distance: dis)
    @rating = Rating.calculate_ratings(other_user)
    match_hash[:user_rating] = @rating
    match_hash[:book_to_give] = book.as_json(:only => [:id, :title,:author,:genre, :about_us, :image_path])
    match_hash[:book_to_get] = other_users_book.as_json(:only => [:id, :title,:author,:genre, :about_us, :image_path])
    match_hash
  end

  def self.match_hash_detail(other_user)
    match_hash = {}
    dis = other_user.distance.round(2)
    match_hash[:other_user_detail] = other_user.as_json(:only => [:picture,:username,:id]).merge(distance: dis)
    @rating = Rating.calculate_ratings(other_user)
    match_hash[:user_rating] = @rating
    match_hash
  end

  def self.matches_detail_for_genre_cases(other_user, book)
    match_hash = {}
    dis = other_user.distance.round(2)
    match_hash[:other_user_detail] = other_user.as_json(:only => [:picture,:username,:id]).merge(distance: dis)
    @rating = Rating.calculate_ratings(other_user)
    match_hash[:user_rating] = @rating
    match_hash[:book_to_give] = book.as_json(:only => [:id, :title,:author,:genre, :about_us, :image_path])
    match_hash
  end

  def update_via_social_media params
    self.update_attributes(username: params[:username],gender: params[:gender],email: params[:email],date_signup: params[:date_signup],picture: params[:picture], location: params[:location],latitude: params[:latitude], longitude: params[:longitude])
    unless self.devices.nil?
      Device.total_devices(params[:device_id],params[:device_type],self.id)
    end 
  end 

  def self.search_user_to_add_group(search)
    if search
      where('username LIKE ?', "%#{search}%")
    else
      all
    end
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
