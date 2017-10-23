module ApplicationHelper
	def is_menu_active(path)
		current_page?(path) ? 'active' : 'unactive'
	end
	def login?
		!session[:user_id].nil?
	end
end
