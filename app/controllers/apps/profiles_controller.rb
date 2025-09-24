class Apps::ProfilesController < Apps::ApplicationController

  def show
    @user = User.find(current_user.id)
    @posts = @user.posts.order(created_at: :desc)
  end

end
