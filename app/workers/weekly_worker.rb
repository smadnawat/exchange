require 'gcm'

class WeeklyWorker

  include Sidekiq::Worker
  sidekiq_options  :retry => false

    def perform
   	 	puts"====================Inside Weekly Worker======="	
      priority_first = 0
       @users = User.includes(:books, :reading_preferences).all 
         unless @users.blank?
    	        @users.each do |user|

    		        	other_users = User.includes(:books, :reading_preferences).all.reject{|u| u.id == user.id}
                    @user_preferences = user.reading_preferences
                       #@user_author_pref = user.author_prefernce
                         #@user_genre_pref = user.genre_preference
                            unless other_users.blank?
                                other_users.each do |other_user|
                                    unless other_user.books.blank? 
                                        other_user.books.each do |other_users_book| 
                                            unless user.books.blank?
                              					       	 user.books.each do |book|
                                                      
                                                      if user.books.present? && other_user.books.present? 

                                                          if other_user.reading_preferences.present?  && other_user.books.present?


                                                                if (other_user.reading_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:title).include?(book.title) && @user_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:title).include?(other_users_book.title))
                                                                        priority_first +=1  

                                                                elsif (other_user.reading_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:author).include?(book.author) && @user_preferences.map{|x| x if x.book_deactivated == false}.compact.map(&:author).include?(other_users_book.author)) 
                                                                        priority_first +=1      
                                                                
                                                                elsif (other_user.reading_preferences.map{|x| x if x.genre_deactivated == false}.compact.map(&:genre).include?(book.genre) && @user_preferences.map{|x| x if x.genre_deactivated == false}.compact.map(&:genre).include?(other_users_book.genre))        
                                                                        priority_first +=1


                                                                elsif ((['Education - School','Education - Undergrad - Art & Design','Education - Undergrad - Aeronautics','Education - Undergrad - Business Studies / Eco','Education - Undergrad - Drama', 'Education - Undergrad - Engineering', 'Education - Undergrad - Geography', 'Education - Undergrad - History', 'Education - Undergrad - Law', 'Education - Undergrad - Literature / English', 'Education - Undergrad - Maths', 'Education - Undergrad - Medicine', 'Education - Undergrad - Music', 'Education - Undergrad - Science', 'Education - Undergrad - Social Science', 'Education - Undergrad - Technology', 'Education - Undergrad - Others', 'Education - Postgrad - Business / Finance', 'Education - Postgrad - History', 'Education - Postgrad - Marketing', 'Education - Postgrad - Maths', 'Education - Postgrad - Medicine', 'Education - Postgrad - Technology', 'Education - Postgrad - Others'] & other_user.reading_preferences.map(&:genre)).include?(book.genre)) && (other_user.reading_preferences.map(&:isbn13).include?(book.isbn13)) 
                                                                #elsif ((['Computer Books and Technology Books','Engineering Books','Study Guides & Test Prep','Education & Training','Medical Books and Reference'] & other_user.reading_preferences.map(&:genre)).include?(book.genre)) && (other_user.reading_preferences.map(&:isbn13).include?(book.isbn13)) 
                                                                        priority_first +=1

                                                                elsif (other_user.reading_preferences.map{|x| x if x.by_scanning == true && x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false}.compact.map(&:author).include?(book.author) && @user_preferences.map{|x| x if x.by_scanning == true && x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false}.map(&:author).include?(other_users_book.author)) 
                                                                #elsif (other_user.books.map(&:author).include?(book.author) && user.books.map(&:author).include?(other_users_book.author))  
                                                                         priority_first +=1        

                                                                elsif (other_user.reading_preferences.map{|x| x if x.by_scanning == true && x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false}.compact.map(&:genre).include?(book.genre) && @user_preferences.map{|x| x if x.by_scanning == true && x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false}.map(&:genre).include?(other_users_book.genre))          
                                                                #elsif (other_user.books.map(&:genre).include?(book.genre) && user.books.map(&:genre).include?(other_users_book.genre))  
                                                                         priority_first +=1

                                                                end

                                                          end
                                                       else

                                                        p"============================IN ELSE##-----------------------------------------------------="
                                                          @user_preferences.each do |user_preference|
                                                              other_user.reading_preferences.each do |other_user_preference|
                                                                if ((other_user.reading_preferences.map{|x| x if x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false}.compact.reject {|x| x.author == ""}.map(&:author).include?(user_preference.author) && @user_preferences.map{|x| x if x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false}.compact.reject{|x| x.author == ""}.map(&:author).include?(other_user_preference.author)) &&(other_user.reading_preferences.map{|x| x if x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false}.compact.reject {|x| x.genre == ""}.map(&:genre).include?(user_preference.genre) && @user_preferences.map{|x| x if x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false}.compact.reject {|x| x.genre == ""}.map(&:genre).include?(other_user_preference.genre)))  
                                                                     priority_first +=1  

                                                                elsif (other_user.reading_preferences.map{|x| x if x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false}.compact.reject {|x| x.author == ""}.map(&:author).include?(user_preference.author) && @user_preferences.map{|x| x if x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false}.compact.reject{|x| x.author == ""}.map(&:author).include?(other_user_preference.author)) 
                                                                        priority_first +=1  

                                                                elsif (other_user.reading_preferences.map{|x| x if x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false}.compact.reject {|x| x.genre == ""}.map(&:genre).include?(user_preference.genre) && @user_preferences.map{|x| x if x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false}.compact.reject {|x| x.genre == ""}.map(&:genre).include?(other_user_preference.genre))
                                                                        priority_first +=1 
                                                                end
                                                              end
                                                          end
                                                      end   
                              					       	 end
                              			       	end
                                        end
                                      end 
                                    end       
                                end   
                             
             

            logger.info"=========================#{priority_first.inspect}=======================7777"

                  @user = User.find(user.id)
                   if @user.notification_status.eql? true
                        @devices =  @user.devices
                          unless @devices.nil?
                            @devices.each do |device|
                              if device.device_type == "Android"
                                puts "======#{device.device_id}========"
                                alert = "Your potential matches for this week is "
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


end
