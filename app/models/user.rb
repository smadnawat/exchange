require 'set'

class User < ActiveRecord::Base
  
  mount_uploader :picture, AvatarUploader
  has_secure_password
	has_many :books, :dependent => :destroy
  has_many :invitations, :dependent => :destroy
  has_many :notices, :dependent => :destroy
	has_many :reading_preferences, :dependent => :destroy
	has_many :devices, :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  has_many :rev_ratings, :class_name => "Rating", :foreign_key => :ratable_id, dependent: :destroy
  has_many :recieve_notifications, :class_name => 'Notice',:foreign_key => 'reciever_id', :dependent => :destroy
  has_many :user_groups, :dependent => :destroy
  has_many :groups ,:through => :user_groups, :dependent => :destroy
  has_many :messages, :class_name => 'Message',:foreign_key => 'sender_id',dependent: :destroy
  has_many :blocks, :class_name => "Block", :foreign_key => :user_id, dependent: :destroy
  accepts_nested_attributes_for :reading_preferences  
  scope :users, -> { where(:is_block => false) }
  scope :blocked, -> { where(:is_block => true) }
	A = 'normal'
	B = 'facebook'
	C = 'google'

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
  before_create :generate_unsubscribe_token
  before_save :about_me_update, :if => :new_record?
  before_save :weekly_date_update, :if => :new_record?
  validates :email, presence: true,  
						format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i , 
						message: "address should be valid."}
  validates_uniqueness_of :email, :message => "already exists."  
  validates :username, presence: true, :on => :create
  validates_presence_of :password, :on => :create
  # validates_uniqueness_of :username, :message => "already exists." , :on => :create
  accepts_nested_attributes_for :reading_preferences

  def generate_token
    random_token = ""
    loop do
      random_token = SecureRandom.hex(n=16)
      break random_token unless User.exists?(mat_email_token: random_token)
    end
    self.update_attributes(mat_email_token: random_token)
    self
  end 

  def generate_unsubscribe_token
    random_token = ""
    loop do
      random_token = SecureRandom.hex(n=16)
      break random_token unless User.exists?(unsubscription_token: random_token)
    end
    self.unsubscription_token = random_token
  end 

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

  def self.generate_sign_in_token(user)
    @user = user
    if @user
      @user.update_attributes(:sign_in_token => SecureRandom.urlsafe_base64)
      UserMailer.registration_confirmation(@user, "#{@user.sign_in_token}").deliver
    end
  end

  def self.send_token user 
    @user = user  
    if @user
      @user.update_attributes(:reset_password_token => Random.new.bytes(4).bytes.join[0,4], :reset_password_sent_at => Time.now)
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
      priority_first =Set.new 
      priority_second = Set.new
      priority_third = Set.new
      priority_forth = Set.new
      priority_fifth = Set.new
      priority_sixth = Set.new
      priority_seventh = Set.new
      priority_eighth = Set.new 
      priority_nineth = Set.new
      education_case = ['Education - School','Education - Undergrad - Art & Design','Education - Undergrad - Aeronautics','Education - Undergrad - Business Studies / Eco','Education - Undergrad - Drama', 'Education - Undergrad - Engineering', 'Education - Undergrad - Geography', 'Education - Undergrad - History', 'Education - Undergrad - Law', 'Education - Undergrad - Literature / English', 'Education - Undergrad - Maths', 'Education - Undergrad - Medicine', 'Education - Undergrad - Music', 'Education - Undergrad - Science', 'Education - Undergrad - Social Science', 'Education - Undergrad - Technology', 'Education - Undergrad - Others', 'Education - Postgrad - Business / Finance', 'Education - Postgrad - History', 'Education - Postgrad - Marketing', 'Education - Postgrad - Maths', 'Education - Postgrad - Medicine', 'Education - Postgrad - Technology', 'Education - Postgrad - Others']

      @user = User.find_by(:id => params[:user_id])
      @user_preferences = @user.reading_preferences

      if params[:is_week_news].present?
        @books = @user.books     
        @other_users = (User.includes(:books,:reading_preferences,:ratings).near([@user.latitude,@user.longitude], 100, :units => :km).reject{|u| u.id == @user.id})
      else
        @books_max_range = @user.books.near([params[:lat],params[:long]], params[:range_end], :units => :km)
        @books_min_range = @user.books.near([params[:lat],params[:long]], params[:range_start], :units => :km)
        @books = @books_max_range - @books_min_range
        logger.info"===========================#{@books.count}---------------33333333333333"
        @other_users = (User.includes(:books,:reading_preferences,:ratings).near([params[:lat],params[:long]], params[:range_end], :units => :km).reject{|u| u.id == @user.id})
        logger.info"=======================#{@other_users.map(&:id)}=================other_user"
      end


      if @books.present? 
        @other_users.each  do |other_user|

          book_title = other_user.books.reject{|x|education_case.include?(x.genre)}.select{|x|@user_preferences.select{|x|(x.by_scanning == false && x.book_deactivated == false && x.title!="")}.map(&:title).map{|x|x.split(' ')[0,5].join('').upcase}.include?(x["title"].split(' ')[0,5].join('').upcase)}
          book_author = other_user.books.reject{|x|education_case.include?(x.genre)}.select{|x|@user_preferences.select{|x|(x.by_scanning == false && x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false && x.author!="")}.map(&:author).map{|x|x.split(' ')[0,5].join('').upcase}.include?(x["author"].split(' ')[0,5].join('').upcase)}
          book_genre = other_user.books.reject{|x|education_case.include?(x.genre)}.select{|x|@user_preferences.select{|x|(x.by_scanning == false && x.book_deactivated == false && x.genre_deactivated == false && x.delete_genre == false && x.genre!="")}.map(&:genre).map{|x|x.split(' ')[0,5].join('').upcase}.include?(x["genre"].split(' ')[0,5].join('').upcase)}
          book_author_n = other_user.books.reject{|x|education_case.include?(x.genre)}.select{|x|@user_preferences.select{|x|(x.by_scanning == true && x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false && x.author!="")}.map(&:author).map{|x|x.split(' ')[0,5].join('').upcase}.include?(x["author"].split(' ')[0,5].join('').upcase)}
          book_genre_n = other_user.books.reject{|x|education_case.include?(x.genre)}.select{|x|@user_preferences.select{|x|(x.by_scanning == true && x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false && x.genre!="")}.map(&:genre).map{|x|x.split(' ')[0,5].join('').upcase}.include?(x["genre"].split(' ')[0,5].join('').upcase)}
          @books.each do |book|
            unless education_case.include?(book.genre)
              book_title.each do |other_users_book_title|
                priority_first << matches_detail(other_user, book, other_users_book_title, @user)
              end if (other_user.reading_preferences.select{|x|(x.book_deactivated == false && x.title!="")}.map(&:title).map{|x|x.split(' ')[0,5].join('').upcase}.include?(book.title.split(' ')[0,5].join('').upcase) and book_title.present?)

              book_author.each do |other_users_book_author|
                priority_second << matches_detail(other_user, book, other_users_book_author, @user)
              end if (other_user.reading_preferences.select{|x|(x.by_scanning == false && x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false && x.author!="")}.map(&:author).map{|x|x.split(' ')[0,5].join('').upcase}.include?(book.author.split(' ')[0,5].join('').upcase) and book_author.present?)

              book_genre.each do |other_users_book_genre|
                priority_third << matches_detail(other_user, book, other_users_book_genre, @user)
              end if (other_user.reading_preferences.select{|x|(x.by_scanning == false && x.book_deactivated == false && x.genre_deactivated == false && x.delete_genre == false && x.genre!="")}.map(&:genre).map{|x|x.split(' ')[0,5].join('').upcase}.include?(book.genre.split(' ')[0,5].join('').upcase) and book_genre.present?)

              book_author_n.each do |other_users_book_author_n|
                priority_fifth << matches_detail(other_user, book, other_users_book_author_n, @user)
              end if (other_user.reading_preferences.select{|x|(x.by_scanning == true && x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false && x.author!="")}.map(&:author).map{|x|x.split(' ')[0,5].join('').upcase}.include?(book.author.split(' ')[0,5].join('').upcase) and book_author_n.present?)

              book_genre_n.each do |other_users_book_genre_n|
                priority_sixth << matches_detail(other_user, book, other_users_book_genre_n, @user)
              end if (other_user.reading_preferences.select{|x|(x.by_scanning == true && x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false && x.genre!="")}.map(&:genre).map{|x|x.split(' ')[0,5].join('').upcase}.include?(book.genre.split(' ')[0,5].join('').upcase) and book_genre_n.present?)
            else
              if ((other_user.reading_preferences.select{|x|(x.book_deactivated == false && x.genre!="" && x.delete_genre == false && x.genre_deactivated == false)}.map(&:genre)).include?(book.genre) ||  (other_user.reading_preferences.select{|x|(x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false && x.author!="")}.map(&:author)).include?(book.author) || (other_user.reading_preferences.select{|x|(x.book_deactivated == false && x.title!="")}.map(&:title)).include?(book.title)) #&& (other_user.reading_preferences.map(&:isbn13).include?(book.isbn13)) 
                priority_forth << self.matches_detail_for_genre_cases(other_user, book, @user)
              end
            end
          end
        end
     elsif @books.blank?          
          if @other_users.present?
            @other_users.each do |other_userss|
              if other_userss.books.blank?

                preferences = other_userss.reading_preferences.select{|x|((x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false && x.author!="" && @user_preferences.map(&:author).map{|x|x.split(' ')[0,5].join('').upcase}.include?(x.author.split(' ')[0,5].join('').upcase)) or (x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false && x.genre!="" && @user_preferences.map(&:genre).map{|x|x.split(' ')[0,5].join('').upcase}.include?(x.genre.split(' ')[0,5].join('').upcase)))}
                preferences.each do |other_user_preference|
                  @user_preferences.select{|x|(x.book_deactivated == false)}.each do |user_preferences|

                    if other_user_preference.genre==user_preferences.genre && other_user_preference.author.split(' ')[0,5].join('').upcase==user_preferences.author.split(' ')[0,5].join('').upcase &&  user_preferences.delete_author == false && user_preferences.author_deactivated == false && user_preferences.delete_genre == false && user_preferences.genre_deactivated == false && other_user_preference.delete_author == false && other_user_preference.author_deactivated == false && other_user_preference.delete_genre == false && other_user_preference.genre_deactivated == false && user_preferences.author!="" && user_preferences.genre!=""

                      priority_seventh<< self.match_hash_detail(other_userss, user_preferences, other_user_preference, @user) 

                    elsif other_user_preference.author.split(' ')[0,5].join('').upcase==user_preferences.author.split(' ')[0,5].join('').upcase && user_preferences.book_deactivated == false && user_preferences.delete_author == false && user_preferences.author_deactivated == false && user_preferences.author!=""

                      priority_eighth<<  self.match_hash_detail(other_userss, user_preferences, other_user_preference, @user) 

                    elsif other_user_preference.genre==user_preferences.genre && user_preferences.book_deactivated == false && user_preferences.delete_genre == false && user_preferences.genre_deactivated == false && user_preferences.genre!=""

                      priority_nineth<<  self.match_hash_detail(other_userss, user_preferences, other_user_preference, @user)
                    end

                  end 
                end

              end
            end
          end
     end
    matches = priority_first + priority_second + priority_third + priority_forth + priority_fifth + priority_sixth + priority_seventh + priority_eighth + priority_nineth
    hash[:matches] = matches.to_set
    logger.info"==========#{priority_first.count}====================#{priority_second.count}=======================#{priority_third.count}-----------------------------#{hash[:matches].count}"
    if params[:is_week_news].present?
      return hash[:matches].count
    else
      self.update_data_for_admin(priority_first.count, priority_second.count, priority_third.count, @user, hash[:matches])
      return hash,hash[:matches].count
    end
  end



  def self.user_potential_match_for_news_letter(user_id)  #fetch user potential match for monthly newsletter
    hash = Hash.new
    priority_first =Set.new 
    priority_second = Set.new
    priority_third = Set.new
    priority_forth = Set.new
    priority_fifth = Set.new
    education_case = ['Education - School','Education - Undergrad - Art & Design','Education - Undergrad - Aeronautics','Education - Undergrad - Business Studies / Eco','Education - Undergrad - Drama', 'Education - Undergrad - Engineering', 'Education - Undergrad - Geography', 'Education - Undergrad - History', 'Education - Undergrad - Law', 'Education - Undergrad - Literature / English', 'Education - Undergrad - Maths', 'Education - Undergrad - Medicine', 'Education - Undergrad - Music', 'Education - Undergrad - Science', 'Education - Undergrad - Social Science', 'Education - Undergrad - Technology', 'Education - Undergrad - Others', 'Education - Postgrad - Business / Finance', 'Education - Postgrad - History', 'Education - Postgrad - Marketing', 'Education - Postgrad - Maths', 'Education - Postgrad - Medicine', 'Education - Postgrad - Technology', 'Education - Postgrad - Others']
    

    @user = User.find_by(id: user_id)
    @lat_long = @user.books.last if @user.books.last.present?
    @books = @user.books#.near([@lat_long.latitude,@lat_long.longitude], 10, :units => :km)

    @user_preferences = @user.reading_preferences
    other_users = (User.includes(:books,:reading_preferences,:ratings).near([@lat_long.latitude,@lat_long.longitude], 10, :units => :km).reject{|u| u.id == @user.id})
    my_flag = 0

    ####### Priority First ##################
    other_users.each  do |other_user|
      book_title = other_user.books.reject{|x|education_case.include?(x.genre)}.select{|x|@user_preferences.select{|x|(x.by_scanning == false && x.book_deactivated == false && x.title!="")}.map(&:title).map{|x|x.split(' ')[0,5].join('').upcase}.include?(x["title"].split(' ')[0,5].join('').upcase)}
      @books.each do |book|
        book_title.each do |other_users_book_title|
          priority_first << other_users_book_title.as_json(:only => [:id, :title,:author,:genre, :about_us, :image_path]).merge(distance: other_user.distance.round(1))
        end if (other_user.reading_preferences.select{|x|(x.book_deactivated == false && x.title!="")}.map(&:title).map{|x|x.split(' ')[0,5].join('').upcase}.include?(book.title.split(' ')[0,5].join('').upcase) and book_title.present?)
        (my_flag=1;break;) if priority_first.count>=10
      end
      Rails.logger.info "======Priority first ==========#{priority_first.count}======================="
      break if my_flag==1
    end if @books.present?

    ####### Priority Second ##################
    other_users.each  do |other_user|
      book_author = other_user.books.reject{|x|education_case.include?(x.genre)}.select{|x|@user_preferences.select{|x|(x.by_scanning == false && x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false && x.author!="")}.map(&:author).map{|x|x.split(' ')[0,5].join('').upcase}.include?(x["author"].split(' ')[0,5].join('').upcase)}
      @books.each do |book|
        book_author.each do |other_users_book_author|
          priority_second << other_users_book_author.as_json(:only => [:id, :title,:author,:genre, :about_us, :image_path]).merge(distance: other_user.distance.round(1))
        end if (other_user.reading_preferences.select{|x|(x.by_scanning == false && x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false && x.author!="")}.map(&:author).map{|x|x.split(' ')[0,5].join('').upcase}.include?(book.author.split(' ')[0,5].join('').upcase) and book_author.present?)
        (my_flag=1;break;) if ((priority_first + priority_second).to_set.count >=10)
      end
      Rails.logger.info "========Priority Second ============#{(priority_first + priority_second).to_set.count}==================="
      break if my_flag==1
    end if (@books.present? and priority_first.count < 10)

    ####### Priority Third ##################
    other_users.each  do |other_user|
      book_genre = other_user.books.reject{|x|education_case.include?(x.genre)}.select{|x|@user_preferences.select{|x|(x.by_scanning == false && x.book_deactivated == false && x.genre_deactivated == false && x.delete_genre == false && x.genre!="")}.map(&:genre).map{|x|x.split(' ')[0,5].join('').upcase}.include?(x["genre"].split(' ')[0,5].join('').upcase)}
      @books.each do |book|
        book_genre.each do |other_users_book_genre|
          priority_third << other_users_book_genre.as_json(:only => [:id, :title,:author,:genre, :about_us, :image_path]).merge(distance: other_user.distance.round(1))
        end if (other_user.reading_preferences.select{|x|(x.by_scanning == false && x.book_deactivated == false && x.genre_deactivated == false && x.delete_genre == false && x.genre!="")}.map(&:genre).map{|x|x.split(' ')[0,5].join('').upcase}.include?(book.genre.split(' ')[0,5].join('').upcase) and book_genre.present?)
        (my_flag=1;break;) if ((priority_first + priority_second + priority_third).to_set.count >=10)
      end
      Rails.logger.info "========Priority Third ============#{(priority_first + priority_second + priority_third).to_set.count}==================="
      break if my_flag==1
    end if (@books.present? and (priority_first + priority_second).to_set.count < 10)

    ####### Priority Fourth ##################
    other_users.each  do |other_user|
      book_author_n = other_user.books.reject{|x|education_case.include?(x.genre)}.select{|x|@user_preferences.select{|x|(x.by_scanning == true && x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false && x.author!="")}.map(&:author).map{|x|x.split(' ')[0,5].join('').upcase}.include?(x["author"].split(' ')[0,5].join('').upcase)}
      @books.each do |book|
        book_author_n.each do |other_users_book_author_n|
          priority_forth << other_users_book_author_n.as_json(:only => [:id, :title,:author,:genre, :about_us, :image_path]).merge(distance: other_user.distance.round(1))
        end if (other_user.reading_preferences.select{|x|(x.by_scanning == true && x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false && x.author!="")}.map(&:author).map{|x|x.split(' ')[0,5].join('').upcase}.include?(book.author.split(' ')[0,5].join('').upcase) and book_author_n.present?)
        (my_flag=1;break;) if ((priority_first + priority_second + priority_third + priority_forth).to_set.count >=10)
      end
      Rails.logger.info "========Priority Fourth ============#{(priority_first + priority_second + priority_third + priority_forth).to_set.count}==================="
      break if my_flag==1
    end if (@books.present? and (priority_first + priority_second + priority_third).to_set.count  < 10)

    ####### Priority Fifth ##################
    other_users.each  do |other_user|
      book_genre_n = other_user.books.reject{|x|education_case.include?(x.genre)}.select{|x|@user_preferences.select{|x|(x.by_scanning == true && x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false && x.genre!="")}.map(&:genre).map{|x|x.split(' ')[0,5].join('').upcase}.include?(x["genre"].split(' ')[0,5].join('').upcase)}
      @books.each do |book|
        book_genre_n.each do |other_users_book_genre_n|
          priority_fifth << other_users_book_genre_n.as_json(:only => [:id, :title,:author,:genre, :about_us, :image_path]).merge(distance: other_user.distance.round(1))
        end if (other_user.reading_preferences.select{|x|(x.by_scanning == true && x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false && x.genre!="")}.map(&:genre).map{|x|x.split(' ')[0,5].join('').upcase}.include?(book.genre.split(' ')[0,5].join('').upcase) and book_genre_n.present?)
        (my_flag=1;break;) if ((priority_first + priority_second + priority_third + priority_forth + priority_fifth).to_set.count >=10)
      end
      Rails.logger.info "========Priority Fifth ============#{(priority_first + priority_second + priority_third + priority_forth + priority_fifth).to_set.count}==================="
      break if my_flag==1
    end if (@books.present? and (priority_first + priority_second + priority_third + priority_forth).to_set.count < 10)

    matches = priority_first.sort_by{|x|x[:distance]} + priority_second.sort_by{|x|x[:distance]} + priority_third.sort_by{|x|x[:distance]} + priority_forth.sort_by{|x|x[:distance]} + priority_fifth.sort_by{|x|x[:distance]} 
    matches = matches.to_set.first(10)
    UserMailer.send_potential_match(@user,matches).deliver
  end

  def self.matches_detail(other_user, book, other_users_book, user)
    match_hash = {}
    dis = other_user.distance.round(2)
    match_hash[:other_user_detail] = other_user.as_json(:only => [:picture,:username,:id]).merge(distance: dis)
    @rating = Rating.calculate_ratings(other_user)
    match_hash[:user_rating] = @rating
    data = "B"
    match_hash[:book_to_give] = book.as_json(:only => [:id, :title,:author,:genre, :about_us, :image_path]).merge(data: data)
    match_hash[:book_to_get] = other_users_book.as_json(:only => [:id, :title,:author,:genre, :about_us, :image_path]).merge(data: data)
    @invite_status = Invitation.where(:invitation_status => "B", :user_id => user.id, :attendee => other_user.id, :invitation_type => "start chat", :book_to_get => other_users_book.id, :book_to_give => book.id).present?
    match_hash[:invite_status] = @invite_status
    match_hash
  end

  def self.match_hash_detail(other_user, user_preference, other_user_preference, user)
    match_hash = {}
    dis = other_user.distance.round(2)
    match_hash[:other_user_detail] = other_user.as_json(:only => [:picture,:username,:id]).merge(distance: dis)
    @rating = Rating.calculate_ratings(other_user)
    match_hash[:user_rating] = @rating
    data = "RP"
    match_hash[:book_to_give] = user_preference.as_json(:only => [:id, :title,:author,:genre]).merge(data: data)
    match_hash[:book_to_get] = other_user_preference.as_json(:only => [:id, :title,:author,:genre]).merge(data: data)
    @invite_status = Invitation.where(:invitation_status => "RP", :user_id => user.id, :attendee => other_user.id, :invitation_type => "start chat", :book_to_get => other_user_preference.id, :book_to_give => user_preference.id).present?
    match_hash[:invite_status] = @invite_status
    match_hash
  end

  def self.matches_detail_for_genre_cases(other_user, book, user)
    match_hash = {}
    dis = other_user.distance.round(2)
    match_hash[:other_user_detail] = other_user.as_json(:only => [:picture,:username,:id]).merge(distance: dis)
    @rating = Rating.calculate_ratings(other_user)
    match_hash[:user_rating] = @rating
    data = "ED"
    match_hash[:book_to_give] = book.as_json(:only => [:id, :title,:author,:genre, :about_us, :image_path]).merge(data: data)
    @invite_status = Invitation.where(:invitation_status => "ED", :user_id => user.id, :attendee => other_user.id, :invitation_type => "start chat", :book_to_give => book.id).present?
    match_hash[:invite_status] = @invite_status
    match_hash
  end

  def self.update_data_for_admin(priority_first, priority_second, priority_third, user, nearby_books)
     @user = user
     count = nearby_books.select{|x|x[:other_user_detail][:distance]<=5}.count
     @user.update_attributes(:mat_books_count => priority_first, :mat_author_count => priority_second, :mat_genre_count => priority_third, :within_five_km => count, :date_within_five_km => Date.today)
  end

  def update_via_social_media params
    self.update_attributes(username: params[:username],gender: params[:gender],email: params[:email],date_signup: params[:date_signup],picture: params[:picture], location: params[:location],latitude: params[:latitude], longitude: params[:longitude])
    unless self.devices.nil?
      Device.total_devices(params[:device_id],params[:device_type],self.id)
    end 
  end 

  def self.search_user_to_add_group(search)
    if search
      where('username LIKE ?', "{search}%")
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






