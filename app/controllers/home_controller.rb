class HomeController < ApplicationController
	before_action :need_authorize, only: [:index]
  def index
  end
end
