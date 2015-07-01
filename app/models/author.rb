class Author < ActiveRecord::Base
	self.table_name = "author"

	 def self.search(search)
	    if search.blank?  # blank? covers both nil and empty string
	      all
	    else
	      where('title LIKE ?', "#{search}%").select(:title).distinct
	    end
	 end

end