########################   New working code ############################

# def self.get_near_matches params 
#       hash = Hash.new
#       priority_first =Set.new 
#       priority_second = Set.new
#       priority_third = Set.new
#       priority_forth = Set.new
#       priority_fifth = Set.new
#       priority_sixth = Set.new
#       priority_seventh = Set.new
#       priority_eighth = Set.new 
#       priority_nineth = Set.new

#       @user = User.find_by(:id => params[:user_id])
#       @books_max_range = @user.books.near([params[:lat],params[:long]], params[:range_end], :units => :km)
#       @books_min_range = @user.books.near([params[:lat],params[:long]], params[:range_start], :units => :km)
#       @books = @books_max_range - @books_min_range
#       @user_preferences = @user.reading_preferences
#       other_users = (User.includes(:books,:reading_preferences,:ratings).near([params[:lat],params[:long]], params[:range_end], :units => :km).reject{|u| u.id == @user.id})

#       if @books.present? 
#         other_users.each  do |other_user|

#           book_title = other_user.books.select{|x|@user_preferences.select{|x|(x.by_scanning == false && x.book_deactivated == false && x.title!="")}.map(&:title).include?(x["title"])}
#           book_author = other_user.books.select{|x|@user_preferences.select{|x|(x.by_scanning == false && x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false && x.author!="")}.map(&:author).include?(x["author"])}
#           book_genre = other_user.books.select{|x|@user_preferences.select{|x|(x.by_scanning == false && x.book_deactivated == false && x.genre_deactivated == false && x.delete_genre == false && x.genre!="")}.map(&:genre).include?(x["genre"])}
#           book_author_n = other_user.books.select{|x|@user_preferences.select{|x|(x.by_scanning == true && x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false && x.author!="")}.map(&:author).include?(x["author"])}
#           book_genre_n = other_user.books.select{|x|@user_preferences.select{|x|(x.by_scanning == true && x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false && x.genre!="")}.map(&:genre).include?(x["genre"])}

