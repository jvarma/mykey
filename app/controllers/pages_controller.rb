class PagesController < ApplicationController
  def home
  	@users = User.all
  	if user_signed_in?  
      @assets = current_user.assets.order("uploaded_file_file_name desc")        
    end 
  end
end
