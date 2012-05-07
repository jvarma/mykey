class SharedFolder < ActiveRecord::Base
	attr_accessible :folder_id, :message, :shared_email, :shared_user_id, :user_id
    
  	#this is for the owner(creator) of the assets  
  	belongs_to :user  
    
  	#this is for the user to whom the owner has shared folders to  
  	belongs_to :shared_user, :class_name => "User", :foreign_key => "shared_user_id"  
    
  	#for the folder being shared  
  	belongs_to :folder  

end
