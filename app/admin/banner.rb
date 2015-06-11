ActiveAdmin.register Banner do
before_filter :skip_sidebar!
actions :all, :except => [:show,:destroy,:edit] 
menu priority: 5,  label: "Manage Ad Banner"
permit_params :banner_name, :author_name, :link, :image,:clicks


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

      
    f.input :image ,:as => :file,:hint => f.content_tag(:span, image_tag("", id: 'my_image')) 

      f.input :image_cache, :as => :hidden 
      f.input :banner_name,:input_html => {:placeholder => "Name of Ad Banner"}
      f.input :author_name,:input_html => {:placeholder => "Name of Author"}
      f.input :link,:input_html => {:placeholder => "http://www.mobiloitte.com"}
     
    end
   
     f.actions
  end


   controller do        
    def new
      super
    end  

    def create
       super
      flash[:notice] = 'Banner is successfully created'      
    end
  end

end
 