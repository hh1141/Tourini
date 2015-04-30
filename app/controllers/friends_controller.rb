class FriendsController < ApplicationController
  def index
    @friends = current_user.friends.all
    # @inverse_friends = current_user.inverse_friends.all
  end
end
