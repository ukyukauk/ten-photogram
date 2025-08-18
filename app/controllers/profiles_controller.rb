class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def show
  end

  def avatar_upload
    unless current_user == @user
      redirect_to profile_path, notice: '権限がありません' and return
    end

    @user = current_user
    if @user.update(avatar_params)
      redirect_to profile_path, notice: 'プロフィール画像を変更しました'
    else
      flash.now[:error] = '変更に失敗しました'
      render :show, status: :unprocessable_entity
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def avatar_params
    params.require(:user).permit(:avatar)
  end

end