#           @books.each do |book|

#             book_title.each do |other_users_book_title|
#               priority_first << matches_detail(other_user, book, other_users_book_title)
#             end if other_user.reading_preferences.select{|x|(x.book_deactivated == false && x.title!="")}.map(&:title).include?(book.title) and book_title.present?

#             book_author.each do |other_users_book_author|
#               priority_second << matches_detail(other_user, book, other_users_book_author)
#             end if other_user.reading_preferences.select{|x|(x.by_scanning == false && x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false && x.author!="")}.map(&:author).include?(book.author) and book_author.present?

#             book_genre.each do |other_users_book_genre|
#               priority_third << matches_detail(other_user, book, other_users_book_genre)
#             end if other_user.reading_preferences.select{|x|(x.by_scanning == false && x.book_deactivated == false && x.genre_deactivated == false && x.delete_genre == false && x.genre!="")}.map(&:genre).include?(book.genre) and book_genre.present?

#             book_author_n.each do |other_users_book_author_n|
#               priority_fifth << matches_detail(other_user, book, other_users_book_author_n)
#             end if other_user.reading_preferences.select{|x|(x.by_scanning == true && x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false && x.author!="")}.map(&:author).include?(book.author) and book_author_n.present?

#             book_genre_n.each do |other_users_book_genre_n|
#               priority_sixth << matches_detail(other_user, book, other_users_book_genre_n)
#             end if other_user.reading_preferences.select{|x|(x.by_scanning == true && x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false && x.genre!="")}.map(&:genre).include?(book.genre) and book_genre_n.present?

