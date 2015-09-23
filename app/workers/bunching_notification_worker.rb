require 'gcm'

class BunchingNotificationWorker

  include Sidekiq::Worker
  sidekiq_options  :retry => false

  def perform
    puts"====================Inside Bunching Notification Worker=======" 
    
    @messages = Message.where(:is_send => false)
    groups = Group.where(id: @messages.pluck(:group_id)).includes(:users)
     logger.info"---------------------------#{groups.inspect}====---------------------"
      groups.each do |gr|
        users = gr.users.where(id: gr.user_groups.where('is_deleted is null or is_deleted =?',false).pluck(:user_id))
          users.each do |user|

            break if Block.find_by_user_id_and_group_id(user.id, gr.id).present?
              #msg = gr.messages.where(:is_send => false)
              msg  = @messages.select{|m|(m[:sender_id]!=user.id and m[:group_id] == gr.id)}
              logger.info"==============================#{msg.inspect}-----------------------msg array"
              user.devices.each {|device| (device.device_type == "Android") ? AndroidPushWorker.perform_async(nil, "You have #{msg.count} unread messages in #{gr.name} ", nil, device.device_id, "message", nil, gr.id, nil) : ApplePushWorker.perform_async(nil, "You have #{msg.count} unread messages in #{gr.name} ", nil, device.device_id, "message", nil, gr.id, nil) }  if (msg.count > 0) #if ((@messages.pluck(:sender_id).uniq.count > 1) and (@messages.first.sender_id.eql?(user.id)))
              gr.messages.update_all(:is_send => true)
          end
      end
  end 

end
