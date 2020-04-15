class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :user_reload, except: [:index]
  def index
    @friend = Friend.all
  end

  def new
    current_user.friend_request(@user)
  end

  def create
    current_user.accept_request(@user)
  end

  def destroy
    current_user.reject_request(@user)
  end

  private

  def user_reload
    current_user.reload
  end

  def set_user
    @user = User.find(params[:id])
  end
end
