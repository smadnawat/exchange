class ReadingPreference < ActiveRecord::Base
  belongs_to :user

  #validates_uniqueness_of :title, :allow_blank => true, :message => "already exists."
  validates :user_id, :uniqueness => {:scope => [:isbn13] , :message => "reading preference already exists!."}, if: 'isbn13.present?'

end

