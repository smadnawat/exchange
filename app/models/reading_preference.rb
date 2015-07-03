class ReadingPreference < ActiveRecord::Base
  belongs_to :user

  validates_uniqueness_of :title, :message => "already exists."
  validates_uniqueness_of :isbn13, :message => "should be unique."

end

