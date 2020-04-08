class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  def index 
    @friend = Friend.all
  end

  def new
    current_user.friend_request(@user)
      current_user.reload
  end

  def create
    current_user.accept_request(@user)
    current_user.reload
  end

  def destroy
    current_user.reject_request(@user)
    current_user.reload
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
