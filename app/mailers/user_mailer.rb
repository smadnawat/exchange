class UserMailer < ApplicationMailer
  
  def reset_password_mail(user)
    @user = user    
    mail(:to => @user.email, :subject => 'Password Reset Instructions')
  end	

end
