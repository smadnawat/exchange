require 'distance'

class ApisController < ApplicationController

 include CalculateDistance

  before_filter :find_user, :only => [:upload_books, :get_uploaded_books, :upload_reading_preferences, :my_reading_preferences, :my_reading_preferences_for_author, :my_reading_preferences_for_genre, :user_profile, :update_profile, :search_potential_matches]

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
		    	                :Books => paging(@books, params[:page_no],params[:page_size]).as_json(only: [:title, :author, :genre, :upload_date]),
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
		    	                :Preferences => paging(@reading_pref, params[:page_no],params[:page_size]).as_json(only: [:title, :author, :genre]),
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
		@authors = @user.reading_preferences.pluck(:author)
		if @authors.present?
			 render :json => {    
		    	                :responseCode => 200,
		    	                :responseMessage => 'Your uploaded authors in reading preferences!',
		    	                :Authors => paging(@authors, params[:page_no],params[:page_size]),
		    	                :pagination => { page_no: params[:page_no],max_page_no: @max,total_no_records: @total }
		                     }
	   else
	         render :json =>    {    
			    	                :responseCode => 200,
			    	                :responseMessage => 'Your uploaded authors in reading preferences!',
			    	                :Authors => [],
			    	                :total_uploaded_books => 0
			                     }  
	   end
	end
  
	def my_reading_preferences_for_genre
		@genres = @user.reading_preferences.pluck(:genre)
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
						               :user_profile => @user.as_json(only: [:username,:email,:gender, :picture]),
						               :books => @user.reading_preferences.count,
						               :authors => @user.reading_preferences.pluck(:author).count,
						               :genres => @user.reading_preferences.pluck(:genre).count
				                  }	                
	end

  def update_profile
	    if @user.update_attributes(permitted_params)
	      render :json => {:responseCode => 200,:responseMessage => "Profile has been successfully updated."}
	    else
	      render :json => {:responseCode => 500,:responseMessage => @user.errors.full_messages.first}
	    end                   
  end  

  def search_potential_matches
  	 nearby_books = User.get_near_locations(params)#.as_json(only: [:title, :author, :genre, :id, :distance])

  	

  	 #nearby_books.each do |book|
  	 render :json => {
                       :responseCode => 200,
                       :responseMessage => 'Potential Matches',
                       :potential_matches => nearby_books

  	                  }
     #end 

  def create_ratings 
	@group_rating = Rating.new_group_rating(params, @user)
  	if @group_rating.save
  	  	 render :json => {
	                       :responseCode => 200,
	                       :responseMessage => 'Ratings generated successfully',
	                       :group_rating => @group_rating
	  	                  }
  	    else
  	    	render :json => {
		                     :responseCode => 200,
		                     :responseMessage => 'Already rated this person'
		  	                }
  	end
	end

	def get_ratings
	@group_rating = Rating.find_by_user_id_and_ratable_id(params[:user_id], params[:ratable_id])
		if @group_rating.present?
			render :json => {
	                       :responseCode => 200,
	                       :responseMessage => 'Ratings fetched successfully',
	                       :get_ratings => @group_rating
	  	                  }
	  	else
	  		render :json => {
	                       :responseCode => 200,
	                       :responseMessage => 'No record found'
	  	                  }
	  end
	end



  end

  private

	def permitted_params
	   params.permit(:email, :username, :password, :password_confirmation, :gender, :location, :picture, :reset_password_token, :author_prefernce, :genre_preference, :date_signup,:device_used, :latitude, :longitude, :provider, :u_id)
	end

	def books_params
	   params.permit(:title,:author,:genre,:upload_date,:upload_type,:latitude,:longitude)
	end

	def reading_pref_params
	   params.permit(:title,:author,:genre)
	end
end
