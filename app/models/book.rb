class Book < ActiveRecord::Base
	belongs_to :user
	has_many :invitations, :dependent => :destroy
	has_many :notices, :dependent => :destroy
	reverse_geocoded_by :latitude, :longitude
	after_validation :reverse_geocode 
	scope :details, -> {Book.order(:upload_date).map{|x| x}.uniq{|x| x.upload_date}}
     # scope :details, -> {Book.order(:created_at).map{|x| x}.uniq{|x| x.created_at.to_date}}
end

