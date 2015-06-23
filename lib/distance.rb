module CalculateDistance

  def paging(list,page_no,page_size)	# Pagination method For simple Array
    list = list.paginate(:page => page_no,:per_page => page_size)
    @max = list.total_pages
    @total = list.total_entries
    @per = list.per_page
    return list  
  end

	def pagination records, page_nos		# Pagination method For ActiveRecord Array
	  paging = Hash.new
	  paging[:page_no] = page_nos
 	 	paging[:max_page_no] = records.total_pages
	  paging[:total_no_records] = records.total_entries
	  return paging
  end
end