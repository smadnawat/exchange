class Notice < ActiveRecord::Base
  belongs_to :user
  belongs_to :reciever,  :class_name => 'User', :foreign_key => 'recieve_id'
  belongs_to :book
  attr_accessor :message

	def self.create_Notice(user,reciever,type,book_id,invitation)
		p"================inside notice=============="
	        user.notices.create(:action_type => type,:reciever_id => reciever,:pending=> true,:book_id => book_id,:invitation_id => invitation.id)
	        @alert = alert(user,type)
	        send_push_Notice(user,reciever,@alert,type,invitation.id)
	end

	def self.send_push_Notice(sender,reciever,alert,type,invitation_id)
        @badges = Notice.where(:reciever_id => reciever, :pending => true).count
        @devices =  User.find(reciever).devices
        unless @devices.nil?
	        @devices.each do |device|
		        if device.device_type == "Android"
		          AndroidPushWorker.perform_async(reciever, @alert,@badges,invitation_id)
		        else
		          ApplePushWorker.perform_async(reciever, @alert,@badges,device.device_id,type,invitation_id)
		        end
		    end
        end
  end

  def self.alert(sender,type)
      case(type)
	      	when "Exchange"
	      		return "#{sender.username} send an invitation to you"
	      	when "Chat"
	      		return "#{sender.username} send an invitation to you"
	      	when "Accept"
	      		return "Your chat request has been accepted.Tap here to initiate"
	      	when "Decline"
	      		return "Your exchange request has been declined"
	    end
  end


	
end
