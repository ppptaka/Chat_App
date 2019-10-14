require 'rails_helper'

RSpec.describe 'User', type: :system do

  it 'ユーザー登録からユーザー編集まで' do
    visit root_path
    click_on 'Sign In'
    click_on 'Sign up'
      fill_in "First name",	with: "test"
      fill_in "Last name",	with: "test1"
      fill_in "Email",	with: "test@test"
      fill_in "Password",	with: "test1123" 
      fill_in "Password confirmation",	with: "test1123" 
      attach_file 'Image', "/Users/taka/Desktop/ruby/chat_App/app/assets/images/usa-4342505_960_720.jpg"
    click_on 'Sign up'
    visit root_path
    click_on 'My Account'
    click_on 'edit'
      fill_in "First name",	with: "newtest"
      fill_in "Password",	with: "test1123" 
      fill_in "Password confirmation",	with: "test1123" 
    click_on 'Update User'
    fill_in "Email",	with: "test@test"
    fill_in "Password",	with: "test1123"
    click_on 'Log in'
    expect(page).to have_content 'NEWTEST'
  end
end

