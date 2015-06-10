ActiveAdmin.register User, as: "Blocked Users" do
 before_filter :skip_sidebar!
 actions :all, :except => [:new,:destroy,:show,:edit] 

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model

# or
permit_params :username, :picture, :gender, :email, :location, :date_signup#, :device_used
 menu priority: 3
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

index :title => 'Blocked User ' do
	selectable_column
  

	column :username do |f|
    f.username
  end
  column "Profile pic",:picture do |f|
    # f.picture
      f.picture.present? ? image_tag(f.picture.url(:thumb)) : img(src:'/assets/no_image.jpg', :width=> 150, :height=> 100);
    
  end
  
  # column :age do |f|
  #   #f.age
  # end
  column :gender do |f|
    f.gender
  end
  
  column :location do |f|
    f.location
  end
  
  

 column "Action" do |f|
     link_to "Unblock",  block_path(f,:unblock => "unblock"), class: "member_link",:data => { :confirm => "Are you sure, you want to Unblock this user?" }
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
        User.blocked
      end
    end
end
