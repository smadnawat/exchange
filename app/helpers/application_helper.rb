module ApplicationHelper

   def average_rating(send,accepted)
      if send > 0 && accepted > 0
        @result =  ((accepted*100)/send).round
      else
         @result = 0
      end
    end

    def book_count(book)
      $arr = []
        book.each do |key , value|
          $arr << "#{key.split(',').last}" "-" "#{value}"
          p"#{value.inspect}====================="
        end
       return $arr.flatten.join(',')  
    end    

   def options_for_country_select
      [ "India", "Singapore", "USA", "Japan", "Others" ]
   end

  def full_title(page_title)
    base_title= "Novelinked"
    if page_title.empty?
      base_title
    else
      "#{page_title} - #{base_title}"
    end 
  end
  
   def meta_keywords(tags = nil)
    if tags.present?
      content_for :meta_keywords, tags
    else
      content_for?(:meta_keywords) ? [content_for(:meta_keywords), ENV['meta_keywords']].join(', ') : ENV['meta_keywords']
    end
  end

  def meta_description(desc = nil)
    if desc.present?
      content_for :meta_description, desc
    else
      content_for?(:meta_description) ? content_for(:meta_description) : ENV['meta_description']
    end
  end


end
