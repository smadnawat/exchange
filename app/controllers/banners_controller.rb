class BannersController < ApplicationController
	def destroy
		p"jdksjdkjskdjksjdkjskdjksjdksjd"
       banner = Banner.find(params[:id])
       if banner.destroy
         flash[:notice]= 'Banner has been deleted..'
         redirect_to :back
	   end
	end
end

 