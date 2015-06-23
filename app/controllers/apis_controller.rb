require 'distance'

class ApisController < ApplicationController

 include CalculateDistance

  before_filter :find_user, :only => [:upload_books, :get_uploaded_books, :delete_uploaded_books, :delete_reading_preferences, :upload_reading_preferences, :my_reading_preferences, :my_reading_preferences_for_author, :my_reading_preferences_for_genre, :user_profile, :update_profile, :search_potential_matches]

	def register	
		params[:picture] = User.image_data(params[:picture])
		if params[:provider].present? && params[:provider] == User::A
			if @user = User.where('email = ?  AND provider !=?',params[:email],'normal').first					
		        render :json => {:responseCode => 200,:responseMessage => "Email id #{@user.email} is already registered with ExchangeApp through a #{@user.provider} account. Please login via same."} 
			else	
				@user = User.new(permitted_params)
					if @user.save	
						Device.total_devices(params[:device_id],params[:device_type],@user.id) unless params[:device_id].nil?
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
		        	render :json => {:responseCode => 500,:responseMessage => "Email ID #{@user.email} is already registered with ExchangeApp. Please login via same."} 
	     
	      elsif User.where('email = ? AND provider = ?',params[:email],'google').count == 0
			  	@user = User.find_by_email(params[:email]).provider
			   	  render :json => {:responseCode => 500,:responseMessage => "Email ID #{params[:email]} is already registered with ExchangeApp through a #{@user} account. Please login via same."} 
			  elsif User.where('email = ? AND provider = ?',params[:email],'facebook').count == 0
			  	@user = User.find_by_email(params[:email]).provider
			   	  render :json => {:responseCode => 500,:responseMessage => "Email ID #{params[:email]} is already registered with ExchangeApp through a #{@user} account. Please login via same."} 
			  
			  else     
				   #@user = User.create_via_social_media(params) # create_via_social_media is a class method in User Model
				    @user = User.create(permitted_params)
				     Device.total_devices(params[:device_id],params[:device_type],@user.id) unless params[:device_id].nil?
				   render :json => {:responseCode => 200,:responseMessage => 'Signed-up successfully.', :user_id => @user.id	}	
				end		
	
		else
			render_message 401, 'Unauthorized access!'
		end
	end

	def upload_books
	   @books = @user.books.build(books_params)
	     if @books.save
              render_message 200, 'Book has been uploaded successfully!'
         else			
              render_message 500, @books.errors.messages.first
         end	
	end

	def get_uploaded_books
		 @books = @user.books
		 if @books.present?
		    render :json => {    
		    	                :responseCode => 200,
		    	                :responseMessage => 'Your uploaded books!',
		    	                :Books => paging(@books, params[:page_no],params[:page_size]).as_json(only: [:id, :title, :author, :genre, :upload_date, :latitude, :longitude]),
		    	                :pagination => { page_no: params[:page_no],max_page_no: @max,total_no_records: @total }
		                     }
	   else
	         render :json =>    {    
			    	                :responseCode => 200,
			    	                :responseMessage => 'Your uploaded books!',
			    	                :Books => [],
			    	                :total_uploaded_books => 0
			                     }  
	   end
	end

	def upload_reading_preferences
	   @reading_pref = @user.reading_preferences.build(reading_pref_params)
	     if @reading_pref.save
              render_message 200, 'Your Reading Preference has been uploaded successfully!'
       else			
              render_message 500, @reading_pref.errors.messages.first
       end	
	end

	def my_reading_preferences
		 @reading_pref = @user.reading_preferences
		 if @reading_pref.present?
		    render :json => {    
		    	                :responseCode => 200,
		    	                :responseMessage => 'Your uploaded reading preferences!',
		    	                :Preferences => paging(@reading_pref, params[:page_no],params[:page_size]).as_json(only: [:title, :author, :genre, :id, :book_deactivated]),
		    	                :pagination => { page_no: params[:page_no],max_page_no: @max,total_no_records: @total }
		                     }
	   else
	         render :json =>    {    
			    	                :responseCode => 200,
			    	                :responseMessage => 'Your uploaded reading preferences!',
			    	                :Preferences => [],
			    	                :total_uploaded_books => 0
			                     }  
	   end
	end

	def my_reading_preferences_for_author
		@authors = @user.reading_preferences.select(:id, :author, :author_deactivated)
		if @authors.present?
			 render :json => {    
		    	                :responseCode => 200,
		    	                :responseMessage => 'Your uploaded authors in reading preferences!',
		    	                :Authors => paging(@authors, params[:page_no],params[:page_size]),
		    	                :pagination => { page_no: params[:page_no],max_page_no: @max,total_no_records: @total }
		                     }
	   else
	     render :json => {    
	    	                :responseCode => 200,
	    	                :responseMessage => 'Your uploaded authors in reading preferences!',
	    	                :Authors => [],
	    	                :total_uploaded_books => 0
	                     }  
	   end
	end
  
	def my_reading_preferences_for_genre
		@genres = @user.reading_preferences.select(:id, :genre, :genre_deactivated)
		if @genres.present?
			 render :json => {    
		    	                :responseCode => 200,
		    	                :responseMessage => 'Your uploaded genres in reading preferences!',
		    	                :Generes => paging(@genres, params[:page_no],params[:page_size]),
		    	                :pagination => { page_no: params[:page_no],max_page_no: @max,total_no_records: @total }
		                     }
	   else
	         render :json =>  {    
				    	                :responseCode => 200,
				    	                :responseMessage => 'Your uploaded genres in reading preferences!',
				    	                :Generes => [],
				    	                :total_uploaded_books => 0
			                      }  
	   end
	end

	def user_profile
		  		render :json => { 
						               :responseCode => 200,
						               :responseMessage => 'User profile.',
						               :user_profile => @user.as_json(only: [:username,:email,:gender, :picture, :about_me]),
						               :books => @user.reading_preferences.count,
						               :authors => @user.reading_preferences.pluck(:author).count,
						               :genres => @user.reading_preferences.pluck(:genre).count
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
  	 nearby_books = User.get_near_locations(params)#.as_json(only: [:title, :author, :genre, :id, :distance])
  	 render :json => {
                       :responseCode => 200,
                       :responseMessage => 'Potential Matches',
                       :potential_matches => nearby_books

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
  	  @reading_preferences = ReadingPreference.find_by_id_and_author(params[:reading_pref_id], params[:author_name]) 
      if @reading_preferences
  	       @reading_preferences.update_attributes(:author => " ")
           render :json => {:responseCode => 200,:responseMessage => "Author has been deleted successfully."}
      else
      	   render :json => {:responseCode => 500,:responseMessage => "Author name doesn't exists!."}
      end     
  end

  def delete_genre_name
  	  @reading_preferences = ReadingPreference.find_by_id_and_genre(params[:reading_pref_id], params[:genre_name]) 
      if @reading_preferences
  	       @reading_preferences.update_attributes(:genre => " ")
           render :json => {:responseCode => 200,:responseMessage => "Genre has been deleted successfully."}
      else
      	   render :json => {:responseCode => 500,:responseMessage => "Genre doesn't exists!."}
      end     
  end

  private

	def permitted_params
	   params.permit(:email, :username, :password, :password_confirmation, :gender, :location, :picture, :about_me, :reset_password_token, :author_prefernce, :genre_preference, :date_signup,:device_used, :latitude, :longitude, :provider, :u_id)
	end

	def books_params
	   params.permit(:title,:author,:genre,:upload_date,:upload_type,:latitude,:longitude)
	end

	def reading_pref_params
	   params.permit(:title,:author,:genre)
	end

end
