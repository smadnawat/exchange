task :import_picture_book => :environment do
	Document.where(:image_path => "nil").each do |doc|	
		@isbn_last = doc.isbn13
	 	doc.image_path = "/#{Rails.root}/public/Covers/#{@isbn_last.to_s[9..10]}/#{@isbn_last.to_s[11..12]}/#{@isbn_last}.jpg*.*"
	   doc.save

	end
end


# task :import_picture_banglore => :environment do
# 		Venue.where(city: "Bangalore").each do |venue|
# 			files = Dir.glob("/#{Rails.root}/public/Bangalore Data/bangalore data/venue logos/#{venue.name}/*")
# 			files_image = Dir.glob("/#{Rails.root}/public/Bangalore Data/bangalore data/venue photos/#{venue.name}/*") 
# 			if files.present? && files_image.present? 
# 			p "====================first===#{venue.name}==========++++++++++#{venue.id}==================="
# 				venue.update_attributes(logo: File.open(files.first)) unless files.blank?
# 					files_image.each do |file|
# 						u = venue.pictures.build
# 						u.image = File.open(file)
# 						u.save
# 					end if !files_image.blank? 
# 			else
# 				venue.destroy
# 			end
# 			p "====================second===#{venue.name}==========++++++++++#{venue.id}==================="
# 	    end
# 	   p "=======================done============================="
# 	end


# files = Dir.glob("/#{Rails.root}/public/Covers/#{@isbn_last.to_s[9..10]}/#{@isbn_last.to_s[11..12]}/#{@isbn_last}*.*")
# files.each do |file|
# 	  name = File.basename(file,".jpg")
#     f = File.open(file)    
