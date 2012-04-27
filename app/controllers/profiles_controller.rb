class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user, only: [:edit, :update]
	
  def edit
  end

  def update
  	respond_to do |format|
    if @profile.update_attributes(params[:profile])
      	format.html { redirect_to(@profile, :notice => 'Profile was successfully updated.') }
      	format.json { respond_with_bip(@profile) }
    else
      	format.html { render :action => "edit", notice: 'profile could not be updated' }
      	format.json { respond_with_bip(@profile) }
    end
  end



  end

  def show
  	@profile = Profile.find(params[:id])
  	@user = @profile.user
  	if !@profile
  		@profile = Profile.new
      render :edit
  	end
  end

  private
    def correct_user
      @profile = Profile.find(params[:id])
      @user = @profile.user
      unless user_signed_in? && current_user == @user
        redirect_to root_path
      end
    end
end
