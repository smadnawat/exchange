ActiveAdmin.register Banner do
before_filter :skip_sidebar!
actions :all, :except => [:show,:destroy,:edit] 
menu priority: 5,  label: "Manage Ad Banner"

 
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
    
permit_params :banner_name, :author_name, :link, :image,:clicks

#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

index :title => 'Ad Banner' do
	selectable_column
	column "Ad Banner Name",:banner_name do |f|
      f.banner_name
  end
	column "Banner Image",:image do |f|
     image_tag(f.image.url(:thumb))
    #(image_tag(f.image.url(:thumb), :height => '100')
  end
  column "Link",:link do |f|
     f.link
  end
  column "Name Of the Author",:author_name do |f|
      f.author_name
  end
  column "No. of Clicks",:clicks do |f|
      f.clicks
  end
	
  column "Actions" do |f|
     link_to "Delete",  banner_path(f), method: :delete, class: "member_link",:data => { :confirm => "Are you sure, you want to Delete this banner?" }
  end
  
end


  form do |f|
    f.inputs "Ad Banner", :multipart => true do

       # f.inputs "" do
     
       #     f.content_tag(:span, image_tag(" ", id: 'my_image')).html_safe
         
       # end
     
    # f.input :image ,:as => :file,:hint => image_tag(f.object.image.url) #,:input_html => {:placeholder => "Upload Image"}
    # f.input :image ,:as => :file,:hint => f.content_tag(:span, image_tag("", id: 'my_image'))
    f.input :image ,:as => :file,:hint => f.content_tag(:span, image_tag("Please Upload Image ", id: 'my_image'))

    # f.input :image_cache, :as => :hidden 
    #   f.input :image, :as => :file, :hint => f.object.image.present? \
    # ? f.image_tag(f.object.image.url(:thumb))
    # : f.content_tag(:span, image_tag("Please Upload Image ", id: 'my_image'))



      f.input :image_cache, :as => :hidden 
      
      f.input :banner_name,:input_html => {:placeholder => "Name of Ad Banner"}
      f.input :author_name,:input_html => {:placeholder => "Name of Author"}
      f.input :link,:input_html => {:placeholder => "Link to the Landing Page"}
     
    end
   
     f.actions#,:input_html => {:value => "Save"}
  end

  # controller do
      
  #     def new
  #           p"new======================================"
  #           super
  #     end
  #   end
 
  
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
 