class Book < ActiveRecord::Base

	belongs_to :user
	has_many :invitations, :dependent => :destroy
	has_many :notices, :dependent => :destroy
	reverse_geocoded_by :latitude, :longitude
	after_validation :reverse_geocode 
	scope :details, -> {Book.order(:upload_date_for_admin).map{|x| x}.uniq{|x| x.upload_date_for_admin}}
	before_save :update_date_admin, :if => :new_record?
    
    validates_uniqueness_of :title, :allow_blank => true, :message => "already exists."

	def update_date_admin
	  self.upload_date_for_admin = Date.today		
	end

end

