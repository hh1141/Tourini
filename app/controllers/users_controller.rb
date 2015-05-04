class UsersController < ApplicationController
  before_action :find_user, only: [:show]
  before_action :authenticate_user!


  def index
    @user = current_user
    @post = Post.new
    @posts = current_user.friend_posts.all.order('created_at DESC').page(params[:page]).per(5)
    @circles = current_user.circles.all.order('circle_name')
    @ip = remote_ip()
  end 

  def search
    @nearby = params[:nearby].present?
    if params[:search].present?
      @users = User.search(params[:search],fields: [:email, :name], operator: "or")
      @posts = Post.search(params[:search],fields: [:text], page: params[:page], per_page: 15)
      if @nearby
        current_location = Location.create(ip_address: remote_ip())
        @locations = current_location.nearbys(params[:nearby])
        current_location.destroy
        @posts = []
        if !@locations.nil?
          @locations.each do |location|
            @posts << location.post
          end
        end 
        post_ids = @posts.map{|post| post.id}
        @posts = Post.search(params[:search], page: params[:page], per_page: 15, field: [:text], where: {id: post_ids})
      end 
    else 
      @users = User.all
      @posts = current_user.posts.all.order('created_at DESC').page(params[:page]).per(5)
      
    end 
    
  end 

  def show
    @posts = @user.posts.all.order("created_at DESC").page(params[:page]).per(5)
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
