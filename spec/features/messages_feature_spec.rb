require 'rails_helper'

feature 'message', type: :feature do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:user) { create(:user) }

  scenario 'post message' do
    # ログイン前には送信ボタンがない
    visit group_messages_path(group)
    expect(page).to have_no_content('Send')

    # ログイン処理
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    find('input[name="commit"]').click

    # Chat画面移動確認
    expect(page).to have_content('ログインしました')
    # ログインに成功したか
    expect(current_path).to eq group_messages_path(group)

    # Sendボタンがあるか
    expect(page).to have_button('Send')

    # Messageの投稿
    expect {
      fill_in "form--text-input", with: "メッセージテスト"
      attach_file "form--file-select-icon__display", "#{Rails.root}/public/images/test_image.jpg"
      find('input[type="submit"]').click
    }.to change(Message, :count).by(1)
  end
end