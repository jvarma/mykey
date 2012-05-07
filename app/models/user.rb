class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

	before_save { |user| user.email = email.downcase }

  	# Setup accessible (or protected) attributes for your model
  	attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  	# attr_accessible :title, :body

  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name, presence: true, length: { maximum: 30 }

	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
		uniqueness: { case_sensitive: false }

	validates :password, length: { minimum: 6, maximum: 15 }

	validates :password_confirmation, presence: true

	has_many :assets

	has_one :profile, autosave: true, dependent: :destroy

	has_many :folders



	#this is for folders which this user has shared  
	has_many :shared_folders, :dependent => :destroy  
  
	#this is for folders which the user has been shared by other users  
	has_many :being_shared_folders, :class_name => "SharedFolder", :foreign_key => "shared_user_id", :dependent => :destroy 

	after_create :check_and_assign_shared_ids_to_shared_folders  
  
	#this is to make sure the new user ,of which the email addresses already used to share folders by others, to have access to those folders  
	def check_and_assign_shared_ids_to_shared_folders      
    	#First checking if the new user's email exists in any of ShareFolder records  
    	shared_folders_with_same_email = SharedFolder.find_all_by_shared_email(self.email)  
  
    	if shared_folders_with_same_email        
      		#loop and update the shared user id with this new user id   
      		shared_folders_with_same_email.each do |shared_folder|  
        		shared_folder.shared_user_id = self.id  
        		shared_folder.save  
      		end  
    	end      	
	end

end
