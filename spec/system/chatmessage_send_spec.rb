require 'rails_helper'

RSpec.describe 'User', type: :system do

  it 'message送信まで' do
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
    click_on 'Create Chatroom'
    fill_in "Title",	with: "testtitle"
    click_on 'Save'
    click_on 'Enter'
      find(".textarea").set("message")
    click_on 'send'
    expect(page).to have_content "MESSAGE"
  end
end

