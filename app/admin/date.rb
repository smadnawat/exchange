
ActiveAdmin.register_page "Aggregate Data" do
 menu priority: 2

#####################################start here #########################################################
    content do
  	  div :id => "active_admin_content", :class=> "without_sidebar" do
  		div :class => "index_cotent" do
  	     div :class => "index_as_table_category" do	
	         table :id => "index_table_users", :class => 'index_table index', :cellspacing => "0", :cellpadding => "0", :border => "0", :paginator => "true"  do

	  	         tr do
	              th {"Date"}
	              th {"Total Chats accessed in Past 7 days"}
	              th {"Total Books Uploaded"}
	              th {"Total Matches Possible in Less then 5 km radius"}
	              th {"Total Invites Send"}
	              th {"Total Invites Accepted"}
	              th {"Percentage of Invites Accepted"}

	  	         end
	  	        @collection = Kaminari.paginate_array(Book.details).page(params[:page]).per(1)
	  	        @collection.each do |book|
                books = Book.where(:upload_date => book.upload_date).group('address').count

	                  tr do
	                  	send = Invitation.pluck(:created_at).map{|x| x.to_date.eql? book.upload_date_for_admin}.reject{|x| x.eql? false}.count
	         			accept  =   Invitation.pluck(:created_at).map{|x| x.to_date.eql? book.upload_date_for_admin and Invitation.find_by_created_at(x).status == "Decline"}.reject{|x| x.eql? false}.count       	
	                     td {book.upload_date_for_admin} 
	                     td {Message.where('created_at > ? ', book.upload_date_for_admin - 7.days).map{|m|  m.sender_id }.uniq.count} 
                        
	                     td {book_count(books)} 
	                     td { } 
	                     td { Invitation.pluck(:created_at).map{|x| x.to_date.eql? book.upload_date_for_admin}.reject{|x| x.eql? false}.count} 
	                     td {Invitation.pluck(:created_at).map{|x| x.to_date.eql? book.upload_date_for_admin and Invitation.find_by_created_at(x).status == "Decline"}.reject{|x| x.eql? false}.count} 
	                     # td {book.upload_date} 
	                     td{ average_rating(send ,accept )}
	                    
	                  end

	               end

	           end #table
              paginated_collection(Kaminari.paginate_array(Book.details).page(params[:page]).per(1)).each do
             end
               
           end
        end
     end
 end
#############################ends here#######################################################



end



