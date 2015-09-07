class Group < ActiveRecord::Base

	has_many :user_groups, :dependent => :destroy
  has_many :users ,:through => :user_groups, :dependent => :destroy
	# has_and_belongs_to_many :users ,:join_table => "users_groups"
	has_many :messages, dependent: :destroy
	has_many :blocks, dependent: :destroy
	has_many :ratings, :class_name => "Rating", :foreign_key => :group_id, dependent: :destroy
	belongs_to :admin,:class_name => "User"#, :foreign_key => :admin_id
	belongs_to :manager,:class_name => "User"#, :foreign_key => :admin_id


end