#             if ((other_user.reading_preferences.select{|x|(x.book_deactivated == false && x.genre!="" && x.delete_genre == false && x.genre_deactivated == false)}.map(&:genre)).include?(book.genre) and ['Education - School','Education - Undergrad - Art & Design','Education - Undergrad - Aeronautics','Education - Undergrad - Business Studies / Eco','Education - Undergrad - Drama', 'Education - Undergrad - Engineering', 'Education - Undergrad - Geography', 'Education - Undergrad - History', 'Education - Undergrad - Law', 'Education - Undergrad - Literature / English', 'Education - Undergrad - Maths', 'Education - Undergrad - Medicine', 'Education - Undergrad - Music', 'Education - Undergrad - Science', 'Education - Undergrad - Social Science', 'Education - Undergrad - Technology', 'Education - Undergrad - Others', 'Education - Postgrad - Business / Finance', 'Education - Postgrad - History', 'Education - Postgrad - Marketing', 'Education - Postgrad - Maths', 'Education - Postgrad - Medicine', 'Education - Postgrad - Technology', 'Education - Postgrad - Others'].include?(book.genre) ) #&& (other_user.reading_preferences.map(&:isbn13).include?(book.isbn13)) 
#               priority_forth << self.matches_detail_for_genre_cases(other_user, book)
#             end

