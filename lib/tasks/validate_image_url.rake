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


task :validate_images_url => :environment do
  hash = {}
  Document.find_each(start: 3222259,batch_size: 10000).with_index do |doc,index|
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



# task :upgrade_my_schema => :environment do
#     daata = ["20150529062602" , "20150529063228"  ,"20150529063246"  ,"20150529071234"  ,"20150529071948"  ,"20150529072750"  ,"20150529092047"  ,"20150529092105"  ,"20150601044006"  ,"20150601044011", "20150601050550" , "20150601052441" ,"20150601055248" ,"20150602063117"  ,
#   "20150602102246"  ,"20150602102343" ,"20150602123910" ,"20150604133518"  ,"20150604133620"  ,"20150604133723"  ,"20150604133754"  ,
#   "20150604145753"  ,"20150611044826" ,"20150615061252" ,"20150615061801" ,"20150616111456" ,"20150616121407"  ,"20150617084749" ,
#   "20150617085009"  ,"20150617085100"  ,"20150617101258"  ,"20150619070632"  ,"20150619070728"  ,
#   "20150622083757"  ,"20150622090801"  ,"20150622091031"  ,"20150622091437"  ,"20150622092511"  ,"20150622092701"  ,"20150624063441"  ,"20150624145748"  ,"20150625051243"  ,"20150626135123"  ,"20150629115352"  ,"20150629115939"  ,"20150630043932"  ,
#   "20150630110438"  ,"20150701062339"  ,"20150702115750"  ,"20150702120052"  ,"20150704091309"  ,"20150704114509"  ,"20150707053121"  ,"20150707142400"  ,"20150708130359"  ,"20150710053116"  ,"20150716053416"  ,"20150717100347"  ,
#   "20150723055947"  ,"20150723060013"  ,"20150723060029"  ,"20150723085814"  ,"20150724044225"  ,"20150724065855"  ,"20150727100349"  ,"20150728051132"  ,"20150728073748"  ,"20150728073840"  ,"20150728083808"  ,"20150728083847"  ,
#   "20150728115208"  ,"20150804053358"  ,"20150804095711"  ,"20150818130530" ] 
#   daata.each do |d|
#     sql = "insert into schema_migrations values('#{d}');"
#     ActiveRecord::Base.connection.execute(sql)
#     p "==-------#{d}"
#   end
# end