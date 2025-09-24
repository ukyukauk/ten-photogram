class Apps::FollowingsController < Apps::ApplicationController

  def index
    account = User.find(params[:account_id])
    @following = account.followings
  end
end
