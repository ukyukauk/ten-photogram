require 'rails_helper'

RSpec.describe 'Accounts', type: :request do
  let(:user) { create(:user) }
  let(:account) { create(:user) }

  describe 'GET /accounts' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '他人のページにアクセスしたら、200ステータスが返ってくる' do
        get account_path(account)

        expect(response).to have_http_status(200)
      end

      it '自分のページにアクセスしたら、profile_pathへリダイレクトする' do
        get account_path(user)

        expect(response).to redirect_to(profile_path)
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        get account_path(account)

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
