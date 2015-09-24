require 'distance'

class ApisController < ApplicationController

  include CalculateDistance

  before_filter :find_user, :only => [:upload_by_scanning_counts, :view_my_review, :update_lat_and_long, :my_invites, :notification_status, :delete_author_name, :delete_genre_name, :my_library, :potential_mat_profile, :upload_multiple_reading_pref,:create_ratings, :get_ratings, :my_chat_list, :invitation_details,:upload_books, :get_uploaded_books, :delete_uploaded_books, :delete_reading_preferences, :upload_reading_preferences, :my_reading_preferences, :my_reading_preferences_for_author, :my_reading_preferences_for_genre, :user_profile, :update_profile, :search_potential_matches]

	def register	
		params[:picture] = User.image_data(params[:picture])
		if params[:provider].present? && params[:provider] == User::A
			if @user = User.where('email = ?  AND provider !=?',params[:email],'normal').first					
		        render :json => {:responseCode => 200,:responseMessage => "Email id #{@user.email} is already registered with Novelinked through a #{@user.provider} account. Please login via same."} 
			else	
				@user = User.new(permitted_params)
					if @user.save	
						User.generate_sign_in_token(@user)
						  manage_devices(@user)
						#Device.total_devices(params[:device_id],params[:device_type],@user.id) unless params[:device_id].nil?
						render :json => {:responseCode => 200,:responseMessage => 'Your registration process is successfull.', :user_id => @user.id	} 
					else
						render :json => {:responseCode => 500, :responseMessage => @user.errors.full_messages.first}			
					end
			end
		elsif (params[:provider].present? && params[:provider] == User::B) || (params[:provider].present? && params[:provider] == User::C)
			@user = User.find_by_provider_and_u_id(params[:provider],params[:u_id])
				if @user.present? 
				   @user.update_via_social_media(params) # update_via_social_media is a instance method in User Model
				   render :json => {:responseCode => 200,:responseMessage => 'Logged in successfull.', :user_id => @user.id	}
				
				elsif @user = User.where('email = ? AND provider = ?',params[:email],'normal').first					
	        	render :json => {:responseCode => 500,:responseMessage => "Email ID #{@user.email} is already registered with Novelinked. Please login via same."} 
  
        elsif User.where('email = ? AND provider = ?',params[:email],'google').count == 0
			  	@useer = User.find_by_email(params[:email])
			  	if @useer.present?
			  		 @user = @useer.provider
			   	   render :json => {:responseCode => 500,:responseMessage => "Email ID #{params[:email]} is already registered with Novelinked through a #{@user} account. Please login via same."} 
			   	else
			   	   @user = User.create(permitted_params)
				     manage_devices(@user)
				     #Device.total_devices(params[:device_id],params[:device_type],@user.id) unless params[:device_id].nil?
				     render :json => {:responseCode => 200,:responseMessage => 'Signed-up successfully.', :user_id => @user.id	}	
				  end		
			  
			  elsif User.where('email = ? AND provider = ?',params[:email],'facebook').count == 0
			  	@useer = User.find_by_email(params[:email])
			  	if @useer.present?
			  		 @user = @useer.provider
			   	   render :json => {:responseCode => 500,:responseMessage => "Email ID #{params[:email]} is already registered with Novelinked through a #{@user} account. Please login via same."} 
			   	else
			   	   @user = User.create(permitted_params)
				     manage_devices(@user)
				     #Device.total_devices(params[:device_id],params[:device_type],@user.id) unless params[:device_id].nil?
				     render :json => {:responseCode => 200,:responseMessage => 'Signed-up successfully.', :user_id => @user.id	}	
				  end
			  else     
				   #@user = User.create_via_social_media(params) # create_via_social_media is a class method in User Model
				    @user = User.create(permitted_params)
				      manage_devices(@user)
				      #Device.total_devices(params[:device_id],params[:device_type],@user.id) unless params[:device_id].nil?
				      render :json => {:responseCode => 200,:responseMessage => 'Signed-up successfully.', :user_id => @user.id	}	
				end		
		else
			render_message 401, 'Unauthorized access!'
		end
	end

	def upload_books
	   @books = @user.books.build(books_params)
	    if params[:isbn13].present?
	      @isbn_last = params[:isbn13]
        @books.image_path = "http://ec2-52-24-139-4.us-west-2.compute.amazonaws.com/covers/#{@isbn_last.to_s[9..10]}/#{@isbn_last.to_s[11..12]}/#{@isbn_last}.jpg" 
      end 
		    if @books.save
		           if params[:upload_type].eql? "scanning" and params[:reading_pref_upload].eql? "true" and params[:isbn13].present?
		           	  @isbn_last = params[:isbn13] 
		              @reading_pref = @user.reading_preferences.build(:title => " ", :author => params[:author], :genre => params[:genre], :isbn13 => params[:isbn13], :by_scanning => true)
		              @reading_pref.image_path = "http://ec2-52-24-139-4.us-west-2.compute.amazonaws.com/covers/#{@isbn_last.to_s[9..10]}/#{@isbn_last.to_s[11..12]}/#{@isbn_last}.jpg" 
			              @reading_pref.save
		           end
		      render_message 200, 'Book has been uploaded successfully!'     
	      else			
	        render_message 500, @books.errors.full_messages.first[5..28] #@books.errors.full_messages.first
	      end	
	end

	def get_uploaded_books
		 @books = @user.books
		 if @books.present?
		    render :json => {    
		    	                :responseCode => 200,
		    	                :responseMessage => 'Your uploaded books!',
		    	                :Books => paging(@books, params[:page_no],params[:page_size]).as_json(only: [:id, :title, :author, :genre, :upload_date, :latitude, :longitude, :image_path]),
		    	                :pagination => { page_no: params[:page_no],max_page_no: @max,total_no_records: @total }
		                     }
	   else
	         render :json =>    { :responseCode => 200, :responseMessage => 'Your uploaded books!', :Books => [], :total_uploaded_books => 0 }  
	   end
	end

	def upload_reading_preferences
	   @reading_pref = @user.reading_preferences.build(reading_pref_params)
	      if params[:isbn13].present?
	       @isbn_last = params[:isbn13]
         @reading_pref.image_path = "http://ec2-52-24-139-4.us-west-2.compute.amazonaws.com/covers/#{@isbn_last.to_s[9..10]}/#{@isbn_last.to_s[11..12]}/#{@isbn_last}.jpg" 
        end 
	     if @reading_pref.save
              render_message 200, 'Your Reading Preference has been uploaded successfully!'
       else			
              render_message 500, @reading_pref.errors.full_messages.first
       end	
	end

	def my_reading_preferences
		  @user = User.includes(:reading_preferences).where(:id => params[:user_id]).first
		  @user_preferences = @user.reading_preferences
			  @reading_pref = @user_preferences.where("title != ? and genre = ? and author = ? ", " ", " ", " ") + @user_preferences.where("title != ? and genre = ? and author != ? ", " ", " ", " ") + @user_preferences.where("title != ? and genre != ? and author = ? ", " ", " ", " ") + @user_preferences.where("title != ? and genre != ? and author != ? ", " ", " ", " ")
				 if @reading_pref.present?
				    render :json => {    
				    	                :responseCode => 200,
				    	                :responseMessage => 'Your uploaded reading preferences!',
				    	                :Preferences => paging(@reading_pref, params[:page_no],params[:page_size]).uniq {|p| p.title}.as_json(only: [:title, :author, :genre, :id, :book_deactivated, :image_path]),
				    	                :pagination => { page_no: params[:page_no],max_page_no: @max,total_no_records: @total }
				                     }
			   else
			         render :json =>    { :responseCode => 200, :responseMessage => 'Your uploaded reading preferences!', :Preferences => [], :total_uploaded_books => 0 }  
			   end
	end

	def my_reading_preferences_for_author
		  @user = User.includes(:reading_preferences).where(:id => params[:user_id]).first
		  @user_preferences = @user.reading_preferences.where(:delete_author => false)
			@authors = @user_preferences.where("title = ? and genre = ? and author != ? ", " ", " ", " ") + @user_preferences.where("title = ? and genre != ? and author != ? ", " ", " ", " ") 
		if @authors.present?
			 render :json => {    
		    	                :responseCode => 200,
		    	                :responseMessage => 'Your uploaded authors in reading preferences!',
		    	                :Authors => paging(@authors, params[:page_no],params[:page_size]).uniq {|p| p.author}.as_json(only: [:id, :author, :author_deactivated]),
		    	                :pagination => { page_no: params[:page_no],max_page_no: @max,total_no_records: @total }
		                     }
	   else

	     render :json => { :responseCode => 200, :responseMessage => 'Your uploaded authors in reading preferences!', :Authors => [], :total_uploaded_books => 0 }  
	   end
	end
  
	def my_reading_preferences_for_genre
		  @user = User.includes(:reading_preferences).where(:id => params[:user_id]).first
		  @user_preferences = @user.reading_preferences.where(:delete_genre => false)
			@genres = @user_preferences.where("title = ? and genre != ? and author = ? ", " ", " ", " ") + @user_preferences.where("title = ? and genre != ? and author != ? ", " ", " ", " ") 
		if @genres.present?
			 render :json => {    
		    	                :responseCode => 200,
		    	                :responseMessage => 'Your uploaded genres in reading preferences!',
		    	                :Generes => paging(@genres, params[:page_no],params[:page_size]).uniq {|p| p.genre}.as_json(only: [:id, :genre, :genre_deactivated]),
		    	                :pagination => { page_no: params[:page_no],max_page_no: @max,total_no_records: @total }
		                     }
	   else
	      render :json =>  { :responseCode => 200, :responseMessage => 'Your uploaded genres in reading preferences!', :Generes => [], :total_uploaded_books => 0 }  
	   end
	end

	def user_profile
    @user = User.includes(:reading_preferences).where(:id => params[:user_id]).first
		  @user_preferences = @user.reading_preferences
			  @reading_pref = @user_preferences.where("title != ? and genre = ? and author = ? ", " ", " ", " ") + @user_preferences.where("title != ? and genre = ? and author = ? ", " ", " ", " ") + @user_preferences.where("title != ? and genre = ? and author != ? ", " ", " ", " ") + @user_preferences.where("title != ? and genre != ? and author = ? ", " ", " ", " ") + @user_preferences.where("title != ? and genre != ? and author != ? ", " ", " ", " ")
				 	@authors = @user_preferences.where(:delete_author => false).where("title = ? and genre = ? and author != ? ", " ", " ", " ") + @user_preferences.where(:delete_author => false).where("title = ? and genre != ? and author != ? ", " ", " ", " ") 
            	@genres = @user_preferences.where(:delete_genre => false).where("title = ? and genre != ? and author = ? ", " ", " ", " ") + @user_preferences.where(:delete_genre => false).where("title = ? and genre != ? and author != ? ", " ", " ", " ") 
		  		    #@rating = Rating.calculate_ratings(@user)
		  		render :json => { 
						               :responseCode => 200,
						               :responseMessage => 'User profile.',
						               :user_profile => @user.as_json(only: [:username,:email,:gender, :picture, :about_me]),
						               :books => @reading_pref.count,
						               :authors => @authors.count,
						               :genres => @genres.count
				                  }	                
	end

  def update_profile
  		params[:picture] = User.image_data(params[:picture])
	     if @user.update_attributes(permitted_params)
	      render :json => {
	      	               :responseCode => 200,
	      	               :responseMessage => "Profile has been successfully updated.",
	      	               :user_profile => @user.as_json(only: [:username,:email,:gender, :picture, :about_me]),
                         :books => @user.reading_preferences.count,
						             :authors => @user.reading_preferences.pluck(:author).count,
						             :genres => @user.reading_preferences.pluck(:genre).count

                 	      }

	    else
	      render :json => {:responseCode => 500,:responseMessage => @user.errors.full_messages.first}
	    end                   
  end  

  def search_potential_matches
  	 nearby_books,count = User.get_near_matches(params)#.as_json(only: [:title, :author, :genre, :id, :distance])
  	 render :json => {
                       :responseCode => 200,
                       :responseMessage => 'Potential Matches',
                       :potential_matches => {matches: nearby_books[:matches].sort_by{|x|x[:other_user_detail][:distance]}}, 
                       :total_no_records => count
  	                  }

  end

  def delete_uploaded_books
  	  @book = @user.books.find_by_id(params[:book_id])
  	  if @book
  	  	 @book.destroy 
         render :json => {:responseCode => 200,:responseMessage => "Book has been deleted successfully."}
	    else
	       render :json => {:responseCode => 500,:responseMessage => "Book doesn't exists!."}
	    end  	
  end

  def delete_reading_preferences
  	  @reading_preferences = @user.reading_preferences.find_by_id(params[:reading_pref_id])
  	  if @reading_preferences
  	  	 @reading_preferences.destroy 
         render :json => {:responseCode => 200,:responseMessage => "Reading Preferences has been deleted successfully."}
	    else
	       render :json => {:responseCode => 500,:responseMessage => "Reading Preferences doesn't exists!."}
	    end  	
  end

  def deactivate_books_from_rp
  	  @reading_preferences = ReadingPreference.find_by_id(params[:reading_pref_id])
  	  if @reading_preferences
  	  	  if @reading_preferences.book_deactivated.eql? false
	  	  	  @reading_preferences.update_attributes(:book_deactivated => params[:book_deactivated])
	          render :json => {:responseCode => 200,:responseMessage => "Reading Preferences has been deactivated successfully."}
	        else
	        	@reading_preferences.update_attributes(:book_deactivated => params[:book_deactivated])
	          render :json => {:responseCode => 200,:responseMessage => "Reading Preferences has been activated successfully."}
	        end  
	    else
	       render :json => {:responseCode => 500,:responseMessage => "Reading Preferences doesn't exists!."}
	    end  	
  end

  def deactivate_authors_from_rp
  	  @reading_preferences = ReadingPreference.find_by_id(params[:reading_pref_id])
  	  if @reading_preferences
          if @reading_preferences.author_deactivated.eql? false 
  	  	     @reading_preferences.update_attributes(:author_deactivated => params[:author_deactivated])
             render :json => {:responseCode => 200,:responseMessage => "Author has been deactivated successfully."}
          else
             @reading_preferences.update_attributes(:author_deactivated => params[:author_deactivated])
             render :json => {:responseCode => 200,:responseMessage => "Author has been activated successfully."}
          end    
	    else
	       render :json => {:responseCode => 500,:responseMessage => "Reading Preferences doesn't exists!."}
	    end  	
  end

  def deactivate_genres_from_rp
  	  @reading_preferences = ReadingPreference.find_by_id(params[:reading_pref_id])
  	  if @reading_preferences
  	  	  if @reading_preferences.genre_deactivated.eql? false
  	  	      @reading_preferences.update_attributes(:genre_deactivated => params[:genre_deactivated])
              render :json => {:responseCode => 200,:responseMessage => "Genre has been deactivated successfully."}
          else
          	  @reading_preferences.update_attributes(:genre_deactivated => params[:genre_deactivated])
              render :json => {:responseCode => 200,:responseMessage => "Genre has been activated successfully."}
          end    
	    else
	       render :json => {:responseCode => 500,:responseMessage => "Reading Preferences doesn't exists!."}
	    end  	
  end


  def delete_author_name
  	  @author = @user.reading_preferences.where(:author => params[:author_name])
  	  if @author 
  	  	  @author.update_all(:delete_author => true)
  	      render :json => {:responseCode => 200,:responseMessage => "Author has been deleted successfully."}
      else
     	    render :json => {:responseCode => 500,:responseMessage => "Author name doesn't exists!."}
      end    
  end

  def delete_genre_name
  	  @genre = @user.reading_preferences.where(:genre => params[:genre_name])
  	  if @genre 
  	  	  @genre.update_all(:delete_genre => true)
  	      render :json => {:responseCode => 200,:responseMessage => "Category has been deleted successfully."}
      else
     	    render :json => {:responseCode => 500,:responseMessage => "Category doesn't exists!."}
      end    
  end

  def create_ratings 
 		@rating = Rating.find_by_group_id_and_ratable_id_and_user_id(params[:group_id], params[:ratable_id], params[:user_id])
 		@ratable  = User.find_by_id(params[:ratable_id])
 		if @rating
 			message = "Already rated this person.."
 		else
 			if Group.find_by_id(params[:group_id]).present? and User.find_by_id(params[:ratable_id]).present?
	 			@group_rating = Rating.new_group_rating(params, @user)
	 			message = "Rating create successfully.."
	 		else
	 			message = "Rating not created"
	 		end
 		end
	  render :json => {
                     :responseCode => 200,
                     :user => @ratable.as_json(only: [:id, :username, :picture]),
                     :responseMessage => message
	                  }
 	end

	def get_ratings
	  @group_rating = Rating.find_by_group_id_and_ratable_id_and_user_id(params[:group_id], params[:ratable_id], params[:user_id])
		@ratable = User.find_by_id(params[:ratable_id])
		if @group_rating.present?
			render :json => {
                       :responseCode => 200,
                       :responseMessage => 'Ratings fetched successfully',
                       :get_ratings => @group_rating.as_json(except: [:created_at,:updated_at]),
                       :user => @ratable.as_json(only: [:id, :username, :picture])
  	                  }
	  	else
  		render :json => {
                       :responseCode => 500,
                       :responseMessage => 'No record found',
                       :user => @ratable.as_json(only: [:id, :username, :picture])
  	                  }
	  end
	end

	def invitation_details
		@invitation = Invitation.find_by_id(params[:notification_id])
		if @invitation.present?
			if  @invitation.invitation_status == 'B'
				  @book_to_get = Book.find_by_id(@invitation.book_to_get.to_i)
				  @book_to_give = Book.find_by_id(@invitation.book_to_give)

			elsif @invitation.invitation_status == 'RP' 
			      @book_to_get = ReadingPreference.find_by_id(@invitation.book_to_get.to_i)
				    @book_to_give = ReadingPreference.find_by_id(@invitation.book_to_give)
      else
            @book_to_give = Book.find_by_id(@invitation.book_to_give.to_i)
      end	
				@user = User.find_by_id(@invitation.user_id)
				@rating = Rating.calculate_ratings(@user)
				render :json => {
	                     :responseCode => 200,
	                     :responseMessage => 'Invitation details fetched successfully',
	                     
	                     :data => @invitation.invitation_status,
	                     :book_to_get => @book_to_get,
	                     :book_to_give => @book_to_give,
	                     :ratings => @rating,
	                     :sender => @user.as_json(only: [:id, :username, :picture])
	  	                  }
  	    else
	    	render :json => {
	                     :responseCode => 500,
	                     :responseMessage => 'No record found'
	  	                	}
  	    end
	end

	def my_chat_list

		@user_groups = UserGroup.where(user_id: @user.id, :is_deleted => nil).includes(:user,:group=>[:admin,:manager])
    @chat_list = []
		@user_groups.each do |uu|
			hash = {}
			chat_with = (uu.group.admin_id==uu.user_id) ? uu.group.manager : uu.group.admin
			hash[:chat_with] = chat_with.as_json(only: [:id, :username])
			hash[:created_at] = uu.created_at
			hash[:group_detail]=uu.group.as_json(only: [:id, :name])
			@chat_list << hash
		end

		if @chat_list.present?
		render :json => {
	                       :responseCode => 200,
	                       :responseMessage => 'My chat list fetched successfully',
	                       :chat_list => paging(@chat_list, params[:page_no],params[:page_size]),#.as_json(only: [:id, :name]),
	                       :pagination => { page_no: params[:page_no],max_page_no: @max, total_no_records: @total }
	  	                  }
  	else
  	    	render :json => {
		                     :responseCode => 200,
		                     :responseMessage => 'No record found'
		  	                }
  	end
	end

	def author_search
	 	@author = Author.search(params[:title])		
	  render :json => {
                        :responseCode => 200,
                        :responseMessage => "Author name's are fetched successfully!",
                        :name => paging(@author, params[:page_no],params[:page_size]).as_json(only: [:title]),
                        :pagination => { page_no: params[:page_no],max_page_no: @max,total_no_records: @total }	                   
	                   }  
	end


	def genre_search
		@genre = Genre.search(params[:name])		
	  render :json => {
                        :responseCode => 200,
                        :responseMessage => "Genre name's are fetched successfully!",
                        :name => paging(@genre, params[:page_no],params[:page_size]).as_json(only: [:title]),
                        :pagination => { page_no: params[:page_no],max_page_no: @max,total_no_records: @total }	                   
	                   } 
	end

	def upload_book_title_search
			#@titles = Document.search(params[:title], star: true, page: params[:page], per_page: 15)
      @titles = Document.search(params[:title], star: true)
		   render :json => {
                        :responseCode => 200,
                        :responseMessage => "Book title's are fetched successfully!",
                        #:name => @titles
                        :name => paging(@titles, params[:page_no],params[:page_size]).map{|x|x.attributes.merge(about_us: x.overview.gsub(/<\/?[^>]*>/, ""))},
                        :pagination => { page_no: params[:page_no],max_page_no: @max, total_no_records: @total}                  
	                      } 
	end

	def upload_book_author_search
		  #@author = Document.search_author(params[:name])
		  @author = Document.search(params[:name], star: true)
		    render :json => {
                        :responseCode => 200,
                        :responseMessage => "Book author's are fetched successfully!",
                        #:name => @author
                        #:name => paging(@author, params[:page_no],params[:page_size]).as_json(only: [:author, :isbn13]),
                        :name => paging(@author, params[:page_no], params[:page_size]).map{|x|x.attributes.merge(about_us: x.overview.gsub(/<\/?[^>]*>/, ""))},
                        :pagination => { page_no: params[:page_no],max_page_no: @max,total_no_records: @total }	                   
	                       } 
	end

	def scanning_isbn
		  @book = Document.where("isbn13 = ? or isbn10 = ?",params[:isbn_no],params[:isbn_no]).first
		   if @book.present?
		 	   render :json => {
	                        :responseCode => 200,
	                        :responseMessage => "Book fetched successfully!",
	                        :name => @book.attributes.merge!(about_us: @book.overview.gsub(/<\/?[^>]*>/, ""),image_url: "http://ec2-52-24-139-4.us-west-2.compute.amazonaws.com/covers/#{@book.isbn13.to_s[9..10]}/#{@book.isbn13.to_s[11..12]}/#{@book.isbn13}.jpg"),
	                        :subjects => ScanningSubject.pluck(:title)
	                       } 
	    else
	    	render :json => {
	    		                :responseCode => 500,
	    		                :responseMessage => "Book not available for this isbn no.!",
	    		                :name => {},
	    		                :subjects => []
	    	                 }
	    end                   
	end

	def upload_by_scanning_counts
		@book_count = Book.where(:user_id => params[:user_id], :upload_type => "scanning").count
		if @book_count.present?
			  render :json => {
	                        :responseCode => 200,
	                        :responseMessage => "Book counts fetched successfully!",
	                        :count => @book_count
	                       } 
	  end                    
	end

	def reading_prf_searching     # Search by Book Name, Author name, isbn_no or genre  #.sort_by { |i| [i ? 0 : 1, i] }
		  @book = Document.search(params[:name], star: true, :per_page => 1000).map{|x| x.attributes.merge!(image_url:  "http://ec2-52-24-139-4.us-west-2.compute.amazonaws.com/covers/#{x.isbn13.to_s[9..10]}/#{x.isbn13.to_s[11..12]}/#{x.isbn13}.jpg")}
		  if @book.present?
		  	 render :json => {
                            :responseCode => 200,
                            :responseMessage => "Books has been searched successfully!",
                            :book => paging(@book, params[:page_no],params[:page_size]).as_json(only: ["author", "title","subjects", "isbn13", :image_url]),
                            :pagination => { page_no: params[:page_no],max_page_no: @max,total_no_records: @total }	                   
		  	                   }
		  else
		  	 render :json => {
                            :responseCode => 500,
                            :responseMessage => "Your search didn't matched any books!",
                            :book => []
		  	                   }
		  end                 
	end

	def get_advertisement	
		  @ad_pictures = Banner.all
			render :json => { 
				               :responseCode => 200,
				               :responseMessage => 'Listing advertisement pictures.',
				               :ad_pictures => paging(@ad_pictures, params[:page_no],params[:page_size]).as_json(except: [:created_at,:updated_at]),
				               :pagination => { page_no: params[:page_no],max_page_no: @max,total_no_records: @total }	                   
				              }		
	end

	def upload_multiple_reading_pref
		if params[:reading_preference].present?
		 		@reading_pref = @user.reading_preferences.create(params.permit(:reading_preference => [:title,:author,:genre, :image_path, :isbn13])[:reading_preference])	
		 		msg = "Reading Preferences uploaded successfully"
		end
		render :json => {
                      :responseCode => 200,
                      :responseMessage => msg
		  	            }
	end

	def my_library
		@my_lib = @user.books.count	
		@live_chats = @user.groups.count
 				render :json => {
                         :responseCode => 200,
                         :responseMessage => "Your library count!",
                         :library_count => @my_lib,
                         :live_chats => @live_chats
		  	                 }
	end

	def potential_mat_profile
		@user_profile = User.where(:id => params[:user_id]).includes(:reading_preferences, :books, :ratings)	
		@rating = Rating.calculate_ratings(@user)
		 render :json => {
                       :responseCode => 200,
                       :responseMessage => "Profile for Potential Matches",
                       :profile => @user_profile.map{|x|x.attributes.merge(reading_preferences: x.reading_preferences.as_json(only: [:id, :title, :author, :genre]),books: x.books.as_json(only: [:id, :title]))},
		                   :average_rating => @rating,  
		                   :books_in_lib => @user.books.count,
		                   :reading_preference_count => @user.reading_preferences.count,
		                   :author_prefernce_count => @user.reading_preferences.pluck(:author).count
		                  }
	end

	def view_my_review
		@review = Rating.where('ratable_id = ?', @user)
		if @review
			@rating = Rating.calculate_ratings(@user)
			render :json => {
											:responseCode => 200,
                      :responseMessage => 'Review details fetched successfully',
                      :ratings => @rating,
                      :Review => @review.as_json(only: [:comment],:include => {:user => {:only => [:picture, :username]}})
                    	}
		else
			render :json => {:responseCode => 500,:responseMessage => 'Something went wrong'} 
		end
	end

	def notification_status
			if @user.notification_status.eql? true
			   @user.update_attributes(:notification_status => params[:notification_status])	
			   render :json => {:responseCode => 200, :responseMessage => "Notification has been turned off successfully!."}	
			else
			  @user.update_attributes(:notification_status => params[:notification_status])
			  render :json => {:responseCode => 200, :responseMessage => "Notification has been turned on successfully!."}  
			end
	end

	def terms_and_conditions
		  @terms_and_conditions = TermsAndCondition.last.as_json(only: [:description])
		  		render :json => {
											      :responseCode => 200,
                            :responseMessage => 'Terms & Conditions fetched successfully',
                            :description => @terms_and_conditions
                    	    }
	end

	def privacy_policy
		  @privacy_policy = PrivacyPolicy.last.as_json(only: [:description])
		  		render :json => {
											      :responseCode => 200,
                            :responseMessage => 'Privacy Policy fetched successfully',
                            :description => @privacy_policy
                    	    }
	end
  
  def update_sign_in_token
  	@user = User.find_by_sign_in_token(params[:format])
  	@user.update_attributes(:sign_in_token => nil)
  end

  def update_lat_and_long
  	  @user.update_attributes(:latitude => params[:latitude], :longitude => params[:longitude])
  	        render :json => {
											      :responseCode => 200,
                            :responseMessage => 'Latitude and longitude updated successfully.'
                    	      }  
  end

  def my_invites
  	@invitation_list = Invitation.where(:user_id => @user.id)
    invitation_detail = []
    @invitation_list.each do |invitation_list|
          
      invite_list = {}
    	invite_list[:username] = User.find_by_id(invitation_list.attendee).username if User.find_by_id(invitation_list.attendee).present?
      invite_list[:created_at] = invitation_list.created_at
      invite_list[:book_to_give_book] = invitation_list.invitation_status == 'B' ? Book.find_by_id(invitation_list.book_to_give).as_json(only: [:title]) : nil
      invite_list[:book_to_give_reading_pref] = invitation_list.invitation_status == 'RP' ? ReadingPreference.find_by_id(invitation_list.book_to_give).as_json(only: [:title, :author, :genre]) : nil
      invite_list[:book_to_give_education] = invitation_list.invitation_status == 'ED' ? Book.find_by_id(invitation_list.book_to_give).as_json(only: [:title]) : nil
      invitation_detail << invite_list
      end 
            render :json => {
											      :responseCode => 200,
                            :responseMessage => 'Your invites fetched successfully.',
                            :invite_details => paging(invitation_detail, params[:page_no], params[:page_size]),
                            :pagination => { page_no: params[:page_no],max_page_no: @max,total_no_records: @total }

                    	      } 
  end

  private

	def permitted_params
	   params.permit(:email, :username, :password, :password_confirmation, :sign_in_token, :gender, :location, :picture, :about_me, :reset_password_token, :author_prefernce, :genre_preference, :date_signup,:device_used, :latitude, :longitude, :provider, :u_id, reading_preferences_attributes: [:title, :author, :genre])
	end

	def books_params
	   params.permit(:title,:author,:genre,:upload_date,:upload_type,:latitude,:longitude, :isbn13, :about_us)
	end

	def reading_pref_params
	   params.permit(:title,:author,:genre, :isbn13, :image_path)
	end

  def manage_devices(user)
		unless params[:device_id].nil?  
			@devices = Device.where(:device_id => params[:device_id])
			@devices.destroy_all unless @devices.blank?
			@devices = user.devices.create(:device_type => params[:device_type],:device_id => params[:device_id])
		end
	end


end



