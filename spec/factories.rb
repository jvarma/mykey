FactoryGirl.define do
	factory :user do
		sequence(:name)	{ |n| "Test User _#{n}" }
		sequence(:email)	{ |n| "testuser_#{n}@example.com" }
		password	"foobar"
		password_confirmation	"foobar"
		confirmed_at	Time.now
	end

	factory :profile do
		about "a test profile description"
		user
	end
end