class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  has_many :friendships
  has_many :friends, -> { where friendships: { status: :accepted }}, through: :friendships
  has_many :requested_friends, -> { where friendships: { status: :requested }}, through: :friendships, source: :friend
  has_many :pending_friends, -> { where friendships: { status: :pending }}, through: :friendships, source: :friend
  has_many :blocked_friends, -> { where friendships: { status: :blocked }}, through: :friendships, source: :friend
end
