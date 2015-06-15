class Book < ActiveRecord::Base
	  belongs_to :user
	  attr_reader :form_buffers
	   # scope :details, -> {  Book.order(:created_at).map{|x| x.attributes.merge!(my_date: x.created_at.to_date)}.uniq{|x| x["my_date"]} }
	   # Book.order(:created_at).map{|x| x.attributes.merge!(my_date: x.created_at.to_date)}.uniq{|x| x["my_date"]}
end
