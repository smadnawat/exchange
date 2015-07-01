class Document < ActiveRecord::Base
    self.table_name = "book"

  def self.search(search)
	    if search.blank?  # blank? covers both nil and empty string
	      scoped
	    else
	      where('subjects LIKE ?', "#{search}%").select(:subjects, :isbn13).distinct
	    end
	end

	def self.search_title(search)
		if search.blank?    # blank? covers both nil and empty string
		   scoped
		else
		   where('title LIKE ?', "#{search}%").select(:title, :isbn13, :isbn10, :author, :subjects, :overview).distinct   
		end
	end

	def self.search_author(search)
		if search.blank?    # blank? covers both nil and empty string
		   scoped	
		else
		   where('author LIKE ?', "#{search}%").select(:author, :isbn13).distinct   
		end
	end

	def self.searching_many(search)
		if search.blank?    # blank? covers both nil and empty string
		   scoped	
		else
			where('author LIKE :term OR title LIKE :term OR subjects LIKE :term OR isbn13 LIKE :term', :term => "#{search}%")  
		end
	end

	# def remove_html_tags
 #      re = /<("[^"]*"|'[^']*'|[^'">])*>/
 #      self.synopsis.gsub!(re, '')
 #      #self.description.gsub!(re, '')
 #  end

end


