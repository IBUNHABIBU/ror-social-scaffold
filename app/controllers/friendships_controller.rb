class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def new
    current_user.friend_request(@user)
    current_user.reload
  end
  
  private 
  def set_user
    @user = User.find(params[:id])
  end
end
