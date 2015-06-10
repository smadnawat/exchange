class Book < ActiveRecord::Base
	  belongs_to :user
	       attr_reader :form_buffers
end
