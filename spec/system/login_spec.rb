require 'rails_helper'

RSpec.describe 'Login', type: :system do
  let(:user) { create(:user) }

  it 'ログイン画面からログインできる' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'LOGIN'

    expect(page).to have_current_path(root_path)
  end
end
