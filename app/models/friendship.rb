class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  enum status: { pending: 0, requested: 1, accepted: 2, blocked: 3 }
end
