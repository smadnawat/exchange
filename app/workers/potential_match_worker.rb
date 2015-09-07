class PotentialMatchWorker
	
  include Sidekiq::Worker
  sidekiq_options  :retry => false

  def perform user_id
  	p "=======================================+#{user_id}"
 	User.user_potential_match_for_news_letter(user_id)
  end
end

# def self.user_potential_match_for_new_letter(user)  #fetch user potential match for monthly newsletter
#     hash = Hash.new
#     priority_first =Set.new 
#     priority_second = Set.new
#     priority_third = Set.new
#     priority_forth = Set.new
#     priority_fifth = Set.new
   
#     @user = user
#     @lat_long = @user.books.last
#     @books = @user.books#.near([@lat_long.latitude,@lat_long.longitude], 10, :units => :km)

#     @user_preferences = @user.reading_preferences
#     other_users = (User.includes(:books,:reading_preferences,:ratings).near([@lat_long.latitude,@lat_long.longitude], 10, :units => :km).reject{|u| u.id == @user.id})
    
#     my_flag = 0


#     ####### Priority First ##################
#     other_users.each  do |other_user|
#       book_title = other_user.books.select{|x|@user_preferences.select{|x|(x.by_scanning == false && x.book_deactivated == false && x.title!="")}.map(&:title).map{|x|x.split(' ')[0,5].join('').upcase}.include?(x["title"].split(' ')[0,5].join('').upcase)}
#       @books.each do |book|
#         book_title.each do |other_users_book_title|
#           priority_first << book.as_json(:only => [:id, :title,:author,:genre, :about_us, :image_path]).merge(distance: other_user.distance.round(2))
#         end if (other_user.reading_preferences.select{|x|(x.book_deactivated == false && x.title!="")}.map(&:title).map{|x|x.split(' ')[0,5].join('').upcase}.include?(book.title.split(' ')[0,5].join('').upcase) and book_title.present?)
#         (my_flag=1;break;) if priority_first.count>=5
#       end
#       Rails.logger.info "======Priority first ==========#{priority_first.count}======================="
#       break if my_flag==1
#     end if @books.present?

#     ####### Priority Second ##################
#     other_users.each  do |other_user|
#       book_author = other_user.books.select{|x|@user_preferences.select{|x|(x.by_scanning == false && x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false && x.author!="")}.map(&:author).map{|x|x.split(' ')[0,5].join('').upcase}.include?(x["author"].split(' ')[0,5].join('').upcase)}
#       @books.each do |book|
#         book_author.each do |other_users_book_author|
#           priority_second << book.as_json(:only => [:id, :title,:author,:genre, :about_us, :image_path]).merge(distance: other_user.distance.round(2))
#         end if (other_user.reading_preferences.select{|x|(x.by_scanning == false && x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false && x.author!="")}.map(&:author).map{|x|x.split(' ')[0,5].join('').upcase}.include?(book.author.split(' ')[0,5].join('').upcase) and book_author.present?)
#         (my_flag=1;break;) if ((priority_first + priority_second).to_set.count >=5)
#       end
#       Rails.logger.info "========Priority Second ============#{(priority_first + priority_second).to_set.count}==================="
#       break if my_flag==1
#     end if (@books.present? and priority_first.count < 5)

#     ####### Priority Third ##################
#     other_users.each  do |other_user|
#       book_genre = other_user.books.select{|x|@user_preferences.select{|x|(x.by_scanning == false && x.book_deactivated == false && x.genre_deactivated == false && x.delete_genre == false && x.genre!="")}.map(&:genre).map{|x|x.split(' ')[0,5].join('').upcase}.include?(x["genre"].split(' ')[0,5].join('').upcase)}
#       @books.each do |book|
#         book_genre.each do |other_users_book_genre|
#           priority_third << book.as_json(:only => [:id, :title,:author,:genre, :about_us, :image_path]).merge(distance: other_user.distance.round(2))
#         end if (other_user.reading_preferences.select{|x|(x.by_scanning == false && x.book_deactivated == false && x.genre_deactivated == false && x.delete_genre == false && x.genre!="")}.map(&:genre).map{|x|x.split(' ')[0,5].join('').upcase}.include?(book.genre.split(' ')[0,5].join('').upcase) and book_genre.present?)
#         (my_flag=1;break;) if ((priority_first + priority_second + priority_third).to_set.count >=5)
#       end
#       Rails.logger.info "========Priority Third ============#{(priority_first + priority_second + priority_third).to_set.count}==================="
#       break if my_flag==1
#     end if (@books.present? and (priority_first + priority_second).to_set.count < 5)

#     ####### Priority Fourth ##################
#     other_users.each  do |other_user|
#       book_author_n = other_user.books.select{|x|@user_preferences.select{|x|(x.by_scanning == true && x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false && x.author!="")}.map(&:author).map{|x|x.split(' ')[0,5].join('').upcase}.include?(x["author"].split(' ')[0,5].join('').upcase)}
#       @books.each do |book|
#         book_author_n.each do |other_users_book_author_n|
#           priority_forth << book.as_json(:only => [:id, :title,:author,:genre, :about_us, :image_path]).merge(distance: other_user.distance.round(2))
#         end if (other_user.reading_preferences.select{|x|(x.by_scanning == true && x.book_deactivated == false && x.delete_author == false && x.author_deactivated == false && x.author!="")}.map(&:author).map{|x|x.split(' ')[0,5].join('').upcase}.include?(book.author.split(' ')[0,5].join('').upcase) and book_author_n.present?)
#         (my_flag=1;break;) if ((priority_first + priority_second + priority_third + priority_forth).to_set.count >=5)
#       end
#       Rails.logger.info "========Priority Fourth ============#{(priority_first + priority_second + priority_third + priority_forth).to_set.count}==================="
#       break if my_flag==1
#     end if (@books.present? and (priority_first + priority_second + priority_third).to_set.count  < 5)

#     ####### Priority Fifth ##################
#     other_users.each  do |other_user|
#       book_genre_n = other_user.books.select{|x|@user_preferences.select{|x|(x.by_scanning == true && x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false && x.genre!="")}.map(&:genre).map{|x|x.split(' ')[0,5].join('').upcase}.include?(x["genre"].split(' ')[0,5].join('').upcase)}
#       @books.each do |book|
#         book_genre_n.each do |other_users_book_genre_n|
#           priority_fifth << book.as_json(:only => [:id, :title,:author,:genre, :about_us, :image_path]).merge(distance: other_user.distance.round(2))
#         end if (other_user.reading_preferences.select{|x|(x.by_scanning == true && x.book_deactivated == false && x.delete_genre == false && x.genre_deactivated == false && x.genre!="")}.map(&:genre).map{|x|x.split(' ')[0,5].join('').upcase}.include?(book.genre.split(' ')[0,5].join('').upcase) and book_genre_n.present?)
#         (my_flag=1;break;) if ((priority_first + priority_second + priority_third + priority_forth + priority_fifth).to_set.count >=5)
#       end
#       Rails.logger.info "========Priority Fifth ============#{(priority_first + priority_second + priority_third + priority_forth + priority_fifth).to_set.count}==================="
#       break if my_flag==1
#     end if (@books.present? and (priority_first + priority_second + priority_third + priority_forth).to_set.count < 5)

#     matches = priority_first.sort_by{|x|x[:distance]} + priority_second.sort_by{|x|x[:distance]} + priority_third.sort_by{|x|x[:distance]} + priority_forth.sort_by{|x|x[:distance]} + priority_fifth.sort_by{|x|x[:distance]} 
#     matches.to_set.first(5)
#   end