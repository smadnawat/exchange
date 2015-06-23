module ApplicationHelper
	 def average_rating_from_approved_end_client(send,accepted)
	 	# p "+++++++++#{send.inspect}+++#{accepted.inspect}++++++++++++++++++++++"
          
              if send > 0 && acepted > 0
              	@result = send/accepted 
              else
              	@result = 0
		  end
          
    end
end
