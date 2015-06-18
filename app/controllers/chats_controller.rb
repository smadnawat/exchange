class ChatsController < ApplicationController
	before_filter :find_user
	

	def chat_exchange
		@invitation = @user.invitations.build(:attendee => params[:reciever_id],:invitation_type =>	params[:invitation_type],:status => "pending",:book_id => params[:book_id])
		if @invitation.save
			Notification.create_notification(@user,params[:reciever_id],params[:invitation_type],params[:book_id],@invitation)
			render :json => {:responseCode => 200,:responseMessage => 'Invitation is successfully sent'} 
		else
			render :json => {:responseCode => 500,:responseMessage => 'Something went wrong'} 			 
		end
	end

	def accept_decline 
		@invitation = Invitation.find_by_id(params[:invitation_id])
		if @invitation.update_column(:status,params[:action_type])
			Notification.create_notification(@user,@invitation.user_id,params[:action_type],params[:book_id],@invitation)
		render :json => {:responseCode => 200,:responseMessage => "Request is successfully #{params[:action_type]}"}
		else
			render :json => {:responseCode => 500,:responseMessage => 'Something went wrong'} 
		end
	end 

	def get_notification_list
		@notifications = @user.recieve_notifications
		#@notifications = @notifications.each{|n| n[:message] = Notification.alert(n.user,n.action_type)}
		@notifications.each do |notification|
			notification.message = Notification.alert(notification.user,notification.action_type)
		end
		render :json => @notifications.as_json(:only => [:message,:id,:invitation_id,:created_at])
	end



	private

	def method_name
		params.permit!
	end
	
end
