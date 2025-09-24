class Api::UnfollowsController < Api::ApplicationController
  before_action :authenticate_user!

    def create
    account = User.find(params[:account_id])
    current_user.unfollow!(account)
    account.reload
    render json: { followed: false, followers_count: account.followers.count }
  end
end
