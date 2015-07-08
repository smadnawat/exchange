class Block < ActiveRecord::Base
  belongs_to :group
  belongs_to :user, :class_name => "User", :foreign_key => :user_id
end
