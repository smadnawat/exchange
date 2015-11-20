class ContactU < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
	 validates :name, :surname, :email, :country, presence: true
	 validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
	
	def self.to_csv(options = {})
	  CSV.generate(options) do |csv|
	    csv << column_names
	    all.each do |product|
	      csv << product.attributes.values_at(*column_names)
	    end
	  end
	end

end
