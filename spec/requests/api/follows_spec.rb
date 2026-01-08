require 'rails_helper'

RSpec.describe 'Api::Follows', type: :request do
  let(:user) { create(:user) }
  let(:account) { create(:user) }

  describe 'POST /api/accounts/:account_id/follows' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      context 'まだフォローしていない場合' do
        it 'フォローできる' do
          post api_follows_path(account), as: :json
          expect(response).to have_http_status(200)

          body = JSON.parse(response.body)
          expect(body).to include('followed', 'followers_count')
          expect(body['followed']).to be(true)
          expect(body['followers_count']).to eq(1)
        end

        it 'Relationshipが1件増える' do
          expect {
            post api_follows_path(account), as: :json
          }.to change { account.followers.count }.by(1)
        end
      end

      context 'すでにフォローしている場合' do
        before do
          user.follow!(account)
          account.reload
        end

        it 'Relationshipが増えない' do
          expect {
            post api_follows_path(account), as: :json
          }.not_to change { account.followers.count }
        end

        it 'followed: true が返る' do
          post api_follows_path(account), as: :json

          body = JSON.parse(response.body)
          expect(body['followed']).to be (true)
        end
      end
    end

    context 'ログインしていない場合' do
      it '401ステータスが返ってくる' do
        post api_follows_path(account), as: :json
        expect(response).to have_http_status(401)
        body = JSON.parse(response.body)
        expect(body['error']).to be_present
      end
    end
  end
end
