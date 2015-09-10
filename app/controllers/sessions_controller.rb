class SessionsController < ApplicationController
    before_filter :find_user ,:only => [:destroy]	

	def create
	    @user = User.where("email = ? or username = ?",params[:email],params[:username]).first
	    if @user and @user.sign_in_token.present? 
	    	render :json => {:responseCode => 500, :responseMessage => "Please confirm your account first at your email address."}
		  else	
		  	if @user and @user.authenticate(params[:password])
		  		manage_devices(@user)
  		        @user.update_attributes(latitude: params[:latitude], longitude: params[:longitude])	
		  	  #Device.total_devices(params[:device_id],params[:device_type],@user.id) unless params[:device_id].nil?
		  	  render :json => {:responseCode => 200,:responseMessage => "You've signed in successfully.",   :user_id => @user.id}
		  	else
		  	  render :json => {:responseCode => 500,:responseMessage => "Please make sure your email and password is correct."}
		  	end
		end	  		
  end



	def destroy  
	    if @user  
	      auth = Device.where(:user_id => @user.id, :device_id => params[:device_id])      
	      Rails.logger.info"=====#{params.inspect}=======#{auth.inspect}======"
	      auth.destroy_all  unless auth.blank?   
	  		render :json => { :responseCode => 200,:responseMessage => "You've been logged out successfully!." }
	  	else
	  	  render :json => { :responseCode => 500, :responseMessage => "You are not logged in currently, Please login first." }
	  	end	                	                
	end	
	
	private

	def manage_devices(user)
		unless params[:device_id].nil?  
			@devices = Device.where(:device_id => params[:device_id])
			@devices.destroy_all unless @devices.blank?
			@devices = user.devices.create(:device_type => params[:device_type],:device_id => params[:device_id])
		end
	end
end
