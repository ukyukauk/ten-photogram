class UnfollowsController < ApplicationController
  before_action :authenticate_user!

  # def create
  #   current_user.unfollow!(params[:account_id])
  #   redirect_to account_path(params[:account_id])
  # end

    def create
    account = User.find(params[:account_id])
    current_user.unfollow!(account)
    account.reload
    render json: { followed: false, followers_count: account.followers.count }
  end
end
