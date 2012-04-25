module ApplicationHelper

	def full_title(page_title)
		if page_title.nil?
			"my key"
		else
			"my key | " + page_title
		end
	end
	
end
