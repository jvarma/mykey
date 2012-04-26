class PagesController < ApplicationController
  def home
  	@users = User.all
  	if user_signed_in?  
      @assets = current_user.assets.order("uploaded_file_file_name desc")        
    end 
  end

  def about
  	@title = "about us"
  end

  def tou
  	@title = "terms of use"
  end

  def contact
  	@title = "contact us"
  end

  def help
  	@title = "help"
  end
end
