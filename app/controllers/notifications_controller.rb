class NotificationsController < ApplicationController
  def do_create
    if params[:Author].present?
         ReadingPreference.where(:author =>  params[:Author] ).map {|um|  um.user.devices.select {|rpm| AdminPushWorker.perform_async(rpm.device_id,rpm.device_type, "#{params[:notification][:subject]}", "#{params[:notification][:content]}") }}
   
       redirect_to admin_notification_path
         flash[:notice]= 'Notification Send'

    elsif params[:genre].present?
         ReadingPreference.where(:genre =>  params[:genre] ).map {|um|  um.user.devices.select {|rpm| AdminPushWorker.perform_async(rpm.device_id,rpm.device_type, "#{params[:notification][:subject]}", "#{params[:notification][:content]}"  ) }}
      
         redirect_to admin_notification_path
         flash[:notice]= 'Notification Send'

    elsif params[:location].present?
        User.where(:location => params[:location], is_block: 'false' ).map{|user| user.devices.select {|rpm| AdminPushWorker.perform_async(rpm.device_id,rpm.device_type,"#{params[:notification][:subject]}", "#{params[:notification][:content]}") }}

           redirect_to admin_notification_path
         flash[:notice]= 'Notification Send'

    elsif params[:user].present?
          User.all.where(:is_block => 'false').map{|user| user.devices.select {|rpm| AdminPushWorker.perform_async(rpm.device_id,rpm.device_type, "#{params[:user][:subject]}", "#{params[:user][:content]}") }}
      
         redirect_to admin_notification_path
         flash[:notice]= 'Notification Send'

    else
         redirect_to admin_notification_path
         flash[:notice]= 'Invalid..Please Select Atleast One'
    end
  end

	def notfound
      flash[:notice] = "Invalid Path"
          redirect_to admin_users_path
    end 

    def welcome
        redirect_to new_admin_user_session_path
    end

end
