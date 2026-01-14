require 'rails_helper'

RSpec.describe 'Post', type: :system do
  let(:user) { create(:user) }
  let!(:posts) { create_list(:post, 3, :with_image, user: user) }

  context 'ログインしている場合' do
    before do
      sign_in user
      visit root_path
    end

    it '投稿一覧が表示される' do
      expect(page).to have_css('.post.js-post', count: 3)

      posts.each do |post|
        within(".post.js-post[data-post-id='#{post.id}']") do
          expect(page).to have_css('.post_content', text: post.content)
          expect(page).to have_css('.post_author_upper', text: post.user.account)
          expect(page).to have_css("a[href='#{post_comments_path(post)}']")
        end
      end
    end

    it 'コメントページへ遷移する' do
      within(".post.js-post[data-post-id='#{posts.first.id}']") do
        find("a[href='#{post_comments_path(posts.first)}']").click
      end

      expect(page).to have_current_path(post_comments_path(posts.first))
    end
  end
end
