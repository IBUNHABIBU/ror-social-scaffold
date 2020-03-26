class DashboardsController < ApplicationController
  def index 
    @users = User.all
  end
end
