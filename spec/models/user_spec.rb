require 'rails_helper'

RSpec.describe User, type: :model do
  context 'アカウント名が一意の場合' do
    let(:user) { build(:user, account: 'unique_account') }

    it '有効である' do
      expect(user).to be_valid
    end
  end

  context 'アカウント名が重複している場合' do
    before { create(:user, account: 'duplicate_account')}
    let(:user) { build(:user, account: 'duplicate_account') }

    it '無効である' do
      expect(user).not_to be_valid
      expect(user.errors[:account]).to include('はすでに存在します')
    end
  end
end
