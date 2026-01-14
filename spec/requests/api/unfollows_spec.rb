require 'rails_helper'

RSpec.describe 'Api::Unfollows', type: :request do
  let(:user) { create(:user) }
  let(:account) { create(:user) }

  describe 'POST /api/accounts/:account_id/unfollows' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      context 'すでにフォローしている場合' do
        before do
          user.follow!(account)
          account.reload
        end

        it 'フォロー解除できる' do
          post api_unfollows_path(account), as: :json
          expect(response).to have_http_status(200)

          body = JSON.parse(response.body)
          expect(body).to include('followed', 'followers_count')
          expect(body['followed']).to be(false)
          expect(body['followers_count']).to eq(0)
        end

        it 'Relationshipが1件減る' do
          expect {
            post api_unfollows_path(account), as: :json
          }.to change { account.followers.count }.by(-1)
        end
      end

      context 'まだフォローしていない場合' do
        it 'Relationshipが減らない' do
          expect {
            post api_unfollows_path(account), as: :json
          }.not_to change { account.followers.count }
        end

        it 'followed: false が返る' do
          post api_unfollows_path(account), as: :json
          expect(response).to have_http_status(200)

          body = JSON.parse(response.body)
          expect(body['followed']).to be(false)
        end
      end
    end

    context 'ログインしていない場合' do
      it '401ステータスが返ってくる' do
        post api_unfollows_path(account), as: :json
        expect(response).to have_http_status(401)
        body = JSON.parse(response.body)
        expect(body['error']).to be_present
      end
    end
  end
end
