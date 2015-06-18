class Notification < ActiveRecord::Base
  validates :subject, presence: true
  validates :content, presence: true 
  validates :All, presence: true
end
