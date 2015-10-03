class MonthlyEmailWorker
	
  include Sidekiq::Worker

  def perform
    User.where(is_subscribe: true, :sign_in_token => nil).each do |user|
    	p "====================#{user.email}"
      UserMailer.news_letter(user.generate_token).deliver 
    end
  end
end


