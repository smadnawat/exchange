class ApisController < ApplicationController

	def register	
	  # params[:service].delete(:device_id)
	  # params[:service].delete(:device_type)
		if params[:provider].present? && params[:provider] == User::A
			if @user = User.where('email = ?  AND provider !=?',params[:email],'normal').first					
		        render :json => {:responseCode => 200,:responseMessage => "Email id #{@user.email} is already registered with ExchangeApp through a #{@user.provider} account. Please login via same."} 
			else	
				@user = User.new(permitted_params)
				@user.devices.build(:device_id=>params[:device_id],:device_type=>params[:device_type])
					if @user.save	
						render :json => {:responseCode => 200,:responseMessage => 'Your registration process is successfull.', :user_id => @user.id	} 
					else
						render :json => {:responseCode => 500, :responseMessage => @user.errors.full_messages.first}			
					end
			end
		elsif (params[:provider].present? && params[:provider] == User::B) || (params[:provider].present? && params[:provider] == User::C)
			@user = User.find_by_provider_and_u_id(params[:provider],params[:u_id])
				if @user.present? #&& @user.email.eql?(params[:email])
				   @user.update_via_social_media(params) # update_via_social_media is a instance method in User Model
				   render :json => {:responseCode => 200,:responseMessage => 'Logged in successfull.', :user_id => @user.id	}
				elsif @user = User.where('email = ? AND provider = ?',params[:email],'normal').first					
		        	render :json => {:responseCode => 500,:responseMessage => "Email ID #{@user.email} is already registered with ExchangeApp. Please login via same."} 
			    else     
				   @user = User.create_via_social_media(params) # create_via_social_media is a class method in User Model
				   # @user = User.create(permitted_params)
				   render :json => {:responseCode => 200,:responseMessage => 'Signed-up successfully.', :user_id => @user.id	}	
				end		
		else
			render_message 401, 'Unauthorized access!'
		end
	end

 private

  def permitted_params
    params.permit(:email, :username, :password, :password_confirmation, :gender, :location, :picture, :author_prefernce, :genre_preference, :date_signup, :latitude, :longitude, :provider, :u_id)
  end

end
