module ApplicationHelper

	def full_title(page_title)
		if page_title.nil?
			"my key"
		else
			"my key | " + page_title
		end
	end

	def current_user_profile
		if user_signed_in?
			current_user.profile ||= Profile.new
		end
	end
	
end
