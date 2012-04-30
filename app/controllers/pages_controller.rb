class PagesController < ApplicationController
  def home
  	@users = User.all
  	if user_signed_in?  
      @assets = current_user.assets.where("folder_id is NULL").order("uploaded_file_file_name desc")
      @folders = current_user.folders.roots        
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

  def browse
    @users = User.all  
    #get the folders owned/created by the current_user  
    @current_folder = current_user.folders.find(params[:folder_id])    
  
    if @current_folder  
    
      #getting the folders which are inside this @current_folder  
      @folders = @current_folder.children  
  
      #We need to fix this to show files under a specific folder if we are viewing that folder  
      @assets = @current_folder.assets.order("uploaded_file_file_name desc")  
  
      render :home  
    else  
      flash[:error] = "Don't be cheeky! Mind your own folders!"  
      redirect_to root_url  
    end  
end 
end
