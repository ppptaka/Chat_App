require 'rails_helper'

RSpec.describe 'User', type: :system do

  it 'ログイン画面移行' do
    visit root_path
    click_on 'Sign In'
      fill_in "Email",	with: "test@test"
      fill_in "Password",	with: "test1123"
      click_on 'Log in'
      visit root_path
    expect(current_path).to eq root_path
  end
end