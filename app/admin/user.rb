ActiveAdmin.register User do
before_filter :skip_sidebar!
 actions :all, :except => [:new,:destroy,:show,:edit] 
  menu priority: 1,label: "User Profiles and Data"

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
permit_params :username, :picture, :gender, :email, :location, :date_signup,:is_block#, :device_used
# or
#
 
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

index :title => 'User Profiles and Data' do
	selectable_column
  
	column :username do |f|
      f.username
    end

    column :picture do |f|
      f.picture.present? ? image_tag(f.picture.url(:thumb)) : img(src:'/assets/no_image.jpg', :width=> 150, :height=> 100);
      # image_tag(f.picture.url(:thumb)) if f.picture.present?

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
    # f.preferencces.title if f.preferencces.present?
     
      # f.reading_preferences.map{|p| p.title}.join(' , ') if f.reading_preferences.present?
     f.reading_preferences.present? ? f.reading_preferences.map{|p| p.title}.join(' , ') : 'no Reading Preferences'
      
    #   p.book_title
     end
  
  column "Genre Preference",:genre  do |f|
    # f.preferencces.book_title if f.preferencces.present?
     # f.preferencces.last.genre_name if f.preferencces.present?
     # f.reading_preferences.map{|p| p.genre}.join(' , ') if f.reading_preferences.present? 
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

  column "No. of Matches (Less then 5 kms)"  do |f|
    
  end

  column "Action" do |f|
     link_to "Block",  block_path(f), class: "member_link",:data => { :confirm => "Are you sure, you want to block this user?" }
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
