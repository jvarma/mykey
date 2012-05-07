class Folder < ActiveRecord::Base
  
  	acts_as_tree

  	attr_accessible :name, :parent_id, :user_id

  	belongs_to :user

  	has_many :assets, dependent: :destroy

  	has_many :shared_folders, :dependent => :destroy
  
  	#a method to check if a folder has been shared or not  
	def shared?  
    	@shared_folder = SharedFolder.find_by_folder_id(self.id)
    	if @shared_folder.nil?
    		false
    	else
    		true
    	end  
	end 

end
