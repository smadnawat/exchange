class NotificationsController < ApplicationController
      
 
  def do_create
    p"=====do_create==========================="
    p"++++++++++++++++++#{params.inspect}++++++++++++++++"
    if params[:Author].present?
      p"----------in author==============="
         ReadingPreference.where(:author =>  params[:Author] ).map {|um|  um.user.devices.select {|rpm| ApplePushWorker.perform_async(rpm.device_id,rpm.device_type, "#{params[:notification][:subject]}", "#{params[:notification][:content]}") }}
      p"----------in author=============after worker=="
       redirect_to admin_notifications_path
    elsif params[:genre].present?
      p"----------in genre==============="

         ReadingPreference.where(:genre =>  params[:genre] ).map {|um|  um.user.devices.select {|rpm| ApplePushWorker.perform_async(rpm.device_id,rpm.device_type, "#{params[:notification][:subject]}", "#{params[:notification][:content]}"  ) }}
      p"----------in genre===========after worker===="
         redirect_to admin_notifications_path
    elsif params[:location].present?
      p"----------in location==============="

        User.where(:location => params[:location] ).map{|user| user.devices.select {|rpm| ApplePushWorker.perform_async(rpm.device_id,rpm.device_type,"#{params[:notification][:subject]}", "#{params[:notification][:content]}") }}
      p"----------in location===========after location===="
           redirect_to admin_notifications_path
    elsif params[:user].present?
      p"----------in user==============="

          User.all.map{|user| user.devices.select {|rpm| ApplePushWorker.perform_async(rpm.device_id,rpm.device_type, "#{params[:user][:subject]}", "#{params[:user][:content]}") }}
      p"----------in user============after worker==="
         redirect_to admin_notifications_path
    else 
      p"============else block"
         redirect_to admin_notifications_path
        
         flash[:notice]= 'Invalid..Please Select Atleast One'
    end

     
  end
	

end
