require 'rails_helper'

feature 'message', type: :feature do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:user) { create(:user) }

  scenario 'post message' do
    # ログイン前には送信ボタンがない事を確認
    visit group_messages_path(group)
    expect(page).to have_no_content('Send')

    # ログイン処理
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    find('input[name="commit"]').click

    # ログインに成功したか確認
    expect(page).to have_content('ログインしました')
    expect(current_path).to eq group_messages_path(group)

    # Sendボタンがあるか確認
    expect(page).to have_button('Send')

    # Messageの投稿に成功するか確認
    expect {
      fill_in "form--text-input", with: "メッセージテスト"
      attach_file "form--file-select-icon__display", "#{Rails.root}/public/images/test_image.jpg"
      find('input[type="submit"]').click
    }.to change(Message, :count).by(1)
  end
end