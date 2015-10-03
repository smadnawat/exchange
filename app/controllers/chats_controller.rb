require 'distance'

class ChatsController < ApplicationController

	include CalculateDistance

	before_filter :find_user, :except => [:user_grp_detail]

	def chat_exchange
		if params[:data] == "B"
		 @invitation = @user.invitations.build(:attendee => params[:reciever_id],:invitation_type =>	params[:invitation_type],:status => "pending",:book_to_give => params[:book_to_give], :book_to_get => params[:book_to_get], :invitation_status => params[:data])
		elsif params[:data] == "RP"
		 @invitation = @user.invitations.build(:attendee => params[:reciever_id],:invitation_type =>	params[:invitation_type],:status => "pending",:book_to_give => params[:book_to_give], :book_to_get => params[:book_to_get], :invitation_status => params[:data])
    else  
     @invitation = @user.invitations.build(:attendee => params[:reciever_id],:invitation_type =>	params[:invitation_type],:status => "pending",:book_to_give => params[:book_to_give], :book_to_get => params[:book_to_get], :invitation_status => params[:data])
    end

		if @invitation.save
			Notice.create_Notice(@user,params[:reciever_id],params[:invitation_type],params[:book_to_give],@invitation,"",params[:data])
			render :json => {:responseCode => 200,:responseMessage => 'Invitation is successfully sent'} 
		else
			render :json => {:responseCode => 500,:responseMessage => 'Something went wrong'} 
		end
	end

  def accept_decline
		if params[:data] == "B"
			accept_decline_with_book
		elsif params[:data] == "ED"
			accept_decline_with_education
		else
			accept_decline_with_reading_preference
		end
	end

	def accept_decline_with_book
		book = Book.find_by_id(params[:book_to_give])
		if (book.title.present? or book.author.present? or book.genre.present?)
		  @invitation = Invitation.find_by_id(params[:invitation_id])
			if @invitation.update_column(:status,params[:action_type])
				if params[:action_type] == "Accept"
				  @is_group = Group.find_by_get_book_id_and_admin_id_and_give_book_id(params[:book_to_get], @invitation.user_id, params[:book_to_give])
				  if !@is_group.nil?
				 	 @group = @is_group
					  if @is_group.users.include?(@user)
				   		@message = "Already in that group"
				   	else
				 	  	@is_group.users << @user
					 	 	@message = "Invite have been successfully Accepted."   
				  	end
				  else
				  	if book.title.present?
					    @group = Group.create(:name => book.title, :admin_id => @invitation.user_id,

					    :get_book_id => params[:book_to_get], :give_book_id => params[:book_to_give], :manager_id => @user.id)
				  	elsif book.author.present?
				  		@group = Group.create(:name => book.author, :admin_id => @invitation.user_id,
				    :get_book_id => params[:book_to_get], :give_book_id => params[:book_to_give], :manager_id => @user.id)
				  	else
				  		@group = Group.create(:name => book.genre, :admin_id => @invitation.user_id,
				    :get_book_id => params[:book_to_get], :give_book_id => params[:book_to_give], :manager_id => @user.id)

				  	end
	            @sender = User.find(@invitation.user_id)
						  @group.users << @user
					  	@group.users << @sender
					  	@message = "Invite have been successfully Accepted."
				  end
				  Notice.create_Notice(@user,@invitation.user_id,params[:action_type],params[:book_to_give],@invitation,@group.id,'')	
				else
					@message = "Invite have been successfully Declined."
	        Notice.create_Notice(@user,@invitation.user_id,params[:action_type],params[:book_to_give],@invitation,"unavailable",params[:data])	
				end
			
		   render :json => 
		   {
		 	 :responseCode => 200,
		 	 :responseMessage => @message,
		   :group_id => @group.as_json(only: [:id]) 
		   }
			else
			  render :json => 
				{
				:responseCode => 500,
				:responseMessage => 'Something went wrong'
				} 
			end
		else
			render :json => 
			{
			:responseCode => 500,
			:responseMessage => 'No matches found'
			} 
		end
	end


	def accept_decline_with_education
		book = Book.find_by_id(params[:book_to_give])
		if (book.title.present? or book.author.present? or book.genre.present?)
		  @invitation = Invitation.find_by_id(params[:invitation_id])
			if @invitation.update_column(:status,params[:action_type])
				if params[:action_type] == "Accept"
				  @is_group = Group.find_by_admin_id_and_give_book_id_and_get_book_id(@invitation.user_id, params[:book_to_give], nil)
				  if !@is_group.nil?
				 	 @group = @is_group
					  if @is_group.users.include?(@user)
				   		@message = "Already in that group"
				   	else
				 	  	@is_group.users << @user
					 	 	@message = "Invite have been successfully Accepted."
				  	end
				  else
				  	if book.title.present?
					    @group = Group.create(:name => book.title, :admin_id => @invitation.user_id, :give_book_id => params[:book_to_give], :manager_id => @user.id)
				  	elsif book.author.present?
				  		@group = Group.create(:name => book.author, :admin_id => @invitation.user_id, :give_book_id => params[:book_to_give], :manager_id => @user.id)
				  	else
				  		@group = Group.create(:name => book.genre, :admin_id => @invitation.user_id, :give_book_id => params[:book_to_give], :manager_id => @user.id)

				  	end
	            @sender = User.find(@invitation.user_id)
						  @group.users << @user
					  	@group.users << @sender
					  	@message = "Invite have been successfully Accepted."
				  end
				  Notice.create_Notice(@user,@invitation.user_id,params[:action_type],params[:book_to_give],@invitation,@group.id,params[:data])	
				else
					@message = "Invite have been successfully Declined."
	        Notice.create_Notice(@user,@invitation.user_id,params[:action_type],params[:book_to_give],@invitation,"unavailable",params[:data])	
				end
			
		   render :json => 
		   {
		 	 :responseCode => 200,
		 	 :responseMessage => @message,
		   :group_id => @group.as_json(only: [:id]) 
		   }
			else
			  render :json => 
				{
				:responseCode => 500,
				:responseMessage => 'Something went wrong'
				} 
			end
		else
			render :json =>  
			{
			:responseCode => 500,
			:responseMessage => 'No matches found'
			} 
		end
	end



	def accept_decline_with_reading_preference
	 @reading_preference	= ReadingPreference.find_by_id(params[:book_to_give])
		if (@reading_preference.author.present? or @reading_preference.genre.present?)
		  @invitation = Invitation.find_by_id(params[:invitation_id])
			if @invitation.update_column(:status,params[:action_type])
				if params[:action_type] == "Accept"
				  @is_group = Group.find_by_admin_id_and_get_preference_and_give_preference(@invitation.user_id, params[:book_to_get], params[:book_to_give])
				  if !@is_group.nil?
				 	 @group = @is_group
					  if @is_group.users.include?(@user)
				   		@message = " "
				   	else
				 	  	@is_group.users << @user
					 	 	@message = "Invite have been successfully Accepted."
				  	end
				  else
				  	if @reading_preference.author.present?
				  		@group = Group.create(:name => @reading_preference.author, :admin_id => @invitation.user_id,

				    :get_preference => params[:book_to_get], :give_preference => params[:book_to_give], :manager_id => @user.id)
				  	else
				  		@group = Group.create(:name => @reading_preference.genre, :admin_id => @invitation.user_id,
				    :get_preference => params[:book_to_get], :give_preference => params[:book_to_give], :manager_id => @user.id)

				  	end
	            @sender = User.find(@invitation.user_id)
						  @group.users << @user
					  	@group.users << @sender
					  	@message = "Invite have been successfully Accepted."
				  end
				  Notice.create_Notice(@user,@invitation.user_id,params[:action_type],params[:book_to_give],@invitation,@group.id,params[:data])	
				else
					@message = "Invite have been successfully Declined."
	        Notice.create_Notice(@user,@invitation.user_id,params[:action_type],params[:book_to_give],@invitation,"unavailable",params[:data])	
				end
			
		   render :json => 
		   {:responseCode => 200,:responseMessage => @message, :group_id => @group.as_json(only: [:id]) }
			else
			  render :json => {:responseCode => 500,:responseMessage => 'Something went wrong' } 
			end
		else
			render :json => {:responseCode => 500,:responseMessage => 'No matches found' } 
		end
	end


	def get_notification_list
		@notifications = @user.recieve_notifications.includes(:user)
		@notifications.each do |notification|
			notification.message = Notice.alert(notification.user,notification.action_type)
		end
		render :json => {
                      :responseCode => 200,
                      :responseMessage => "Your notifications list is fetched successfully!",
                      :notifications => @notifications.map{|notification| notification.attributes.except('updated_at','pending','user_id','book_to_give','reciever_id').merge( data: ( notification.invitation_id.present? ? (Invitation.find_by_id(notification.invitation_id).invitation_status) : 'adduser' ) ) }#@notifications.as_json(:only => [:message,:id,:invitation_id,:created_at, :action_type]) 
                                          
			              } 
	end

	def group_chat
		if Block.find_by_user_id_and_group_id(params[:user_id], params[:group_id]).present?
			render :json => {:responseCode => 200,:responseMessage => "You are blocked by the admin"}
		else
			params[:media] = User.image_data(params[:media])
			@group = Group.find(params[:group_id])
			@group_users = @group.users.where(id: @group.user_groups.where('is_deleted is null or is_deleted =?',false).pluck(:user_id))
			@block_user = Block.find_by_user_id_and_group_id(params[:user_id], params[:group_id])
			@message = @group.messages.build(:message => params[:message],:media => params[:media], :sender_id=> @user.id)
				if @message.save
            #@group_users.reject{|u| (u.id == @user.id || (@block_user.present? and u.id == @block_user.user_id))}.each do |user|
             # user.devices.each {|device| (device.device_type == "Android") ? AndroidPushWorker.perform_async(nil, ((@message.message.present?) ? @message.message : (@message.user.username + "has shared an image.")), nil, device.device_id, "message", nil, @group.id, nil) : ApplePushWorker.perform_async(nil, ((@message.message.present?) ? @message.message : (@message.user.username + "has shared an image.")), nil, device.device_id, "message", nil, @group.id, nil) } 
            #end				   
 				   render :json => {:responseCode => 200,:responseMessage => "Message sent successfully"}
			  else
				   render :json => {:responseCode => 500,:responseMessage => 'Something went wrong'} 
			  end
		end
	end

	def get_chat
		@group = Group.where(:id => params[:group_id]).first
		if @group
			render :json => 
                {
                 :responseCode => 200,	
			           :responseMessage => "Chat List fetched successfully!",
			           :chat_list => paging(@group.messages.order('id desc').includes(:user), params[:page_no],params[:page_size]).as_json(except: [:updated_at],:include => {:user => {:only => [:picture]}}),
		             :pagination => { page_no: params[:page_no],max_page_no: @max,total_no_records: @total }	                   

		            } 
		else
			render :json => {:responseCode => 500,:responseMessage => 'Something went wrong'} 
		end
	end

	def group_detail
		@group = Group.find_by_id(params[:group_id])
		if @group
			if @group.get_book_id.present? and @group.give_book_id.present?
				 @get_book_id = Book.find_by_id(@group.get_book_id) 
				 @give_book_id = Book.find_by_id(@group.give_book_id)
			elsif @group.get_preference.present? and @group.give_preference.present?	
				@get_book_id_rp = ReadingPreference.find_by_id(@group.get_preference)
				@give_book_id_rp = ReadingPreference.find_by_id(@group.give_preference)
			else
			  @give_book_id_ed = Book.find_by_id(@group.give_book_id)	
			end
				blocked_user_ids = @group.blocks.map(&:user_id)
				@users = @group.users.map{|u| blocked_user_ids.include?(u.id) ? (u.attributes.except('created_at','updated_at','gender', 'email', 'password_digest','author_prefernce', 'genre_preference', 'location', 'date_signup', 'latitude', 'longitude', 'provider', 'u_id', 'device_used', 'is_block', 'reset_password_token', 'reset_password_sent_at').merge(blocked: 1, picture: u.picture) ): (u.attributes.except('created_at','updated_at','gender', 'email', 'password_digest','author_prefernce', 'genre_preference', 'location', 'date_signup', 'latitude', 'longitude', 'provider', 'u_id', 'device_used', 'is_block', 'reset_password_token', 'reset_password_sent_at').merge(blocked: 0, picture: u.picture)) }
				 render :json => {
													:responseCode => 200,
													:responseMessage => "Group details fetched successfully",
													:Group => @group.as_json(except: [:created_at,:updated_at]),
													:book_to_get => @get_book_id, 
													:book_to_give => @give_book_id,
													:book_to_get_rp => @get_book_id_rp,
													:book_to_give_rp => @give_book_id_rp,
													:book_to_give_ed => @give_book_id_ed,
													:group_users => @users
											  }
		else
			render :json => {:responseCode => 500,:responseMessage => "Group not found" }
		end
	end

	def block_users
	 @group = Group.find_by_id_and_admin_id(params[:group_id], @user.id)
			if @group.present?
				@blocked_mamber = Block.find_by_user_id_and_group_id(params[:member_id], @group)
					if @blocked_mamber
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
				render :json => {:responseCode => 500,:responseMessage => 'Sorry you are not admin!'} 
			end
	end

  def unblock_user
		@blocked_user = Block.find_by_user_id_and_group_id(params[:member_id], params[:group_id])
		if @blocked_user
			@blocked_user.destroy
			render :json => {:responseCode => 200,:responseMessage => "Successfully done"}
	  else
	  	render :json => {:responseCode => 200,:responseMessage => "this user is not found in the blocked list"}
	  end
	end

	def search_user
		@group = Group.find_by_id(params[:group_id])
		@users = @group.users
		@all_users = User.search_user_to_add_group(params[:user_name])
		@blocked = Block.where('group_id = ?', @group.id ).pluck(:user_id)
		@block = User.where(id: @blocked)
		@search_result = @all_users - @users
		@final_result = @search_result - @block
		if @final_result.present?
		render :json => {
										:responseCode => 200,
										:responseMessage => "Successfully fetched users",
										:search_result => paging(@final_result , params[:page_no],params[:page_size]).as_json(only: [:id, :username, :picture, :email, :gender]),
										:pagination => { page_no: params[:page_no],max_page_no: @max,total_no_records: @total }
										}
		else
     render :json => {:responseCode => 500,:responseMessage => "Your search didn't match any users!",:search_result => [] }
		end								
	end

	# def add_user_to_group
	# 	@group = Group.find_by_id_and_admin_id(params[:group_id], @user)
	# 		if @group
	# 			if params[:members].present?
	# 				params[:members].as_json(only: [:id]).each do |t|
	# 					@user = User.find(t.values)
	# 					unless @group.users.include?(@user) 
	# 						@group.users << User.find(t.values)
	# 					end

 #             @user.first.devices.each {|device| (device.device_type == "Android") ? AndroidPushWorker.perform_async(nil, "Admin added you to #{@group.name} group" , nil, device.device_id, "message", nil, @group.id, nil) : ApplePushWorker.perform_async(nil, "Admin added you to #{@group.name} group", nil, device.device_id, "message", nil, @group.id, nil) } 

	# 				end
	# 				message = "User added successfully"
	# 			else
	# 				message = "No user added"
	# 			end
	# 		render :json => {
	# 										:responseCode => 200,
	# 										:responseMessage => message
	# 										}
	# 	else
	# 		render :json => {
	# 										:responseCode => 500,
	# 										:responseMessage => 'Something went wrong'
	# 										}
	# 	end	
	# end

	def add_user_to_group
		@group = Group.find_by_id_and_admin_id(params[:group_id], @user)
			if @group
				if params[:members].present?
					 params[:members].as_json(only: [:id]).each do |t|
						@users = User.find(t.values)
              @users.each do |user|
              	user.devices.each {|device| (device.device_type == "Android") ? AndroidPushWorker.perform_async(nil, "#{(User.find(@group.admin_id).username.present?) ? User.find(@group.admin_id).username : "Admin" }  has sent you an invite to chat." , nil, device.device_id, "adduser", nil, @group.id, nil) : ApplePushWorker.perform_async(nil, "#{(User.find(@group.admin_id).username.present?) ? User.find(@group.admin_id).username : "Admin" } has sent you an invite to chat.", nil, device.device_id, "adduser", nil, @group.id, nil) } 
					      Notice.create(:user_id => @user.id, :action_type => 'User_added', :reciever_id => user.id, :pending => true, :group_id => @group.id)
					    end 
					  end
			  		render :json => {
														:responseCode => 200,
														:responseMessage => "You are added to the #{@group.name} successfully!"
														}
			  else
					render :json => {:responseCode => 500,:responseMessage => "Please select users to add in this group!"}
				end	
	    end 	
	end

	def user_grp_detail
		 @group = Group.find_by_id(params[:group_id]) 
		 if @group.present?
		 	  @user = User.find_by_id(@group.admin_id)
		    render :json => {
													:responseCode => 200,
													:responseMessage => "Group user details fetched successfully!",
													:group_name => @group.name,
													:admin_details => @user.as_json(only: [:id, :username, :picture]),
													:admin_rating => Rating.calculate_ratings(@user)
													}
		 else
		  render :json => {:responseCode => 500,:responseMessage => "Group doesn't exists!"	}
		 end
	end
  
  def accept_decline_for_groups
  	  @group = Group.find_by_id(params[:group_id])
  	  if @group.present?
  	  		if params[:action_type] == 'Accept'
			  	     unless @group.users.include?(@user) 
								@group.users << User.find(@user.id)
							 end
							render :json => {:responseCode => 200,:responseMessage => 'You have successfully accepted the chat request!' } 
		  	  elsif params[:action_type] == 'Decline'
		  	  	@notice_decline = Notice.where(:user_id => @group.admin_id, :reciever_id => @user.id, :action_type => 'User_added', :invitation_id => nil, :book_to_give => nil).first
							@notice_decline.update_attributes(:action_type => 'User_declined')
							render :json => {:responseCode => 500,:responseMessage => 'Successfully declined the chat request!' } 
		  	  end
		  else
		  	  render :json => {:responseCode => 500,:responseMessage => "Group doesn't exists!"	}
      end 
  end

	def search_by_similar_reading_pref
		  similar_pref = ReadingPreference.search_similar_rp(params)
		  unless similar_pref.blank?
			   render :json => {
	                       :responseCode => 200,
	                       :responseMessage => 'Similar Reading Preferences Users fetched successfully!',
	                       :similar_reading_pref => {similar_pref: similar_pref.sort{|x|x[:other_user_detail][:distance]}}
	  	                  }
  	  else
  	  	 render :json => {:responseCode => 500,:responseMessage => "Don't have similar Reading Preferences Users!",:similar_reading_pref => [] }
  	  end                
	end

	def search_by_similar_books
		  similar_books = Book.search_similar_books(params) 
		  unless similar_books.blank?
		  render :json => {
                       :responseCode => 200,
                       :responseMessage => 'Similar Books Catalogued Users fetched successfully!',
                       :similar_books => {similar_book: similar_books.sort{|x|x[:other_user_detail][:distance]}}
  	                  }
  	  else
  	  	 render :json => {:responseCode => 500,:responseMessage => "Don't have similar Books Catalogued Users!",:similar_books => []	}
  	  end 
	end

	def group_is_delete
		@grp =  UserGroup.find_by(:user_id => @user.id, :group_id => params[:group_id])
	  if @grp 
	  	 @grp.update_attributes(:is_deleted => true)
	  	 render :json => {
                       :responseCode => 200,
                       :responseMessage => 'Chat has been deleted successfully!',
                       :is_deleted => @grp.is_deleted
  	                   }
	  else
	  	render :json => {:responseCode => 500,:responseMessage => 'Unable to delete the chat. Some device issue!',:is_deleted => @grp.is_deleted }
	  end	 
	end


	private

	def method_name
		params.permit!
	end
	
end
