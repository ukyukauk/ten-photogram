require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, :with_image, user: user) }

  context '内容が入力されている場合' do
    let(:comment) { build(:comment, user: user, post: post) }

    it '有効である' do
      expect(comment).to be_valid
    end
  end

  context '内容が入力されていない場合' do
    let(:comment) { build(:comment, user: user, post: post, content: '') }

    it '無効である' do
      expect(comment).not_to be_valid
      expect(comment.errors[:content]).to include('を入力してください')
    end
  end
end
