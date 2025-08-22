class FollowersController < ApplicationController
  before_action :authenticate_user!

  def index
    account = User.find(params[:account_id])
    @followers = account.followers
  end
end
