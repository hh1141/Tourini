class User < ActiveRecord::Base
  extend UnionHack

  has_many :posts, dependent: :destroy

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_many :requests, foreign_key: "from_id"
  has_many :tos, through: :requests
  has_many :inverse_requests, class_name: "Request", foreign_key: "to_id"
  has_many :froms, through: :inverse_requests

  has_many :friend_posts, through: :friends, source: :posts

  searchkick

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def my_timeline
    User.union([posts, friend_posts], :distinct => true, :order => 'created_at DESC', :limit => 20)
  end 
end
