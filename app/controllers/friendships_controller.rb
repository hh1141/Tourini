class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    @inverseFriendship = current_user.inverse_friendships.build(user_id: params[:friend_id])
    @request = current_user.inverse_requests.find(params[:request_id])

    if @friendship.save && @inverseFriendship.save
      @request.destroy
      redirect_to requests_index_path
    end 

  end

  def destroy
    @friendship = current_user.friendships.find(params[:friendship_id])
    @inverseFriendship = current_user.inverse_friendships.find(params[:inverse_friendship_id])
    @inverseFriendship.destroy
    @friendship.destroy
    redirect_to root_path
    flash[:notice] = "Remove friend"
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end 

end
