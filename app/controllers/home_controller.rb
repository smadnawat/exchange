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
			redirect_to thank_you_path( :id => contact_us.id, :join_event => params[:join_event] )
		end	
	end

	def thank_you
		if request.fullpath.include?("India")
			redirect_to "https://www.facebook.com/events/1784356635125021/"
		elsif request.fullpath.include?("Indonesia")
			redirect_to "https://www.facebook.com/events/960701244014746/"
		elsif request.fullpath.include?("Philippines")
			redirect_to "https://www.facebook.com/events/644898388946334/"
		else
			@contact_us = ContactU.find(params[:id]) if params[:id]
		end
	end

	def download_csv
		@contact = ContactU.all
		render text: @contact.to_csv(col_sep: "\t") 
	end

	def receive_news_letter
		user = User.find_by(mat_email_token: params[:token])
		if user 
			user.update_attributes(mat_email_token: nil)
		  PotentialMatchWorker.perform_async(user.id)			
			flash.now[:notice] = 'You will get your List of Free Books on your Registered Email'
		else
			flash.now[:notice] = 'Invalid link or link has been already used'
		end
	end

	def unsubscribe
		user = User.find_by(unsubscription_token: params[:token])
		if user 
			user.update_attributes(unsubscription_token: nil,is_subscribe: false)
			flash.now[:notice] = 'You have been successfully unsubscribed'
		else
			flash.now[:notice] = 'Invalid link or or you already unsubscribed'
		end
	end


	private

	def params_permit
		params.require(:contact_us).permit!
	end

end
