class SessionsController < ApplicationController
    before_filter :find_user ,:only => [:destroy]	

	def create
	    @user = User.where("email = ? or username = ?",params[:email],params[:username]).first
	    if @user.sign_in_token.present? 
	    	render :json => {:responseCode => 500, :responseMessage => "Please confirm your account first at your email address."}
		else	
		  	if @user and @user.authenticate(params[:password])
		  	  Device.total_devices(params[:device_id],params[:device_type],@user.id) unless params[:device_id].nil?
		  	  render :json => {:responseCode => 200,:responseMessage => "You've signed in successfully.",   :user_id => @user.id}
		  	else
		  	  render :json => {:responseCode => 500,:responseMessage => "Unauthorised access."}
		  	end
		end	  		
    end


	def destroy  
	    if @user  
	      auth = Device.where(:user_id => @user.id)      
	      Rails.logger.info"=====#{params.inspect}=======#{auth.inspect}======"
	      auth.destroy_all  unless auth.blank?   
	  		render :json => { :responseCode => 200,:responseMessage => "You've been logged out successfully!." }
	  	else
	  	  render :json => { :responseCode => 500, :responseMessage => "You are not logged in currently, Please login first." }
	  	end	                	                
	end	
end
