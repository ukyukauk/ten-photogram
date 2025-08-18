class ProfilesController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_user, only: [:show]

  def show
    @user = User.find(current_user.id)
  end

  def avatar_upload
    if current_user.update(avatar_params)
      redirect_to profile_path, notice: 'プロフィール画像を変更しました'
    else
      flash.now[:error] = '変更に失敗しました'
      render :show, status: :unprocessable_entity
    end
  end

  private
  def avatar_params
    params.require(:user).permit(:avatar)
  end

end
