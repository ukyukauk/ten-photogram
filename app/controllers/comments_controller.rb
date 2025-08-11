class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end

  def new
    post = Post.find(params[:post_id])
    @comment = post.comments.build
  end

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to post_comments_path(post), notice: 'コメントを投稿しました'
    else
      flash.now[:error] = 'コメントを投稿できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
