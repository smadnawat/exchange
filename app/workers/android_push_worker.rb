require 'gcm'
class AndroidPushWorker
	
  include Sidekiq::Worker
  def perform(parent,alert,message,invitation)
    @device = Device.where(:user_id => parent)
    gcm = GCM.new("AIzaSyA1KAy9NhC66EXcXErDwF4rSh5lafdoCi4")
    registration_ids = ["#{@device.first.device_id}"]         
    options = {
          'data' => {
          'message'=>  message,
          'alert' => alert,
          'badge' => badges,
          'invitation_id' => invitation
         },
        "time_to_live" => 108,
        "delay_while_idle" => true,
        "collapse_key" => 'updated_state'
        }
    response = gcm.send_notification(registration_ids,options)
    puts "=============#{response}==============="
    Notification.where(:reciever => parent).first.update_attributes(:pending => true)
  end
end
