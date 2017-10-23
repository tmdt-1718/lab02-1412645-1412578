class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def initialize
  	super()
  end
  def need_authorize
  	if session[:user_id].nil?
  		redirect_to session_index_path
  	end
  end
  def no_need_authorize
    if !session[:user_id].nil?
      redirect_to root_path
    end
  end
end
