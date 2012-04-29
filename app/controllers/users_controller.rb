class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		if @user.confirmed_at.nil?
			redirect_to root_path
		end
	end
end