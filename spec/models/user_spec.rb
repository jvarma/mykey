require 'spec_helper'

describe User do

	before do
		@user = FactoryGirl.create(:user)
	end

	subject {
		@user
	}

	it {
		should respond_to(:profile)
	}
		
	describe "profile associations" do

		before {
			@user.save
		}

		let!(:user_profile) do
			FactoryGirl.create(:profile, user: @user)
		end

		it "should destroy associated profile" do
			profile = @user.profile
			@user.destroy
			Profile.find_by_id(profile.id).should be_nil
		end

	end
end