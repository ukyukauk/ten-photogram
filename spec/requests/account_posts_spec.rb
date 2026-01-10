require 'rails_helper'

RSpec.describe 'AccountPosts', type: :request do
  let(:user) { create(:user) }
  let(:account) { create(:user) }
  let!(:posts) { create_list(:post, 3, :with_image, user: account) }

  describe 'GET /accounts/:account_id/account_posts' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '200ステータスが返ってくる' do
        get account_account_posts_path(account)

        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        get account_account_posts_path(account)

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
