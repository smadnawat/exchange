class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
   # validates :username,
   # :presence => true,
   # :uniqueness => { :case_sensitive => false },
   # :format => { with: /\A[a-zA-Z]+\z/ },
   # :length => { in: 4..20 }

   # validates :username, :inclusion => { :in => 0..15, :message => " should be between 0 to 15" }
   # validates :username, :presence => { :message => " cannot be blank" }

	# validates :username,
	#   :presence => true,
	#   :uniqueness => {
	#     :case_sensitive => false
	#   }
   end

