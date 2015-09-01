class Book < ActiveRecord::Base

	belongs_to :user
	reverse_geocoded_by :latitude, :longitude
	after_validation :reverse_geocode 
	scope :details, -> {Book.order(:upload_date_for_admin).map{|x| x}.uniq{|x| x.upload_date_for_admin}}
	before_save :update_date_admin, :if => :new_record?
	before_save :update_country_name
    
    validates :user_id, :uniqueness => {:scope => [:isbn13] , :message => "Book Already Catalogued"}, if: 'isbn13.present?'

	def update_date_admin
	  self.upload_date_for_admin = Date.today		
	end

	def update_country_name
	  self.country_name = self.address.split(',').last	
	end

	def self.search_similar_books(params)
  	  logger.info"==========================#{params.inspect}-----1111111111111111"
      users = []
  	  @user = User.includes(:books).find_by_id(params[:user_id])
      @user_books = @user.books if @user.books.present?
      other_users = User.includes(:books).near([@user.latitude, @user.longitude], 5, :units => :km).reject{|u| u.id == @user.id}

          @user_books.reject{|x|x.author == ""}.each do |user_book|
              other_users.each do |other_user|  

                    if  (other_user.books.reject{|x| x.author == ""}.map(&:author).map{|x|x.split(' ').join('').upcase}.include?(user_book.author.split(' ').join('').upcase))
                          users<< self.matches_detail_for_other_user(other_user)
                    end  

              end  
          end 
      return users.uniq 
	end

  def self.matches_detail_for_other_user(other_user)
    match_hash = {}
    dis = other_user.distance.round(2)
    match_hash[:other_user_detail] = other_user.as_json(:only => [:picture,:username,:id]).merge(distance: dis)
    match_hash
  end

end
