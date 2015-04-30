class Circle < ActiveRecord::Base
  # has_many :post_circles
  has_many :posts
  has_many :friendships
  belongs_to :user
end
