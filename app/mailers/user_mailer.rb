require 'sendgrid-ruby'
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
    url = "http://www.novelinked.com/receive_news_letter/#{@user.mat_email_token}"
    unsubscribe_url = "http://www.novelinked.com/unsubscribe/#{@user.unsubscription_token}"
    client = SendGrid::Client.new(api_user: 'MakasharCreative', api_key: 'Mypromovideo1234')
    mail = SendGrid::Mail.new
    mail.from = "<talktome@makasharcreative.com>"
    mail.from_name = "Novelinked"
    mail.to = @user.email
    header = Smtpapi::Header.new
    header.add_substitution('User', ["#{user.username}"])        # sub = {keep: ['secret']}
    header.add_substitution('Link', ["#{url}"])        # sub = {keep: ['secret']}
    header.add_substitution('UnsubscribeLink', ["#{unsubscribe_url}"])        # sub = {keep: ['secret']}
    header.add_to([@user.email])
    header.add_category("Newsletter")
    header.add_filter('templates', 'enable', 1)    # necessary for each time the template engine is used
    header.add_filter('templates', 'template_id', '11b36119-dc3c-4bb6-91cc-43c91e507428')
    header.to_json
    mail.smtpapi = header
    mail.html = header
    mail.subject = "List of Free Books & News Letter – #{Date.current.strftime('%B  %Y')} ."
    ccc = client.send(mail)
    p "==================#{ccc.body}"
  
    #mail(:to => @user.email, :subject => "Newsletter for the month of #{Date.current.strftime("%B  %Y")} .")
  end

  def send_potential_match user,match
    @matches = match
    @user = user
    mail(:to => @user.email, :subject => "Your List of Free Books. Where Old Books Meet New Friends – You’re Book Matches from Novelinked.com….")
  end


end

