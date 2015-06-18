class UserMailer < ApplicationMailer
  
  def reset_password_mail(user)
    @user = user    
    @user.update_attributes(:reset_password_sent_at => Time.now)
    p"------------------------====================#{@user.errors.full_messages}===================-------------------mailer"

    mail(:to => user.email, :subject => 'Password Reset Instructions', :from => "ExchangeApp")
  end	

end
