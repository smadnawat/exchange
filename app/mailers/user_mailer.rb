class UserMailer < ApplicationMailer
  default from: '"Exchange-App" <talktome@makasharcreative.com>'

  def reset_password_mail(user)
    @user = user    
    mail(:to => @user.email, :subject => 'Password Reset Instructions')
  end	

  def sending_contact_details(user)
  	@user = user
  	mail(:to => "talktome@makasharcreative.com", :subject => 'Contact Us Form!')
  	#mail(:to => "rahul.pakhre@mobiloittegroup.com", :subject => 'Contact Us Form!')
  end

  def registration_confirmation(user, login_url)
  	@login_url = login_url
  	@user = user
  	mail(:to => @user.email, :subject => "Welcome to ExchangeApp")
  end

end
