class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    # フォローしているユーザの投稿
    user_ids = current_user.followings.pluck(:id)
    following_posts = Post.where(user_id: user_ids).pluck(:id)

    # 24時間以内に作成された投稿の中で「いいね」が多い投稿を5つ
    hot_posts = Post
      .where('posts.created_at >= ?', 24.hours.ago)
      .left_outer_joins(:likes)
      .group('posts.id')
      .order(Arel.sql('COUNT(likes.id) DESC, posts.created_at DESC'))
      .limit(5)
      .pluck(:id)

    # IDを統合 → 重複排除 → 新着順で取得（N+1対策つき）
    ids = (following_posts + hot_posts).uniq
    @posts = Post
      .where(id: ids)
      .order(created_at: :desc)
      .includes(:user, images_attachments: :blob)
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
