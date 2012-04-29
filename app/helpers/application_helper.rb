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

	def pretty_file_name(file_name)
		if file_name.length <= 15
			file_name.downcase
		else
			ext_array = file_name.split(".")
			ext = ext_array[ext_array.size - 1]
			file_name[0..14].downcase + "..." + ext
		end
	end
	
end
