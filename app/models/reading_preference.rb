require 'set'

class ReadingPreference < ActiveRecord::Base
  belongs_to :user

  #validates_uniqueness_of :title, :allow_blank => true, :message => "already exists."
  validates :user_id, :uniqueness => {:scope => [:isbn13] , :message => "reading preference already exists!."}, if: 'isbn13.present?'
  before_create :update_no_of_book_pref_for_user

  def update_no_of_book_pref_for_user
     @user = User.find_by_id(self.user_id)
     if (self.title != "" && self.author != "" && self.genre != "")     
        @user.update_attributes(:no_of_book_pref => (@user.no_of_book_pref + 1), :no_of_author_pref => (@user.no_of_author_pref + 1), :no_of_category_pref => (@user.no_of_category_pref + 1))
     elsif (self.author != "" && self.genre == "")
        @user.update_attributes(:no_of_book_pref => (@user.no_of_book_pref + 1), :no_of_author_pref => (@user.no_of_author_pref + 1))
     elsif (self.author == "" && self.genre != "")  
        @user.update_attributes(:no_of_book_pref => (@user.no_of_book_pref + 1), :no_of_category_pref => (@user.no_of_category_pref + 1))
     end
  end

  def self.search_similar_rp(params)
      education_genre = ['Education - School','Education - Undergrad - Art & Design','Education - Undergrad - Aeronautics','Education - Undergrad - Business Studies / Eco','Education - Undergrad - Drama', 'Education - Undergrad - Engineering', 'Education - Undergrad - Geography', 'Education - Undergrad - History', 'Education - Undergrad - Law', 'Education - Undergrad - Literature / English', 'Education - Undergrad - Maths', 'Education - Undergrad - Medicine', 'Education - Undergrad - Music', 'Education - Undergrad - Science', 'Education - Undergrad - Social Science', 'Education - Undergrad - Technology', 'Education - Undergrad - Others', 'Education - Postgrad - Business / Finance', 'Education - Postgrad - History', 'Education - Postgrad - Marketing', 'Education - Postgrad - Maths', 'Education - Postgrad - Medicine', 'Education - Postgrad - Technology', 'Education - Postgrad - Others']
      users_data = Set.new
  	  @user = User.includes(:reading_preferences).find_by_id(params[:user_id])
      @user_pref = @user.reading_preferences.reject{|x|education_genre.include?(x.genre)} if @user.reading_preferences.present?
      other_users = User.includes(:reading_preferences).near([@user.latitude, @user.longitude], 5, :units => :km).reject{|u| u.id == @user.id}
      @group = Group.find_by_id(params[:group_id])
      @grp_users = @group.users
      final_users = other_users - @grp_users

            if @user_pref.present? 
               final_users.each  do |other_user|
            
            book_author = other_user.reading_preferences.reject{|x|education_genre.include?(x.genre)}.select{|x|@user_pref.select{|x|(x.by_scanning == false && x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false && x.author!="")}.map(&:author).map{|x|x.split(' ')[0,5].join('').upcase}.include?(x["author"].split(' ')[0,5].join('').upcase)}               
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






                                 

