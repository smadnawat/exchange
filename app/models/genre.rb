class Genre < ActiveRecord::Base
   self.table_name = "sub_subject"

   def self.search(search)
	    if search.blank?  # blank? covers both nil and empty string
	      all
	    else
	      where('title LIKE ?', "#{search}%").select(:title).distinct
	    end
	 end

end
