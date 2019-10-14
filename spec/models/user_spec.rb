require 'rails_helper'

RSpec.describe User, type: :model do
  it "全ての項目が埋まっていれば有効" do
		expect(FactoryBot.build(:user)).to be_valid
  end

	it "名がなければ無効" do
		user = FactoryBot.build(:user, first_name: nil)
		user.valid?
		expect(user.errors.added?(:first_name, :blank)).to be_truthy
	end
	

  it "姓がなければ無効" do
		user = FactoryBot.build(:user, last_name: nil)
		user.valid?
		expect(user.errors.added?(:last_name, :blank)).to be_truthy
	end
	

  it "メールアドレスがなければ無効" do
		user = FactoryBot.build(:user, email: nil)
		user.valid?
		expect(user.errors.added?(:email, :blank)).to be_truthy
	end

  it "メールアドレスが重複していたら無効" do
		FactoryBot.create(:user)
		user = FactoryBot.build(:user)
		user.valid?
		expect(user.errors[:email]).to include("has already been taken")
	end
end
