class AccountPostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.where(user_id: params[:account_id]).order(created_at: :desc)
  end
end
