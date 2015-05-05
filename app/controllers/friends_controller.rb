class FriendsController < ApplicationController
  before_action :authenticate_user!
  def index
    @friends = current_user.friends.all.page(params[:page]).per(4)
    @circles = current_user.circles.all.order('circle_name')
    # @inverse_friends = current_user.inverse_friends.all
  end
end
