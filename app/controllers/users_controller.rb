class UsersController < ApplicationController
	before_action :no_need_authorize, only: [:create]
	before_action :need_authorize, only: [:find, :friendship, :accept]
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
	def status(user_id)
		me = User.find(session[:user_id])
		if me.friends.exists?(user_id) 
	   		:friend
	   	elsif !me.friend_requests_send.where(sender_id: me.id, 
	   		receiver_id: user_id).take.nil?
	   		logger.info(me.friend_requests_send.where(sender_id: me.id, 
	   		receiver_id: user_id).take)
	   		:request
	   	elsif !me.friend_requests_receive.where(sender_id: user_id, 
	   		receiver_id: me.id).take.nil?
	   		:accept
	   	else
	   		:stranger
	   	end
	end
	def find
	  me = User.find(session[:user_id])
	  @users = User
	  .where("email like ?", "%" + params["user_email"] + "%").limit(10)
	  .collect{|r| {:id => r.id, :fullname => r.fullname,
	   :email=>r.email, :status => status(r.id)}}
	  respond_to do |format|
	    if !@users.nil?
	      format.html { redirect_to mails_path, notice: 'Comment được tạo thành công' }
          format.js
	      format.json { render json: users, status: :created, location: @users }
	    else
	      format.json { render json: users.errors, status: :unprocessable_entity }
	      format.html { redirect_to mails_path, notice: 'Comment được tạo thành công' }
	    end
	  end
	end
	def friendship
		me = User.find(session[:user_id])
		@friends = me.friends
		@newfriend_requests = me.friend_requests_receive
	end
	def accept
		accept_params = params.permit(:user_id, :request_id)
		me = User.find(session[:user_id])
		newfriend = User.find(accept_params[:user_id])
		friend_request = FriendRequest.find(accept_params[:request_id])
		# Add user to friendlist
		if (!me.friends.exists?(newfriend.id)) then
			me.friends.push(newfriend)
			newfriend.friends.push(me)
			friend_request.destroy
		end
		redirect_to users_friendship_path
	end
	def makefriend
		makefriend_params = params.permit(:user_id)
		me = User.find(session[:user_id])
		newfriend = User.find(makefriend_params[:user_id])
		if (FriendRequest.where(sender_id: me.id, receiver_id: newfriend.id).take.nil?)
			friend_request = FriendRequest.new
			friend_request.sender_id = me.id
			friend_request.receiver_id = newfriend.id
			friend_request.save!
		end
		redirect_to users_friendship_path
	end
	def unfriend
		unfriend_params = params.permit(:user_id)
		me = User.find(session[:user_id])
		myfriend = me.friends.find(unfriend_params[:user_id])
		if (!myfriend.nil?)
			me.friends.delete(myfriend)
		end
		redirect_to users_friendship_path
	end
	def undorequest
		undorequest_params = params.permit(:user_id)
		me = User.find(session[:user_id])
		delete_request = me.friend_requests_send.where(sender_id: me.id, 
			receiver_id: user_id).take
		if (!delete_request.nil?) then
			me.friend_request_send.delete(delete_request)
		end
		redirect_to users_friendship_path
	end
	def user_params
		params.require(:user).permit(:fullname, :email, :password)
	end
end
