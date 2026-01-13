require 'rails_helper'

RSpec.describe 'Logout', type: :system do
  let(:user) { create(:user) }

  it 'ログアウトできる', js:true do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'LOGIN'

    # ドロップダウンを開かずに、非表示のリンクを直接押す
    logout_link = find("a[href='#{destroy_user_session_path}']", visible: :all)
    logout_link.execute_script('this.click()')

    expect(page).to have_current_path(new_user_session_path)

  end
end
