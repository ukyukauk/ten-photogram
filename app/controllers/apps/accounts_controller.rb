class Apps::AccountsController < Apps::ApplicationController

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
    if @user == current_user
      redirect_to profile_path
    end
  end
end
