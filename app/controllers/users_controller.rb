class UsersController < ApplicationController
	def block
      if params[:unblock]
          user = User.find(params[:id]).update_attributes(is_block: false)
      else
   	      user = User.find(params[:id]).update_attributes(is_block: true)
   	  end
       redirect_to :back
	end
end
