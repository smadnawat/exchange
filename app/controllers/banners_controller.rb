class BannersController < ApplicationController
	def destroy
       banner = Banner.find(params[:id])
       if banner.destroy
         flash[:notice]= 'Banner has been deleted..'
         redirect_to :back
	   end
	end
end

 

