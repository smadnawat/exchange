class Book < ActiveRecord::Base

	belongs_to :user
	reverse_geocoded_by :latitude, :longitude
	after_validation :reverse_geocode 
	scope :details, -> {Book.order(:upload_date_for_admin).map{|x| x}.uniq{|x| x.upload_date_for_admin}}
	before_save :update_date_admin, :if => :new_record?
	before_save :update_country_name
    
    validates :user_id, :uniqueness => {:scope => [:isbn13] , :message => "Book Already Catalogued"}, if: 'isbn13.present?'

	def update_date_admin
	  self.upload_date_for_admin = Date.today		
	end

	def update_country_name
	  self.country_name = self.address.split(',').last	
	end

end
