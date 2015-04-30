class UsersController < ApplicationController
  before_action :find_user, only: [:show]
  before_action :authenticate_user!


  def index
    @user = current_user
    @post = Post.new
    @posts = current_user.friend_posts.all.order('created_at DESC')
  end 

  def search
    if params[:search].present?
      @users = User.search(params[:search],fields: [:email])
    else 
      @users = User.all
    end 
  end 

  def show
    @posts = @user.posts.all.order("created_at DESC")
    @isFriend = false
    @sentRequest = false

    current_user.friendships.all.each do |friendship|
      if friendship.friend == @user
        @friendship = friendship
      end 
    end

    current_user.inverse_friendships.all.each do |inverse_friendship|
      if inverse_friendship.user == @user
        @inverseFriendship = inverse_friendship
      end 
    end
  end 


  private

  def find_user
    @user = User.find(params[:id])
  end 

  # def my_timeline
  #   User.union([current_user.posts, current_user.friend_posts], distinct: true, order: 'created_at DESC', limit: 20)
  # end 
end
