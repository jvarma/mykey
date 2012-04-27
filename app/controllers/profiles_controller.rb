class ProfilesController < ApplicationController

	respond_to :html, :json
	
  def edit
  	@profile = Profile.find(params[:id])
  end

  def update
  	@profile = Profile.find(params[:id])
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
end