#           end
#         end
#      elsif @books.blank? 
#           @user_max_range = (User.near([params[:lat],params[:long]], params[:range_end], :units => :km).reject{|u| u.id == @user.id})
#           @user_min_range = (User.near([params[:lat],params[:long]], params[:range_start], :units => :km).reject{|u| u.id == @user.id})
#           @other_user = @user_max_range - @user_min_range unless @user_max_range.blank? && @user_min_range.blank?         
          
#           if @other_user.present?
#             @other_user.each do |other_userss|
#               if other_userss.books.blank?

#                 preferences = other_userss.reading_preferences.select{|x|((x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false && x.author!="" && @user_preferences.map(&:author).include?(x.author)) or (x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false && x.genre!="" && @user_preferences.map(&:genre).include?(x.genre)))}
#                 preferences.each do |other_user_preference|
#                   @user_preferences.select{|x|(x.book_deactivated == false)}.each do |user_preferences|

#                     if other_user_preference.genre==user_preferences.genre && other_user_preference.author==user_preferences.author &&  user_preferences.delete_author == false && user_preferences.author_deactivated == false && user_preferences.delete_genre == false && user_preferences.genre_deactivated == false && other_user_preference.delete_author == false && other_user_preference.author_deactivated == false && other_user_preference.delete_genre == false && other_user_preference.genre_deactivated == false && user_preferences.author!="" && user_preferences.genre!=""

