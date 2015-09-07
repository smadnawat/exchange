require 'gcm'

class WeeklyWorker

  include Sidekiq::Worker
  sidekiq_options  :retry => false
  
  # def perform
  #     puts"====================Inside Weekly Worker=======" 
  #     User.all.each do |user|
  #       hash = {user_id: user.id,is_week_news: true}
  #       User.get_near_matches(hash)
  #     end     
  # end 
 


end


