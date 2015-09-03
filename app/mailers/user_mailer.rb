class UserMailer < ApplicationMailer
  default from: '"Novelinked" <talktome@makasharcreative.com>'

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
  	mail(:to => @user.email, :subject => "Welcome to Novelinked, Where Old Books Meet New Friends.")
  end

  def news_letter user
    @user = user
    mail(:to => @user.email, :subject => "Newsletter for the month of #{Date.current.strftime("%B  %Y")} .")
  end

  def send_potential_match user,match
    @matches = match
    @user = user
    # mail(:to => @user.email, :subject => "Potential Match.")
    mail(:to => "ashish.mittal@mobiloitte.com", :subject => "Potential Match.")
  end

end