#                       priority_seventh<< self.match_hash_detail(other_userss, user_preferences, other_user_preference) 

#                     elsif other_user_preference.author==user_preferences.author && user_preferences.book_deactivated == false && user_preferences.delete_author == false && user_preferences.author_deactivated == false && user_preferences.author!=""

#                       priority_eighth<<  self.match_hash_detail(other_userss, user_preferences, other_user_preference) 

#                     elsif other_user_preference.genre==user_preferences.genre && user_preferences.book_deactivated == false && user_preferences.delete_genre == false && user_preferences.genre_deactivated == false && user_preferences.genre!=""

#                       priority_nineth<<  self.match_hash_detail(other_userss, user_preferences, other_user_preference)
#                     end

#                   end 
#                 end

#               end
#             end
#           end
#      end
#       matches = priority_first + priority_second + priority_third + priority_forth + priority_fifth + priority_sixth + priority_seventh + priority_eighth + priority_nineth
#       hash[:matches] = matches.to_set
#       logger.info"==========#{priority_first.count}====================#{priority_second.count}=======================#{priority_third.count}-----------------------------#{hash[:matches].count}"
#       self.update_data_for_admin(priority_first.count, priority_second.count, priority_third.count, @user, hash[:matches])
#       return hash,hash[:matches].count
#   end


