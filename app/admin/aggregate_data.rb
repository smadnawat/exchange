ActiveAdmin.register User, as: "Aggregate Data" do
  before_filter :skip_sidebar!
  actions :all, :except => [:new,:destroy,:show,:edit] 
  menu priority: 2,label: "Aggregate Data"

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
# permit_params :username, :picture, :gender, :email, :location, :date_signup,:is_block#, :device_used
# or
#
 
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

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
	# column :profile_pic
	# column :gender
	# column :email
	# column :location
	# column :date_of_sign_up
	# column :device_used
	# column "Action",:is_block 
  # column :book_title
  # column :genre_name
  # column :author_name

    
 
  # form do |f|
  #   f.inputs "Admin Details" do
  #     f.input :name
  #     f.input :profile_pic
  #     f.input :gender
  #     f.input :email
  #     f.input :location
  #     f.input :date_of_sign_up
  #     f.input :device_used
  #     f.input :is_block 
      
  #   end
  # end
  # controller do
  #    scoped_collection do 
  #      User.all.where(:is_block => nil)
  #    end
  # end
  controller do
      def scoped_collection
        p"=========scope collection==============="
        User.users
      end
    end
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
