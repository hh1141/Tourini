class UsersController < ApplicationController
  before_action :find_user, only: [:show]
  before_action :authenticate_user!


  def index
    @user = current_user
    @post = Post.new

    # @posts_temp = current_user.friend_posts.all.order('created_at DESC')
    # @posts = []
    # @posts_temp.each do |post|
    #   if post.user == current_user || post.circle == nil || (!current_user.inverse_friendships.where(user_id: post.user).empty? && post.circle == current_user.inverse_friendships.where(user_id: post.user).first.circle)
    #     @posts << post
    #   end 
    # end
    # @posts = @posts.all.page(params[:page]).per(5)

    @posts = current_user.friend_posts.all.order('created_at DESC').page(params[:page]).per(10)
    @circles = current_user.circles.all.order('circle_name')
    @ip = remote_ip()
    # debugger
  end 

  def search
    @nearby = params[:nearby].present?
    @within = params[:within].present?
    if params[:search].present?
      @users = User.search(params[:search],fields: [:email, :name], operator: "or")
      if @within
        @posts = Post.search(params[:search],fields: [:text], where: {created_at: {gt: Time.now - params[:within].to_i*3600*24}}, page: params[:page], per_page: 15)
      else 
        @posts = Post.search(params[:search],fields: [:text], page: params[:page], per_page: 15)
      end 
      
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
        if @within
          @posts = Post.search(params[:search], page: params[:page], per_page: 15, field: [:text], where: {id: post_ids, created_at: {gt: (Time.now - params[:within].to_i*3600*24)}})
        else 
          @posts = Post.search(params[:search], page: params[:page], per_page: 15, field: [:text], where: {id: post_ids})
        end 
        # debugger
      end 
    else 
      @users = User.all
      @posts = current_user.posts.all.order('created_at DESC').page(params[:page]).per(5)
      
    end 
    # debugger
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
