require 'rails_helper'

RSpec.describe 'Api::Likes', type: :request do
  let(:user) { create(:user) }
  let(:post_record) { create(:post, :with_image, user: user) }

  describe 'GET /api/posts/:post_id/like' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      context 'まだいいねしていない場合' do
        it 'いいね状態が返る' do
          get api_like_path(post_record), as: :json
          expect(response).to have_http_status(200)

          body = JSON.parse(response.body)
          expect(body).to include('hasLiked', 'likeText', 'likesCount')
        end
      end

      context 'すでにいいねしている場合' do
        let!(:like) { create(:like, post: post_record, user: user) }

        it 'hasLiked が true になる' do
          get api_like_path(post_record), as: :json
          body = JSON.parse(response.body)

          expect(body['hasLiked']).to be(true)
        end
      end
    end

    context 'ログインしていない場合' do
      it '401ステータスが返ってくる' do
        get api_like_path(post_record), as: :json
        expect(response).to have_http_status(401)
        body = JSON.parse(response.body)
        expect(body['error']).to be_present
      end
    end
  end

  describe 'POST /api/posts/:post_id/like' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it 'いいねが作成される' do
        post api_like_path(post_record), as: :json

        expect(response).to have_http_status(200)
        body = JSON.parse(response.body)
        expect(body['status']).to eq('ok')
        expect(body['likesCount']).to eq(1)
      end
    end

    context 'ログインしていない場合' do
      it '401ステータスが返ってくる' do
        post api_like_path(post_record), as: :json
        expect(response).to have_http_status(401)
        body = JSON.parse(response.body)
        expect(body['error']).to be_present
      end
    end
  end

  describe 'DELETE /api/posts/:post_id/like' do
    let!(:like) { create(:like, post: post_record, user: user) }

    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it 'いいねが削除される' do
        expect {
          delete api_like_path(post_record), as: :json
        }.to change(Like, :count).by(-1)

        expect(response).to have_http_status(200)

        body = JSON.parse(response.body)
        expect(body['status']).to eq('ok')
        expect(body['likesCount']).to eq(0)
      end
    end

    context 'ログインしていない場合' do
      it '401ステータスが返ってくる' do
        delete api_like_path(post_record), as: :json
        expect(response).to have_http_status(401)
        body = JSON.parse(response.body)
        expect(body['error']).to be_present
      end
    end
  end
end