##################################################################################################################


  #====================== Working Code========================

  # def self.get_near_matches params 
  #     hash = Hash.new
  #     priority_first = [] 
  #     priority_second = []
  #     priority_third = []
  #     priority_forth = []
  #     priority_fifth = []
  #     priority_sixth = []
  #     priority_seventh = []
  #     priority_eighth = [] 
  #     priority_nineth = []

  #     @user = User.find_by(:id => params[:user_id])
  #     @books_max_range = @user.books.near([params[:lat],params[:long]], params[:range_end], :units => :km)
  #     @books_min_range = @user.books.near([params[:lat],params[:long]], params[:range_start], :units => :km)
  #     @books = @books_max_range - @books_min_range
  #     @user_preferences = @user.reading_preferences
  #     @user_author_pref = @user.author_prefernce
  #     @user_genre_pref = @user.genre_preference
  #     p "=========#{@books_max_range.inspect}========#{@books_min_range.inspect}===========#{@books.inspect}"
  #     other_users = (User.includes(:books,:reading_preferences,:ratings).near([params[:lat],params[:long]], params[:range_end], :units => :km).reject{|u| u.id == @user.id})

  #     if @books.present? 
  #     @books.each do |book|
  #       other_users.each  do |other_user|
  #           other_user.books.each do |other_users_book|
  #               other_user.reading_preferences.each do |other_user_preference|
  #                   @user_preferences.each do |user_preference|

  #                       if (other_user.reading_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:title).include?(book.title) && @user_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:title).include?(other_users_book.title))
                                 
  #                                if ((other_user_preference.title.eql? book.title) && (other_users_book.title.eql? user_preference.title))
  #                                 priority_first<<  self.matches_detail(other_user, book, other_users_book) 
  #                                end 
                        
  #                       elsif (other_user.reading_preferences.map{|x| x if x.book_deactivated == false && x.delete_author == false}.compact.uniq.map(&:author).include?(book.author) && @user_preferences.map{|x| x if x.book_deactivated == false && x.delete_author == false}.compact.uniq.map(&:author).include?(other_users_book.author)) 
                                 
  #                                if ((other_user_preference.author.eql? book.author) && (other_users_book.author.eql? user_preference.author))
  #                                 priority_second<<  self.matches_detail(other_user, book, other_users_book)
  #                                end 
                        
  #                       elsif (other_user.reading_preferences.map{|x| x if x.genre_deactivated == false && x.delete_genre == false}.compact.map(&:genre).include?(book.genre) && @user_preferences.map{|x| x if x.genre_deactivated == false && x.delete_genre == false}.compact.map(&:genre).include?(other_users_book.genre))        
                                
  #                               if ((other_user_preference.genre.eql? book.genre) && (other_users_book.genre.eql? user_preference.genre))  
  #                                 priority_third<<  self.matches_detail(other_user, book, other_users_book)
  #                               end

  #                       #elsif (other_user.books.map(&:author).include?(book.author) && @books.map(&:author).include?(other_users_book.author)) 
  #                       elsif (other_user.reading_preferences.map{|x| x if x.by_scanning == true && x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false}.compact.map(&:author).include?(book.author) && @user_preferences.map{|x| x if x.by_scanning == true && x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false}.compact.map(&:author).include?(other_users_book.author)) 
                                
  #                               if ((other_user_preference.author.eql? book.author) && (other_users_book.author.eql? user_preference.author)) 
  #                                 priority_fifth<<   self.matches_detail(other_user, book, other_users_book)
  #                               end
                       
  #                       #elsif (other_user.books.map(&:genre).include?(book.genre) && @books.map(&:genre).include?(other_users_book.genre))  
  #                       elsif (other_user.reading_preferences.map{|x| x if x.by_scanning == true && x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false}.compact.map(&:genre).include?(book.genre) && @user_preferences.map{|x| x if x.by_scanning == true && x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false}.compact.map(&:genre).include?(other_users_book.genre))          
                                 
  #                               if ((other_user_preference.genre.eql? book.genre) && (other_users_book.genre.eql? user_preference.genre)) 
  #                                 priority_sixth<<   self.matches_detail(other_user, book, other_users_book)
  #                               end
  #                       end
  #                   end    
  #               end    
  #           end
  #         if ((other_user.reading_preferences.map(&:genre)).include?(book.genre) and ['Education - School','Education - Undergrad - Art & Design','Education - Undergrad - Aeronautics','Education - Undergrad - Business Studies / Eco','Education - Undergrad - Drama', 'Education - Undergrad - Engineering', 'Education - Undergrad - Geography', 'Education - Undergrad - History', 'Education - Undergrad - Law', 'Education - Undergrad - Literature / English', 'Education - Undergrad - Maths', 'Education - Undergrad - Medicine', 'Education - Undergrad - Music', 'Education - Undergrad - Science', 'Education - Undergrad - Social Science', 'Education - Undergrad - Technology', 'Education - Undergrad - Others', 'Education - Postgrad - Business / Finance', 'Education - Postgrad - History', 'Education - Postgrad - Marketing', 'Education - Postgrad - Maths', 'Education - Postgrad - Medicine', 'Education - Postgrad - Technology', 'Education - Postgrad - Others'].include?(book.genre) ) #&& (other_user.reading_preferences.map(&:isbn13).include?(book.isbn13)) 
                          
  #                         priority_forth<< self.matches_detail_for_genre_cases(other_user, book)

  #         end
  #       end
  #     end 

  #    elsif @books.blank? 
  #            @user_max_range = (User.near([params[:lat],params[:long]], params[:range_end], :units => :km).reject{|u| u.id == @user.id})
  #            @user_min_range = (User.near([params[:lat],params[:long]], params[:range_start], :units => :km).reject{|u| u.id == @user.id})
  #            @other_user = @user_max_range - @user_min_range unless @user_max_range.blank? && @user_min_range.blank?
           
  #          if @other_user.present?
  #              @other_user.each do |other_userss|
  #                   @user_preferences.each do |user_preference|
  #                     other_userss.reading_preferences.each do |other_user_preference|
  #                         if other_userss.books.blank?

  #                               #if not(((other_userss.reading_preferences.map{|x| x if x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false}.compact.reject {|x| x.author == ""}.map(&:author) & @user_preferences.map{|x| x if x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false}.compact.reject {|x| x.author == ""}.map(&:author)).blank?) && ((other_userss.reading_preferences.map{|x| x if x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false}.compact.reject {|x| x.genre == ""}.map(&:genre) & @user_preferences.map{|x| x if x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false}.compact.reject {|x| x.genre == ""}.map(&:genre)).blank?)) 
                                
  #                               #if (other_userss.reading_preferences.map{|x| x if x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false}.compact.reject {|x| x.author == ""}.map(&:author).include?(user_preference.author) && (other_userss.reading_preferences.map{|x| x if x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false}.compact.reject {|x| x.genre == ""}.map(&:genre).include?(user_preference.genre))) 
  #                               logger.info"======#{other_userss.reading_preferences.pluck(:author)}===================#{@user_preferences.pluck(:author)}=======================-------------------------------------------#{user_preference.author}----------------"

  #                               if ((other_userss.reading_preferences.map{|x| x if x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false}.compact.reject {|x| x.author == ""}.map(&:author).include?(user_preference.author) && @user_preferences.map{|x| x if x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false}.compact.reject{|x| x.author == ""}.map(&:author).include?(other_user_preference.author)) && (other_userss.reading_preferences.map{|x| x if x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false}.compact.reject {|x| x.genre == ""}.map(&:genre).include?(user_preference.genre) && @user_preferences.map{|x| x if x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false}.compact.reject {|x| x.genre == ""}.map(&:genre).include?(other_user_preference.genre)))  
                                        
  #                                       if ((other_user_preference.author.eql? user_preference.author) && (other_user_preference.genre.eql? user_preference.genre))
  #                                            priority_seventh<<  self.match_hash_detail(other_userss, user_preference, other_user_preference)                                           
  #                                       end
  #                               #elsif not((other_userss.reading_preferences.map{|x| x if x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false}.compact.reject {|x| x.author == ""}.map(&:author) & @user_preferences.map{|x| x if x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false}.compact.reject {|x| x.author == ""}.map(&:author)).blank?)
                                
  #                               #elsif (other_userss.reading_preferences.map{|x| x if x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false}.compact.reject {|x| x.author == ""}.map(&:author).include?(user_preference.author))
  #                                elsif (other_userss.reading_preferences.map{|x| x if x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false}.compact.reject {|x| x.author == ""}.map(&:author).include?(user_preference.author) && @user_preferences.map{|x| x if x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false}.compact.reject{|x| x.author == ""}.map(&:author).include?(other_user_preference.author)) 
                                     
  #                                     if (other_user_preference.author.eql? user_preference.author)
  #                                         priority_eighth<<  self.match_hash_detail(other_userss, user_preference, other_user_preference)                                      
  #                                     end 
  #                               #elsif not((other_userss.reading_preferences.map{|x| x if x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false}.compact.reject {|x| x.genre == ""}.map(&:genre) & @user_preferences.map{|x| x if x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false}.compact.reject {|x| x.genre == ""}.map(&:genre)).blank?)          
                                
  #                               #elsif (other_userss.reading_preferences.map{|x| x if x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false}.compact.reject {|x| x.genre == ""}.map(&:genre).include?(user_preference.genre))
  #                                elsif (other_userss.reading_preferences.map{|x| x if x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false}.compact.reject {|x| x.genre == ""}.map(&:genre).include?(user_preference.genre) && @user_preferences.map{|x| x if x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false}.compact.reject {|x| x.genre == ""}.map(&:genre).include?(other_user_preference.genre))
                                      
  #                                     if (other_user_preference.genre.eql? user_preference.genre)       
  #                                       priority_nineth<<  self.match_hash_detail(other_userss, user_preference, other_user_preference) 
  #                                     end
  #                               end
  #                         end
  #                     end    
  #                   end  
  #              end
  #          end
  #    end
  #     hash[:matches] = priority_first.uniq + priority_second.uniq + priority_third.uniq + priority_forth.uniq + priority_fifth.uniq + priority_sixth.uniq + priority_seventh.uniq + priority_eighth.uniq + priority_nineth.uniq
  #     logger.info"==========#{priority_first.count}====================#{priority_second.count}=======================#{priority_third.count}-----------------------------#{hash[:matches].count}"
  #     self.update_data_for_admin(priority_first.count, priority_second.count, priority_third.count, @user, hash[:matches])
  #     return hash,hash[:matches].count
  # end

  #======================================================================================
