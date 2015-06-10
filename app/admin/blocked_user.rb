ActiveAdmin.register User, as: "Blocked Users" do
 before_filter :skip_sidebar!
 actions :all, :except => [:new,:destroy,:show,:edit] 

permit_params :username, :picture, :gender, :email, :location, :date_signup#, :device_used
 menu priority: 3


index :title => 'Blocked User ' do
	selectable_column
  

	column :username do |f|
    f.username
  end
  column "Profile pic",:picture do |f|
    # f.picture
      f.picture.present? ? image_tag(f.picture.url(:thumb)) : img(src:'/assets/no_image.jpg', :width=> 150, :height=> 100);
    
  end
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
	
  controller do
      def scoped_collection
        User.blocked
      end
    end
end
