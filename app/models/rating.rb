class Rating < ActiveRecord::Base
  belongs_to :user
  validates :user_id, uniqueness: {scope: :ratable_id}

	def self.new_group_rating(params, user)
		create(:insights => params[:insights], :contributor => params[:contributor],
		:social => params[:social], :overallexperience => params[:overallexperience],
		:comment => params[:comment], :ratable_id => params[:ratable_id],:user_id => user.id,
		:group_id => params[:group_id])
	end

	# def self.calculate_ratings user
	# 	@rating = find_by_user_id(user)
	# 	if @rating
	# 		@ratings = (@rating.insights + @rating.contributor + @rating.social + @rating.overallexperience)/4
	# 	else
	# 		@ratings = 0
	# 	end
	# end

	def self.calculate_ratings user 
    @user_rate = user.ratings#{|x| x if x.approved == true}.compact
    unless @user_rate.blank?

      rate_arr = []
      arr_vom = @user_rate.collect(&:insights)
      arr_qos = @user_rate.collect(&:contributor)
      arr_oe = @user_rate.collect(&:social)
      arr_c = @user_rate.collect(&:overallexperience)

      rate_arr << arr_vom.inject(0.0) { |sum, el| sum + el } / arr_vom.size
      rate_arr << arr_qos.inject(0.0) { |sum, el| sum + el } / arr_qos.size
      rate_arr << arr_oe.inject(0.0) { |sum, el| sum + el } / arr_oe.size
      rate_arr << arr_c.inject(0.0) { |sum, el| sum + el } / arr_c.size
      return (rate_arr.inject(0.0) { |sum, el| sum + el } / rate_arr.size)
    else
      return 0
    end
  end

end
