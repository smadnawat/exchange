require 'distance'

class ChatsController < ApplicationController

	include CalculateDistance

	before_filter :find_user

	def chat_exchange
		@invitation = @user.invitations.build(:attendee => params[:reciever_id],:invitation_type =>	params[:invitation_type],:status => "pending",:book_id => params[:book_id])
		if @invitation.save!
			Notice.create_Notice(@user,params[:reciever_id],params[:invitation_type],params[:book_id],@invitation)
			render :json => {:responseCode => 200,:responseMessage => 'Invitation is successfully sent'} 
		else
			render :json => {:responseCode => 500,:responseMessage => 'Something went wrong'} 			 
		end
	end

	def accept_decline 
	@invitation = Invitation.find_by_id(params[:invitation_id])
		if @invitation.update_column(:status,params[:action_type])
			Notice.create_Notice(@user,@invitation.user_id,params[:action_type],params[:book_id],@invitation)
			book = Book.find(params[:book_id])
			if params[:action_type] == "Accept"
			@is_group = Group.find_by_name_and_admin_id("#{book.title}", @invitation.user_id)
			 if @is_group
			 	@is_group.users << @user
			 else
			@group = Group.create(:name => book.title, :admin_id => @invitation.user_id,
			:get_book_id => params[:get_book_id], :give_book_id => params[:give_book_id])
				if !@group.users.include?(params[:user_id])
          @sender = User.find(@invitation.user_id)
					@group.users << @user
					@group.users << @sender
				end
			 end
			end
		render :json => 
		               {
	               	 :responseCode => 200,
	               	 :responseMessage => "Request is successfully #{params[:action_type]}",
                   :group_id => @group.as_json(only: [:id]) 
		               }
		else
			render :json => {
											:responseCode => 500,
											:responseMessage => 'Something went wrong'
											} 
		end
	end

	def get_notification_list
		@notifications = @user.recieve_notifications
		@notifications.each do |notification|
			notification.message = Notice.alert(notification.user,notification.action_type)
		end
		render :json => {
                           :responseCode => 200,
                           :responseMessage => "Your notifications list is fetched successfully!",
                           :notifications => @notifications.as_json(:only => [:message,:id,:invitation_id,:created_at, :action_type])
			            } 
	end


	def group_chat
		if Block.find_by_user_id_and_group_id(params[:user_id], params[:group_id]).present?
			render :json => {:responseCode => 200,:responseMessage => "You are blocked by the admin"}
		else
			params[:picture] = User.image_data(params[:media])
			@group = Group.find(params[:group_id])
			@message = @group.messages.build(:message => params[:message],:media => params[:media], :sender_id=> @user.id )
				if @message.save
				  render :json => {:responseCode => 200,:responseMessage => "Message sent successfully"}
			  else
				   render :json => {:responseCode => 500,:responseMessage => 'Something went wrong'} 
			  end
		end
	end

	def get_chat
		@group = Group.find_by_id(params[:group_id])
		if @group
			@chat = []
			@group.messages.each do |msg|
        @chat << msg.user.picture
        @chat << msg
			end
      
			render :json => {
											:responseCode => 200,:responseMessage => "Chat history fetched successfully",
											:chat => paging(@chat, params[:page_no],params[:page_size]).as_json(except: [:created_at,:updated_at]),
								      :pagination => { page_no: params[:page_no],max_page_no: @max, total_no_records: @total }
											}
		else
			render :json => {:responseCode => 500,:responseMessage => 'Something went wrong'} 
		end
	end

	def group_detail
		@group = Group.find_by_id(params[:group_id])
		if @group
			@get_book_id = Book.find_by_id(@group.get_book_id)
			@give_book_id = Book.find_by_id(@group.give_book_id)
			blocked_user_ids = @group.blocks.map(&:user_id)
			@users = @group.users.map{|u| blocked_user_ids.include?(u.id) ? (u.attributes.except('created_at','updated_at','gender', 'email', 'password_digest','author_prefernce', 'genre_preference', 'location', 'date_signup', 'latitude', 'longitude', 'provider', 'u_id', 'device_used', 'is_block', 'reset_password_token', 'reset_password_sent_at').merge(blocked: 1) ): (u.attributes.except('created_at','updated_at','gender', 'email', 'password_digest','author_prefernce', 'genre_preference', 'location', 'date_signup', 'latitude', 'longitude', 'provider', 'u_id', 'device_used', 'is_block', 'reset_password_token', 'reset_password_sent_at').merge(blocked: 0)) }
			 render :json => {
											:responseCode => 200,
											:responseMessage => "Group details fetched successfully",
											:Group => @group.as_json(except: [:created_at,:updated_at, :get_book_id, :give_book_id]),
											:book_to_get => @get_book_id.as_json(only: [:id,:title]), 
											:book_to_give => @give_book_id.as_json(only: [:id,:title]),
											:group_users => @users
											}
		else
			render :json => {
											:responseCode => 500,
											:responseMessage => "Group not found" 
											}
		end
	end

	def block_users
	@group = Group.find_by_id_and_admin_id(params[:group_id], @user)
		if @group.present?
			@is_block = Block.find_by_user_id_and_group_id(params[:member_id], @group)
			if @is_block.present?
				message = "This user is already blocked.."
				block = nil
			else
				@block = @group.blocks.create(:user_id => params[:member_id])
				message = "Member blocked successfully.."
				block = @block
			end
			render :json => {
											:responseCode => 200,
											:responseMessage => message,
											:block => block.as_json(except: [:created_at,:updated_at]) 
											}
		else
			render :json => {
											:responseCode => 500,
											:responseMessage => 'Something went wrong'
											} 
		end
	end

	def unblock_user
		@blocked_user = Block.find_by_id(params[:block_id])
		if @blocked_user
			@blocked_user.destroy
			render :json => {:responseCode => 200,:responseMessage => "Successfully done"}
	  else
	  	render :json => {:responseCode => 200,:responseMessage => "this user is not found in the blocked list"}
	  end
	end

	def search_user
		@users = User.search_user_to_add_group(params[:user_name])
		if @users.present?
			render :json => {
							:responseCode => 200,
							:responseMessage => "Users are are",
							:search_result => @users.as_json(only: [:id, :username, :picture, :email, :gender]) 
							}
		else
			render :json => {:responseCode => 500,:responseMessage => 'Something went wrong'} 
		end
	end

	def add_user_to_group
		@group = Group.find_by_id_and_admin_id(params[:group_id], @user.id)
			if @group.present?
					@member = User.find_by_id(params[:member_id])
							if @group.users.include?(@member)
								@message = "User is Already in group"
							else
								@group.users << @member
								@message = "User added successfully"
							end
					render :json => {
														:responseCode => 200,
														:responseMessage => @message
													}
			else
					render :json => {
														:responseCode => 500,
														:responseMessage => 'Something went wrong'
													} 
			end				
	end

	private

	def method_name
		params.permit!
	end
	
end
