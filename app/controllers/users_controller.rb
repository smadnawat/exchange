class UsersController < ApplicationController
	def block
       if params[:unblock]
          user = User.find(params[:id]).update_attributes(is_block: false)
       else
       	p"ioioioioioioi=================="
   	      user = User.find(params[:id]).update_attributes(is_block: true)
   	      p"--after block======================"
   	   end
       redirect_to :back
	end
end
