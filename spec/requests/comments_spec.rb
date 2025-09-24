require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:user) { create(:user) }
  let(:post_record) { create(:post, :with_image, user: user) }
  let(:comment) { create(:comment, user: user, post: post_record) }

  describe 'GET /comments' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '200ステータスが返ってくる' do
        get post_comments_path(post_record)

        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        get post_comments_path(post_record)

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST /comments' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it 'コメントが保存される' do
        comment_params = attributes_for(:comment)
        post post_comments_path(post_record), params: { comment: comment_params }

        expect(response).to have_http_status(200)
        expect(Comment.last.content).to eq(comment_params[:content])
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        comment_params = attributes_for(:comment)
        post post_comments_path(post_record), params: { comment: comment_params }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
