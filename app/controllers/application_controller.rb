class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # protect_from_forgery 
layout "application"
  def render_message code,message
  	  render :json => {:responseCode => code,:responseMessage => message}
  end

  def find_user
    p"-------------------#{params.inspect}========================="
    @user = User.find_by_id(params[:user_id])
    unless @user
      render_message 404, "user doesn't exists."     
    end   
  end

end
