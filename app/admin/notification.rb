ActiveAdmin.register Notification do
before_filter :skip_sidebar!
actions :all, :except => [:show,:destroy,:edit] 
menu priority: 4,  label: "Notifications"
permit_params :subject,:content, :genre, :author, :location,:all
    form partial: 'form'
      
      # controller do
      #    def popup
      #    	p"jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj"
      #      rescue ActiveRecord::RecordNotFound
      # flash[:notice] = "Wrong post it"
      #   redirect_to :action => 'create'
      #    end
      # end

    end




 