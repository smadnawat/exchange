ActiveAdmin.register User, as: "Aggregate Data" do
  before_filter :skip_sidebar!
  actions :all, :except => [:new,:destroy,:show,:edit] 
  menu priority: 2,label: "Aggregate Data"

 index do
	selectable_column
  
	column "dates" do |f|
      # f.username
    end

    

    column "Total Chats accessed in Past 7 days" do |f|
      # f.gender
    end

    column "Total Books Uploaded" do |f|
        Book.all.find_by_created_at( Date.today).present? ? Book.all.find_by_created_at( Date.today) : 'No Books Uploaded'
       
    end

    column "Total Matches Possible in Less then 5 km radius" do |f|
      # f.location
    end

    
  
  column "Total Invites Send"  do |f|
    #f.device_used
  end
  
  
  column "Total Invites Accepted"  do |f|
   
  end
  
  column "Percentage of Invites Accepted"  do |f|
    
  end

  
end
	
  controller do
      def scoped_collection
       
        User.users
      end
    end

end
