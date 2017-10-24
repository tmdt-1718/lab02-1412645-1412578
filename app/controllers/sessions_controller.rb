class SessionsController < ApplicationController
	before_action :no_need_authorize, only: [:login, :create, :register]
	before_action :need_authorize, only: [:destroy]
	def create
		begin
			user = User.find_by_email!(session_params[:email])
			if user.password==session_params[:password] then
				flash[:succeed] = "Đăng nhập thành công!"
				session[:user_id] = user.id
				session[:user_name] = user.fullname
				redirect_to root_path
				return
			else
				flash[:error] = "Sai mật khẩu!"
				redirect_to sessions_path
				return
			end
		rescue ActiveRecord::RecordNotFound => e
			flash[:error] = "Thư điện tử không tồn tại!"
			redirect_to sessions_path
		end
	end
	def destroy
		session.delete(:user_id)
		redirect_to root_path
	end
  def index
    render layout: "litten"
  end
	def session_params
		params.require(:session).permit(:email, :password)
	end
end
