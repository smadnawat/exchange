require 'set'

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
      education_genre = ['Education - School','Education - Undergrad - Art & Design','Education - Undergrad - Aeronautics','Education - Undergrad - Business Studies / Eco','Education - Undergrad - Drama', 'Education - Undergrad - Engineering', 'Education - Undergrad - Geography', 'Education - Undergrad - History', 'Education - Undergrad - Law', 'Education - Undergrad - Literature / English', 'Education - Undergrad - Maths', 'Education - Undergrad - Medicine', 'Education - Undergrad - Music', 'Education - Undergrad - Science', 'Education - Undergrad - Social Science', 'Education - Undergrad - Technology', 'Education - Undergrad - Others', 'Education - Postgrad - Business / Finance', 'Education - Postgrad - History', 'Education - Postgrad - Marketing', 'Education - Postgrad - Maths', 'Education - Postgrad - Medicine', 'Education - Postgrad - Technology', 'Education - Postgrad - Others']
      users_data = Set.new
      @user = User.includes(:books).find_by_id(params[:user_id])
      @user_book = @user.books.reject{|x|education_genre.include?(x.genre)} if @user.books.present?
      other_users = User.includes(:books).near([@user.latitude, @user.longitude], 5, :units => :km).reject{|u| u.id == @user.id}
      @group = Group.find_by_id(params[:group_id])
      @grp_users = @group.users
      final_users = other_users - @grp_users

            if @user_book.present? 
               final_users.each  do |other_user|
            
            book_author = other_user.books.reject{|x|education_genre.include?(x.genre)}.select{|x|@user_book.map(&:author).map{|x|x.split(' ')[0,5].join('').upcase}.include?(x["author"].split(' ')[0,5].join('').upcase)}               
                   users_data << matches_detail_for_other_user(other_user) if book_author.present?
               end  
            end 
      return users_data
  end

  def self.matches_detail_for_other_user(other_user)
    match_hash = {}
    dis = other_user.distance.round(2)
    match_hash[:other_user_detail] = other_user.as_json(:only => [:picture,:username,:id]).merge(distance: dis)
    match_hash
  end

end
