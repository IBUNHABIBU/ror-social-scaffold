class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  enum status: { pending: 0, requested: 1, accepted: 2, blocked: 3 }
  # id: 1
  # friend: 2

  # user_id: 1, friend_id: 2, status: :requested
  # user_id: 2, friend_id: 1, status: :pending
end
