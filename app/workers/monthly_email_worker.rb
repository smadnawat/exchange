class MonthlyEmailWorker
	
  include Sidekiq::Worker

  def perform
    User.all.each do |user|
      UserMailer.news_letter(user.generate_token).deliver if user.email=="ashish.mittal@mobiloitte.com"
    end
  end
end


