class MypasswordsController < ApplicationController

    def create
		@user = User.find_by(:email => params[:email])
		if @user
			User.send_token(@user)
			render :json => {:responseCode => 200,:responseMessage => "Email instructions has been sent successfully."}
		else
			render :json => {:responseCode => 500,:responseMessage => "Please check email, it doesn't exist."}
		end	 
	end

	def update
		@user = User.find_by_reset_password_token(params[:reset_password_token])
		unless @user.nil?
		if @user.reset_password_sent_at > Time.zone.now + 8.hours 
			 @user.reset_password_token = nil
				  render :json => {:responseCode => 400,:responseMessage => "You can't access this page without coming from a password reset email. If you do come from a password reset email, please make sure you used the full URL provided."}
		elsif @user.update_attributes(:password => params[:password], password_confirmation: params[:password_confirmation], reset_password_token: nil)
			  render :json => {:responseCode => 200,:responseMessage => "Password has been reset successfully"}
		 else
		  render_message 402, @user.errors.full_messages 
		end
		else
			render :json => {:responseCode => 500,:responseMessage => "The token doesn't match."}
		end  
	end

 private
	
  def permitted_params
  	params.permit(:email, :password, :reset_password_token, :reset_password_sent_at)
  end

end
