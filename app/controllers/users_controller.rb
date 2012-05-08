class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@profile = @user.profile
		@profile ||= @user.create_profile
		if @user.confirmed_at.nil?
			redirect_to root_path
		end

		if current_user
			@shared_folders = SharedFolder.find_all_by_user_id_and_shared_user_id(@user, current_user)
			@folders = []
			@shared_folders.each do |shared_folder|
				folder = Folder.find_by_id(shared_folder.folder_id)
				@folders << folder if !folder.nil?
			end
		end

	end
end