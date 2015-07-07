require 'gcm'

class WeeklyWorker

  include Sidekiq::Worker

   def perform
   	 	puts"====================Inside Weekly Worker======="	

     @users = User.includes(:books, :reading_preferences).where(:weekly_date => Date.current)  
     p"=================#{@users.inspect}=======Users"
     
     if @users.present?
	        @users.each do |user|
		        	if user.books.present?
					       	 user.books.each do |book|
					       	 end
			       	end
	        end
     end

   end

end