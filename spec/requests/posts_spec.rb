require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { create(:user) }
  let!(:posts) { create_list(:post, 3, :with_image, user: user) }

  describe 'GET /posts' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '200ステータスが返ってくる' do
        get posts_path

        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        get posts_path

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST /posts' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '記事が保存される' do
        post_params = attributes_for(:post)
        file = fixture_file_upload(Rails.root.join('spec/fixtures/files/test_image.png'), 'image/png')

        post posts_path, params: {
          post: post_params.merge(images: [file])
        }

        expect(response).to have_http_status(302)
        expect(Post.last.content).to eq(post_params[:content])
        expect(Post.last.images.first.filename.to_s).to eq('test_image.png')
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        post_params = attributes_for(:post)
        file = fixture_file_upload(Rails.root.join('spec/fixtures/files/test_image.png'), 'image/png')

        post posts_path, params: {
          post: post_params.merge(images: [file])
        }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
