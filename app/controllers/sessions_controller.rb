class SessionsController < ApplicationController
    before_filter :find_user ,:only => [:destroy]	

	def create
	    @user = User.where("email = ? or username = ?",params[:email],params[:username]).first
	  	if @user and @user.authenticate(params[:password])
	  	  Device.total_devices(params[:device_id],params[:device_type],@user.id) unless params[:device_id].nil?
	  	  render :json => {:responseCode => 200,:responseMessage => "You've signed in successfully.",   :user_id => @user.id}
	  	else
	  	  	render :json => {:responseCode => 500,:responseMessage => "Unauthorised access."}
	  	end	
    end


	def destroy  
	    if @user  
	      auth = Device.where(:user_id => @user.id, :device_id => params[:device_id],:device_type=>params[:device_type])      
	      Rails.logger.info"=====#{params.inspect}=======#{auth.inspect}======"
	      auth.destroy_all  unless auth.blank?   
	  		render :json => { :responseCode => 200,:responseMessage => "You've been logged out successfully!." }
	  	else
	  	  render :json => { :responseCode => 500, :responseMessage => "You are not logged in currently, Please login first." }
	  	end	                	                
	end	
end
