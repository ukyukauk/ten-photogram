class FollowingsController < ApplicationController
  before_action :authenticate_user!

  def index
    account = User.find(params[:account_id])
    @following = account.followings
  end
end
