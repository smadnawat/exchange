require "net/http"


task :validate_images_url => :environment do
  Document.find_each(batch_size: 10000) do |doc|
    puts "--------------------DocumentID: #{doc.id}"
    isbn_last = doc.isbn13
    u =  "http://www.novelinked.com/covers/#{isbn_last.to_s[9..10]}/#{isbn_last.to_s[11..12]}/#{isbn_last}.jpg"
    url = URI.parse(u)
    req = Net::HTTP.new(url.host, url.port)
    res = req.request_head(url.path)
    if res.code == "200"
      doc.update_column(:image_url,u)
    end
  end
end



#start: 71063,