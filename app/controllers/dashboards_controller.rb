class DashboardsController < ApplicationController
  def index 
    @user = User.all
  end
end
