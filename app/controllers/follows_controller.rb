class FollowsController < ApplicationController
  before_action :authenticate_user!

  # def create
  #   current_user.follow!(params[:account_id])
  #   redirect_to account_path(params[:account_id])
  # end

  def create
    account = User.find(params[:account_id])
    current_user.follow!(account)
    account.reload
    render json: { followed: true, followers_count: account.followers.count }
  end
end
