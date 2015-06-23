AdminPushWorkerclass NotificationsController < ApplicationController
   def index
      @notifications = Book.details
  end   
 
  def do_create
    if params[:Author].present?
       rpuser = ReadingPreference.where(:author =>  params[:Author] ).map{|rpm| rpm.user if rpm.user.is_block == false}.uniq.compact
       unless rpuser.blank?
          rpuser.each do |rp|
             rp.devices.select {|rpm| AdminPushWorker.perform_async(rpm.device_id,rpm.device_type, "#{params[:notification][:subject]}", "#{params[:notification][:content]}"  ) } 
             flash[:notice]= 'Notification Send'
          end
       else
            flash[:notice]= 'Notification cant be Sent because all users are blocked'
       end 
      redirect_to admin_notification_path
    elsif params[:genre].present?
      rpuser = ReadingPreference.where(:genre =>  params[:genre] ).map{|rpm| rpm.user if rpm.user.is_block == false}.uniq.compact
      unless rpuser.blank?
         rpuser.each do |rp|
           rp.devices.select {|rpm| AdminPushWorker.perform_async(rpm.device_id,rpm.device_type, "#{params[:notification][:subject]}", "#{params[:notification][:content]}"  ) } 
           flash[:notice]= 'Notification Send'
         end
      else
          flash[:notice]= 'Notification cant be Sent because all users are blocked'
    end 
       redirect_to admin_notification_path
     
    elsif params[:location].present?
       rpuser =  User.where(:location => params[:location], is_block: 'false').uniq
       if rpuser.present?
         rpuser.each do |rp|
           rp.devices.select {|rpm| AdminPushWorker.perform_async(rpm.device_id,rpm.device_type, "#{params[:notification][:subject]}", "#{params[:notification][:content]}"  ) } 
           flash[:notice]= 'Notification Send'
         end
      else
          flash[:notice]= 'Notification cant be Sent because all users are blocked'
      end 
          redirect_to admin_notification_path
    elsif params[:user].present?
       rpuser = User.all.where(:is_block => 'false').uniq
       if rpuser.present?
         rpuser.each do |rp|
            rp.devices.select {|rpm| AdminPushWorker.perform_async(rpm.device_id,rpm.device_type, "#{params[:notification][:subject]}", "#{params[:notification][:content]}"  ) } 
            flash[:notice]= 'Notification Send'
         end
      else
          flash[:notice]= 'Notification cant be Sent because all users are blocked'
      end
         redirect_to admin_notification_path
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
