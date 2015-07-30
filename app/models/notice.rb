class Notice < ActiveRecord::Base
  belongs_to :user
  belongs_to :reciever,  :class_name => 'User', :foreign_key => 'recieve_id'
  attr_accessor :message

	def self.create_Notice(user,reciever,type,book_id,invitation,group_id,data)
        user.notices.create(:action_type => type,:reciever_id => reciever,:pending=> true,:book_to_give => book_id,:invitation_id => invitation.id)
        @alert = alert(user,type)
        logger.info"====================#{@alert.inspect}-----------------------------"
        send_push_Notice(user,reciever,@alert,type,invitation.id,group_id,data)
	end

	def self.send_push_Notice(sender,reciever,alert,type,invitation_id,group_id,data)
        @badges = Notice.where(:reciever_id => reciever, :pending => true).count
        @reciever_user = User.find(reciever)
        if @reciever_user.notification_status.eql? true
	        @devices =  User.find(reciever).devices
	        unless @devices.nil?
		        @devices.each do |device|
			        if device.device_type == "Android"
			        	puts "======#{device.device_id}========"
			          AndroidPushWorker.perform_async(reciever, alert,@badges,device.device_id,type,invitation_id,group_id,data) 
			        else
			          ApplePushWorker.perform_async(reciever, alert,@badges,device.device_id,type,invitation_id,group_id,data) 
			    end
	        end
        end
      end
  end

  def self.alert(sender,type)
      case(type)
      	when "exchange"
      		return "#{sender.username} send an invitation to you"
      	when "start chat"
      		return "#{sender.username} send an invitation to you"
      	when "Accept"
      		return "Your chat request has been accepted.Tap here to initiate"
      	when "Decline"
      		return "Your exchange request has been declined"
	    end
  end


	
end
