class Group < ActiveRecord::Base
	has_and_belongs_to_many :users ,:join_table => "users_groups"
	has_many :messages, dependent: :destroy
	has_many :blocks, dependent: :destroy
	has_many :ratings, :class_name => "Rating", :foreign_key => :group_id, dependent: :destroy
end
