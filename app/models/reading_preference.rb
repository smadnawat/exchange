class ReadingPreference < ActiveRecord::Base
  belongs_to :user

  #validates_uniqueness_of :title, :allow_blank => true, :message => "already exists."
  validates :user_id, :uniqueness => {:scope => [:isbn13] , :message => "reading preference already exists!."}, if: 'isbn13.present?'

 #  def self.search_similar_rp(params)
 #  	  logger.info"==========================#{params.inspect}-----1111111111111111"
 #  	  @user = User.find_by_id(params[:user_id])
 #      @user_pref = @user.reading_preferences if @user.reading_preferences.present?

 #      logger.info"=-----------------------------__#{@user_pref.inspect}--------2222222222222"
 #      other_users = User.includes(:reading_preferences).near([@user.latitude, @user.longitude], 5, :units => :km)

 #      logger.info"=============#{other_users.inspect}===========================33333333333333333"      

	# end

end







