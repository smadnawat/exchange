class Book < ActiveRecord::Base
	belongs_to :user
	has_many :invitations, :dependent => :destroy
	has_many :notifications, :dependent => :destroy
	reverse_geocoded_by :latitude, :longitude
	after_validation :reverse_geocode 
end

