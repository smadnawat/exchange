require "net/http"


# task :validate_images_url => :environment do
#   Document.find_each(start: 171031,batch_size: 10000).with_index do |doc,index|
#     puts "--------------------DocumentID: #{doc.id}"
#     # isbn_last = doc.isbn13
#     # u =  "http://www.novelinked.com/covers/#{isbn_last.to_s[9..10]}/#{isbn_last.to_s[11..12]}/#{isbn_last}.jpg"
#     # url = URI.parse(u)
#     # req = Net::HTTP.new(url.host, url.port)
#     # res = req.request_head(url.path)
#     # if res.code == "200"
#     #   doc.update_column(:image_url,u)
#     #   hash[doc.id] = {"image_url"=>u}
#     # end

#     if index%1000==0

#     end
#   end
# end



# 176667

task :validate_images_url => :environment do
  hash = {}
  Document.find_each(start: 212270,batch_size: 10000).with_index do |doc,index|
    isbn_last = doc.isbn13
    u =  "http://www.novelinked.com/covers/#{isbn_last.to_s[9..10]}/#{isbn_last.to_s[11..12]}/#{isbn_last}.jpg"
    url = URI.parse(u)
    req = Net::HTTP.new(url.host, url.port)
    res = req.request_head(url.path)
    if res.code == "200"
      #doc.update_column(:image_url,u)
      hash[doc.id] = {"image_url"=>u}
      puts "--#{index}---------DocumentID: #{doc.id}"
    end
    if index%100==0
      Document.update(hash.keys, hash.values)
      hash = {}
      p "===========-#{index}====after update=====-DocumentID: #{doc.id}==="
    end
  end
end



