require 'rails_helper'

RSpec.describe 'Authorization', type: :system do

  it '未ログインで root にアクセスすると、ログイン画面にリダイレクトされる' do
    visit root_path

    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_css('.flash', text: 'ログインしてください')
  end
end
