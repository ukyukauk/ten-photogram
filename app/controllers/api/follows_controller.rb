class Api::FollowsController < Api::ApplicationController
  before_action :authenticate_user!

  def create
    account = User.find(params[:account_id])
    current_user.follow!(account)
    account.reload
    render json: { followed: true, followers_count: account.followers.count }
  end
end
