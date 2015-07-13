module ApplicationHelper

	 def average_rating(send,accepted)
      if send > 0 && accepted > 0
        @result =  ((accepted*100)/send).round
      else
         @result = 0
		  end
    end

    def book_count(book)
    	$arr = []
        book.each do |key , value|
        	$arr << "#{key.split(',').last}" "-" "#{value}"
        	p"#{value.inspect}====================="
        end
       return $arr.flatten.join(',')  
    end    

   def options_for_country_select
      [ "India", "Singapore", "USA", "Japan", "Others" ]
   end

end
