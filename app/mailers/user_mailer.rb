class UserMailer < ApplicationMailer
  
  def reset_password_mail(user)
    @user = user    
    mail(:to => @user.email, :subject => 'Password Reset Instructions')
  end	

  def sending_contact_details(user)
  	@user = user
  	mail(:to => "talktome@makasharcreative.com", :subject => 'Contact Us Form!')
  end

end
