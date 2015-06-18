class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :reciever,  :class_name => 'User', :foreign_key => 'recieve_id'
  belongs_to :book
  attr_accessor :message



	def self.create_notification(user,reciever,type,book_id,invitation)
	        user.notifications.create(:action_type => type,:reciever_id => reciever,:pending=> true,:book_id => book_id,:invitation_id => invitation.id)
	        @alert = alert(user,type)
	        send_push_notification(user,reciever,@alert,type,invitation_id)
	end

	
	def self.send_push_notification(sender,reciever,alert,type,invitation_id)
	        @badges = Notification.where(:reciever_id => reciever, :pending => true).count
	        @devices =  User.find(reciever).devices
	        unless @devices.nil?
		        @devices.each do |device|
			        if device.device_type == "Android"
			          AndroidPushWorker.perform_async(reciever, @alert,@badges,invitation_id)
			        else
			          ApplePushWorker.perform_async(reciever, @alert,@badges,device.device_token,type,invitation_id)
			        end
			    end
	        end
    end

      def self.alert(sender,type)
      	case(type)
	      	when "Exchange"
	      		return "#{sender.username} sned an invitation to you"
	      	when "Chat"
	      		return "#{sender.username} sned an invitation to you"
	      	when "Accept"
	      		return "Your chat request has been accepted.Tap here to initiate"
	      	when "Decline"
	      		return "Your exchange request has been declined"
	    end
      end


end
