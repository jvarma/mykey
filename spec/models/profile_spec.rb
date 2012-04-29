require 'spec_helper'

describe Profile do

	let(:user) {
		FactoryGirl.create(:user)
	}

	before do
		@profile = user.build_profile(about: "profile description of a test user")
	end

	subject {
		@profile
	}

	it {
		should respond_to(:about)
	}

	it {
		should respond_to(:user_id)
	}

	it {
		should be_valid
	}

	it {
		should respond_to(:user)
	}

	its(:user) {
		should == user
	}

	describe "when user id is not present" do
		before {
			@profile.user_id = nil
		}

		it {
			should_not be_valid
		}
	end

	describe "accessible attributes" do
		it "should not allow access to user_id" do
			expect do
				Profile.new(user_id: user.id)
			end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

	describe "with content that is too long" do
		before {
			@profile.about = "a" * 201
		}

		it {
			should_not be_valid
		}
	end
end