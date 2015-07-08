require 'gcm'
class AndroidPushWorker
	
  include Sidekiq::Worker

  def perform(reciever,alert,badges,device_id,type,invitation)
  logger.info"===================#{reciever.inspect}===#{alert.inspect}==========#{badges.inspect}==============#{device_id.inspect}==========#{type.inspect}============#{invitation.inspect}"
     p"==============#{device_id}=================IN ANDROID WORKER"
    gcm = GCM.new("AIzaSyA1KAy9NhC66EXcXErDwF4rSh5lafdoCi4")
    registration_ids = ["#{device_id}"]         
    options = {
          'data' => {
            'message' => ['badge'=>  badges,'alert' => alert,'invitation_id' => invitation]
          },
        "time_to_live" => 108,
        "delay_while_idle" => true,
        "collapse_key" => 'updated_state'
        }
    response = gcm.send_notification(registration_ids,options)
    puts "=============Done======#{response.inspect}======== ANDROID WORKER"
  end
end


