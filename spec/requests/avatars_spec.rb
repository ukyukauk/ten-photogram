require 'rails_helper'

RSpec.describe 'Avatars', type: :request do
  let(:user) { create(:user) }

  describe "PATCH /avatar" do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '画像が更新され、プロフィール画面に遷移する' do
        file = fixture_file_upload(Rails.root.join('spec/fixtures/files/test_image.png'), 'image/png')
        patch profile_avatar_path, params: { user: { avatar: file } }

        expect(response).to redirect_to(profile_path)
        expect(flash[:notice]).to eq('プロフィール画像を変更しました')
        expect(user.avatar.filename.to_s).to eq('test_image.png')
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        file = fixture_file_upload(Rails.root.join('spec/fixtures/files/test_image.png'), 'image/png')
        patch profile_avatar_path, params: { user: { avatar: file } }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
