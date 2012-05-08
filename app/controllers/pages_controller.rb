class PagesController < ApplicationController
  def home
  	@users = User.all
  	if user_signed_in?
      #show folders shared by others  
      @being_shared_folders = current_user.shared_folders_by_others    
      
      @assets = current_user.assets.where("folder_id is NULL").order("uploaded_file_file_name desc")
      
      @folders = current_user.folders.roots
      
      @current_folder = current_user.folders.find_by_id(params[:folder_id])       
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
  #first find the current folder within own folders  
  @current_folder = current_user.folders.find_by_id(params[:folder_id])    
  @is_this_folder_being_shared = false if @current_folder #just an instance variable to help hiding buttons on View  
    
  #if not found in own folders, find it in being_shared_folders  
  if @current_folder.nil?  
    folder = Folder.find_by_id(params[:folder_id])  
      
    @current_folder ||= folder if current_user.has_share_access?(folder)  
    @is_this_folder_being_shared = true if @current_folder #just an instance variable to help hiding buttons on View  
      
  end  
    
  if @current_folder  
    #if under a sub folder, we shouldn't see shared folders  
    @being_shared_folders = []  
      
    #show folders under this current folder  
    @folders = @current_folder.children  
      
    #show only files under this current folder  
    @assets = @current_folder.assets.order("uploaded_file_file_name desc")  
      
    render :action => "home"  
  else  
    flash[:error] = "Don't be cheeky! Mind your own assets!"  
    redirect_to root_url  
  end  
end  
  
  
  #this handles ajax request for inviting others to share folders  
  def share
        
    #a local variable to keep count of emails sent
    mails_sent = 0

    #get the current folder - the folder being shared
    @current_folder = current_user.folders.find_by_id(params[:folder_id])
    
    #separate the emails with the comma  
    email_addresses = params[:email_addresses].split(",")  
      
    email_addresses.each do |email_address|
      email_address = email_address.strip  
      if email_address =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

        #find if a SharedFolder record already exists for the current_folder and the email
        @shared_folder = SharedFolder.find_by_folder_id_and_shared_email(params[:folder_id], email_address)
        if @shared_folder.nil?
          #create a new record and save the details in the ShareFolder table  
          @shared_folder = current_user.shared_folders.new  
          @shared_folder.folder_id = params[:folder_id]
          @shared_folder.shared_email = email_address
        end
      
        #Find if a user with the email address exists
        shared_user = User.find_by_email(email_address)
      
        #if it already exists, update the shared_user_id  
        @shared_folder.shared_user_id = shared_user.id if shared_user  
    
        #update the message
        @shared_folder.message = params[:message]  
        
        @shared_folder.save  
    
        #now we need to send email to the Shared User  
        UserMailer.invitation_to_share(@shared_folder).deliver
        mails_sent += 1
      end
    end
    
    if (mails_sent >= 1)
      flash[:success] = "#{@current_folder.name.downcase} has been shared with #{mails_sent} user(s)"
    end
    #redirect the user back to the browse path for current folder - the folder that was shared
    redirect_to browse_path @current_folder
    
  end  
  
  
  
   
end
