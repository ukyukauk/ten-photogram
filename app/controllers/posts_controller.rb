class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all.order(id: 'DESC')
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path, notice: '投稿が完了しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def post_params
    params.require(:post).permit(:content, images: [])
  end
end
