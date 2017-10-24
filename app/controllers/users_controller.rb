class UsersController < ApplicationController
	before_action :no_need_authorize, only: [:create]
	def create
		begin
			if (!User.exists?(email: user_params[:email]));				
				new_user = User.new(user_params)
			    new_user.password = user_params[:password]
			    new_user.save!
				redirect_to sessions_path
			else
				flash[:error]="Tài khoản #{user_params[:email]} đăng ký đã tồn tại!"
				redirect_to users_path
			end
		rescue ActiveRecord::RecordNotSaved
			flash[:error]="Đã xảy ra lỗi trong quá trình đăng ký!"
			redirect_to users_path
		end
	end
	def index
		render layout: "litten"
	end
	def user_params
		params.require(:user).permit(:fullname, :email, :password)
	end
end
