ActiveAdmin.register User do
before_filter :skip_sidebar!
 actions :all, :except => [:new,:destroy,:show,:edit] 
  menu priority: 1,label: "User Profiles and Data"

permit_params :username, :picture, :gender, :email, :location, :date_signup,:is_block#, :device_used

index :title => 'User Profiles and Data' do
	selectable_column
  
	column :username do |f|
      f.username
    end

    column :picture do |f|
      f.picture.present? ? image_tag(f.picture.url(:thumb)) : img(src:'http://res.cloudinary.com/abhicloud/image/upload/c_scale,h_100,w_150/v1434012609/no_image_obxfvr.jpg');
      # image_tag(f.picture.url(:thumb)) if f.picture.present?http://res.cloudinary.com/abhicloud/image/upload/v1434012609/no_image_obxfvr.jpg

    end

    column :gender do |f|
      f.gender
    end

    column :email do |f|
      f.email
    end

    column :location do |f|
      f.location
    end

    column :date_signup do |f|
      f.date_signup.to_date
    end
  
  column "Author Preference",:title  do |f|
     f.reading_preferences.present? ? f.reading_preferences.map{|p| p.title}.join(' , ') : 'no Reading Preferences'
      
    #   p.book_title
     end
  
  column "Gener Preference",:genre  do |f|
   
     f.reading_preferences.present? ? f.reading_preferences.map{|p| p.genre}.join(' , ') : 'no Reading Preferences'
# condition ? if_true : if_false
      # p.genre_name
    end


  column "No. of Books Uploaded"  do |f|
     f.books.count if f.books.present? ? f.books.count : 0
  end

  column :device_used  do |f|
    #f.device_type
  end

  column "Number of Books Exchange Initiated"  do |f|
    
  end

  column "No. of Chat Invites Initiated"  do |f|
    
  end

  column "No. of Book Exchange Invites Accepted"  do |f|
    
  end

  column "No. of Chat Invites Accepted"  do |f|
    
  end

  column "No. of Matches for Books"  do |f|
    
  end

  column "No. of Matches for Author"  do |f|
    
  end

  column "No. of Matches for Genere"  do |f|
    
  end

  column "No. of Matches (Less than 5 kms)"  do |f|
    
  end

  column "Action" do |f|
     link_to "Block",  block_path(f), class: "member_link",:data => { :confirm => "Are you sure, you want to block this user?" }
  end
   
end
	
  controller do
      def scoped_collection
        p"=========scope collection==============="
        User.users
      end
    end

end
