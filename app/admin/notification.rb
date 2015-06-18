ActiveAdmin.register_page "Notification" do
# before_filter :skip_sidebar!
# actions :all, :except => [:show,:destroy,:edit] 
menu priority: 4,  label: "Notifications"#, :url => proc{  render  partial: 'admin/notifications/form' }
# permit_params :subject,:content, :genre, :author, :location,:all
		content do
		    render :partial => 'form'
		end
      
end




  # controller do
  #    define_method(:index) do
  #     render partial: 'form'
  #    end
  #  end
  #  content title: Proc.new {
  #   if @page_title.present? # In other words, we check whether the <title> tag was already rendered
  #     link_to image_tag('some_logo.png'), 'http://someurl.com/', target: '_blank'
  #   else
  #     @page_title = 'CustomPage' # @page_title is just a custom-named instance variable, it could be anything
  #   end
  # } 