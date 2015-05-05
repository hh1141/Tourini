class RequestsController < ApplicationController
  before_action :authenticate_user!
  def index
    @requests = current_user.inverse_requests.all
  end 

  def create
    @request = current_user.requests.build(:to_id => params[:to_id])

    @request.save
    redirect_to User.find(params[:to_id])
  end 

  def destroy
    @request = current_user.inverse_requests.find(params[:request_id])
    @request.destroy

    redirect_to requests_index_path
  end 
end
