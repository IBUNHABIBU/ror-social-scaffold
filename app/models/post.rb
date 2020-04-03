class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 1000,
                                                too_long: '1000 characters in post is the maximum allowed.' }

  belongs_to :user

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  
  scope :friends_posts, -> (current_user) { where('user_id IN (?) OR user_id = ?',
                                            current_user.friend_ids, current_user.id)
                                            .order(:created_at) }
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
end
