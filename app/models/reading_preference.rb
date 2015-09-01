class ReadingPreference < ActiveRecord::Base
  belongs_to :user

  #validates_uniqueness_of :title, :allow_blank => true, :message => "already exists."
  validates :user_id, :uniqueness => {:scope => [:isbn13] , :message => "reading preference already exists!."}, if: 'isbn13.present?'

  def self.search_similar_rp(params)
  	  logger.info"==========================#{params.inspect}-----1111111111111111"
      users = []
  	  @user = User.includes(:reading_preferences).find_by_id(params[:user_id])
      @user_pref = @user.reading_preferences if @user.reading_preferences.present?
      other_users = User.includes(:reading_preferences).near([@user.latitude, @user.longitude], 5, :units => :km).reject{|u| u.id == @user.id}

          @user_pref.reject{|x|x.author == " "}.each do |user_pref|
              other_users.each do |other_user|  

                    if  (other_user.reading_preferences.map{|x| x if x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false}.compact.reject{|x| x.author == ""}.map(&:author).map{|x|x.split(' ').join('').upcase}.include?(user_pref.author.split(' ').join('').upcase))
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






                                 

