class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(current_user.id)
    @posts = @user.posts.order(created_at: :desc)
  end

end
