require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#show" do
    before do
      @user = FactoryBot.create(:user)
    end

    it "正常なレスポンスを返す" do
      sign_in @user
      get :show, params: {id: @user.id}
      expect(response).to be_success
    end

    it "200レスポンスを返す" do
      sign_in @user
      get :show, params: {id: @user.id}
      expect(response).to have_http_status "200"
    end

    context "ログインしない" do
			it "サインイン画面へリダイレクト" do
				get :show, params: {id: @user.id}
				expect(response).to redirect_to "/users/sign_in"
			end
    end
  end

  describe "#edit" do
    before do
      @user = FactoryBot.create(:user)
    end

    it "正常なレスポンスを返す" do
      sign_in @user
      get :edit, params: {id: @user.id}
      expect(response).to be_success
    end

    it "200レスポンスを返す" do
      sign_in @user
      get :edit, params: {id: @user.id}
      expect(response).to have_http_status "200"
    end
  end

  describe "#update" do
    before do
      @user = FactoryBot.create(:user)
    end
    
    it "正常なレスポンスを返す" do
      sign_in @user
      patch :update, params: {user: FactoryBot.attributes_for(:user)}
      expect(response).to have_http_status "302"
    end

    it '編集画面が表示されること' do
      sign_in @user
      patch :update, params: {user: FactoryBot.attributes_for(:user)}
      expect(response).not_to redirect_to "/users/update"
    end
  end
end
