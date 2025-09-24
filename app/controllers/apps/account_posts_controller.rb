class Apps::AccountPostsController < Apps::ApplicationController

  def index
    @posts = Post.where(user_id: params[:account_id]).order(created_at: :desc)
  end
end
