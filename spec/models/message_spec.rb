require 'rails_helper'

RSpec.describe Message, type: :model do

    it "全ての項目が埋まっていれば有効" do
      @user = FactoryBot.create(:user)
      @chatroom = ChatRoom.create(id: 10, title: "test" ,user_id: @user.id)
      message = FactoryBot.build(:message, user_id: @user.id, chat_room_id: @chatroom.id)
		  message.valid?
      expect(FactoryBot.build(:message)).to be_valid
    end

  it "本文がなければ無効" do
		message = FactoryBot.build(:message, body: nil)
		message.valid?
		expect(message.errors.added?(:body, :blank)).to be_truthy
  end

  it "本文が一文字だと無効" do
		message = FactoryBot.build(:message, body: "a")
		message.valid?
		expect(message).not_to be_valid
  end
end

