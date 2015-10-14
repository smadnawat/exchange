require 'gcm'

class WeeklyWorker

  include Sidekiq::Worker
  sidekiq_options  :retry => false

  def perform
    puts"====================Inside Weekly Worker=======" 
    User.all.each do |user|
      hash = {user_id: user.id,is_week_news: true}
      priority_first = User.get_near_matches(hash)
      if user.notification_status.eql? true
        @devices =  user.devices
        unless @devices.nil?
          @devices.each do |device|
            if device.device_type == "Android"
              puts "======#{device.device_id}========"
              alert = "Novelinked has #{priority_first} matches waiting for you"
              AndroidPushWorker.perform_async(user.id, alert, priority_first, device.device_id, nil, nil, nil, nil)
            else
              ApplePushWorker.perform_async(user.id, alert, priority_first, device.device_id, nil, nil, nil, nil)
            end
          end
        end
      end  
    end
  end 
end


