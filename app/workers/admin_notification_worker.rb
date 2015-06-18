
require 'gcm'
class AdminPushWorker
 
 include Sidekiq::Worker
  # sidekiq_options  :retry => false
   def perform(device_id,device_type,subject,content ) 
      puts "=====#{device_id}======#{subject}====#{content}===#{device_type}===" 
      if ( device_type == 'Ios')
         puts"=====================INSIDE Apple WORKER======="

          pusher = Grocer.pusher(
          certificate: Rails.root.join('PeeqSeeDevelopment.pem'),      # required
          passphrase:  "PeeqSee",                       # optional
          gateway:     "gateway.sandbox.push.apple.com", # optional; See note below.
          port:        2195,                     # optional
          retries:     3                         # optional
           )

         notification = Grocer::Notification.new(
         device_token:      device_id,
         alert:             subject ,  
         custom: {:NT => content},

         # badge:             42,
         sound:             "siren.aiff",         # optional
         expiry:            Time.now + 60*60,     # optional; 0 is default, meaning the message is not stored
         identifier:        1234,                 # optional
         content_available: true                  # optional; any truthy value will set 'content-available' to 1
         )

         pusher.push(notification)
      elsif ( device_type == 'Android')  
        puts"=====================INSIDE ANDROID WORKER======="
        gcm = GCM.new("AIzaSyBxpBq36vt59IElzWetgEL5Xcq0Cwq1iSQ")
        registration_ids= ["#{device_id}"]    
        options = {
          'data' => {
            'message' =>['alert' => subject,'NT' => content]
          },
          "time_to_live" => 108,
          "delay_while_idle" => true,
          "collapse_key" => 'updated_state'
        }

              response = gcm.send_notification(registration_ids,options)
              puts"=============#{response}========RESPONSE======="

      end
      
 end
end