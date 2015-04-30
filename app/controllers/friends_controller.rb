class FriendsController < ApplicationController
  def index
    @friends = current_user.friends.all
    @circles = current_user.circles.all.order('circle_name')
    # @inverse_friends = current_user.inverse_friends.all
  end
end
