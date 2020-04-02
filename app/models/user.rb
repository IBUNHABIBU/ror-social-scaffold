class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :friends, -> { where friendships: { status: :accepted } }, through: :friendships
  has_many :requested_friends, -> { where friendships: { status: :requested } }, through: :friendships, source: :friend
  has_many :pending_friends, -> { where friendships: { status: :pending } }, through: :friendships, source: :friend
  has_many :blocked_friends, -> { where friendships: { status: :blocked } }, through: :friendships, source: :friend

  
  def has_friendship?(friend)
    return true if self == friend

    friendships.map(&:friend_id).include?(friend.id)
  end

  def requested_friends_with?(friend)
    return false if self == friend

    requested_friends.map(&:id).include?(friend.id)
  end

  def pending_friends_with?(friend)
    return false if self == friend

    pending_friends.map(&:id).include?(friend.id)
  end

  def friends_with?(friend)
    return false if self == friend

    friends.map(&:id).include?(friend.id)
  end

  def friend_request(friend)
    return if self == friend || Friendship.where(user: self, friend: friend).exists?

    transaction do
      Friendship.create(user: self, friend: friend, status: :pending)
      Friendship.create(user: friend, friend: self, status: :requested)
    end
  end

  # jane.accept_request(john)
  # john.accept_request(jane) ! bad
  def accept_request(friend)
    transaction do
      Friendship.find_by(user: self, friend: friend, status: [:requested])&.accepted!
      Friendship.find_by(user: friend, friend: self, status: [:pending])&.accepted!
    end
  end

  def reject_request(friend)
    transaction do
      Friendship.find_by(user: self, friend: friend)&.destroy!
      Friendship.find_by(user: friend, friend: self)&.destroy!
    end
  end
end
