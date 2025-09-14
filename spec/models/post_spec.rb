# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  context '画像と内容が入力されている場合' do
    let(:post) { build(:post, :with_image, user: user) }

    it '有効である' do
      expect(post).to be_valid
    end
  end

  context '内容が入力されていない場合' do
    let(:post) { build(:post, :with_image, user: user, content: '') }

    it '無効である' do
      expect(post).not_to be_valid
      expect(post.errors[:content]).to include('を入力してください')
    end
  end

  context '画像が入力されていない場合' do
    let(:post) { build(:post, user: user) }

    it '無効である' do
      expect(post).not_to be_valid
      expect(post.errors[:images]).to include('を入力してください')
    end
  end
end
