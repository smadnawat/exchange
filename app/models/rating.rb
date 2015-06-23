class Rating < ActiveRecord::Base
  belongs_to :user
  validates :user_id, uniqueness: {scope: :ratable_id}

	def self.new_group_rating(params, user)
		create(:insights => params[:insights], :contributor => params[:contributor],
		:social => params[:social], :overallexperience => params[:overallexperience],
		:comment => params[:comment], :ratable_id => params[:ratable_id],:user_id => user.id,
		:group_id => params[:group_id])
	end

end
