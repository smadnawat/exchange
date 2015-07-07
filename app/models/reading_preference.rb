class ReadingPreference < ActiveRecord::Base
  belongs_to :user

  validates_uniqueness_of :title, :allow_blank => true, :message => "already exists."

end

