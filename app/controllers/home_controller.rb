class HomeController < ApplicationController

	def dashboard
	end

	def privacy_policy	
	end

	def terms_of_use		
	end

	def about_us		
	end

	def my_team		
	end

	def contact_us
	  contact_us = ContactU.new(params_permit)
		if contact_us.save
			contact_data = ContactU.find(contact_us.id)
        UserMailer.sending_contact_details(contact_data).deliver
			flash[:notice] = "Your Contact Us form has been submitted successfully"
			redirect_to thank_you_path
		end	
	end

	def thank_you		
	end

	def download_csv
		@contact = ContactU.all
		render text: @contact.to_csv(col_sep: "\t") 
	end

	private

	def params_permit
		params.require(:contact_us).permit!
	end

end
