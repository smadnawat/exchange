require 'gcm'

class WeeklyWorker

  include Sidekiq::Worker

    def perform
   	 	puts"====================Inside Weekly Worker======="	
      priority_first =0
       @users = User.includes(:books, :reading_preferences).all 
         unless @users.blank?
    	        @users.each do |user|

    		        	other_users = User.includes(:books, :reading_preferences).all.reject{|u| u.id == user.id}
                    @user_preferences = user.reading_preferences
                       @user_author_pref = user.author_prefernce
                         @user_genre_pref = user.genre_preference
                            unless other_users.blank?
                                other_users.each do |other_user|
                                    unless other_user.books.blank?
                                        other_user.books.each do |other_users_book| 
                                            unless user.books.blank?
                              					       	 user.books.each do |book|

                                                    if (other_user.reading_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:title).include?(book.title) && @user_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:title).include?(other_users_book.title))
                                                            priority_first +=1  
                                                    elsif (other_user.reading_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:author).include?(book.author) && @user_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:author).include?(other_users_book.author)) 
                                                            priority_first +=1                                                    
                                                    elsif (other_user.reading_preferences.map{|x| x if x.genre_deactivated == false}.compact.map(&:genre).include?(book.genre) && @user_preferences.map{|x| x if x.genre_deactivated == false}.compact.map(&:genre).include?(other_users_book.genre))        
                                                            priority_first +=1
                                                    elsif ((['Computer Books and Technology Books','Engineering Books','Study Guides & Test Prep','Education & Training','Medical Books and Reference'] & other_user.reading_preferences.map(&:genre)).include?(book.genre)) && (other_user.reading_preferences.map(&:isbn13).include?(book.isbn13)) 
                                                            priority_first +=1
                                                    elsif (other_user.books.map(&:author).include?(book.author) && @books.map(&:author).include?(other_users_book.author)) 
                                                             priority_first +=1               
                                                    elsif (other_user.books.map(&:genre).include?(book.genre) && @books.map(&:genre).include?(other_users_book.genre))  
                                                             priority_first +=1
                                                    end

                              					       	 end
                              			       	end
                                        end
                                    end       
                                end   
                            end 
    logger.info"=========================#{priority_first.inspect}======================="

            @devices = User.find(user.id).devices
      	      unless @devices.nil?
                @devices.each do |device|
                  if device.device_type == "Android"
                    puts "======#{device.device_id}========"
                    AndroidPushWorker.perform_async(user.id, alert, priority_first, device.device_id, type, invitation_id)
                  else
                    ApplePushWorker.perform_async(user.id, alert, priority_first, device.device_id, type, invitation_id)
                  end
                end
              end    
                 

              end
         end
    end


end
