class MailsController < ApplicationController
	before_action :need_authorize
	def index
		@mails = User.find(session[:user_id]).mails_receive.order("created_at DESC")
	end
end
