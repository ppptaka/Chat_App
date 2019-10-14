require 'rails_helper'

RSpec.describe ChatRoomsController, type: :controller do

	describe "#index" do
		it "正常なレスポンスを返す" do
			get :index
			expect(response).to be_success
		end

		it "200レスポンスを返す" do
			get :index
			expect(response).to have_http_status "200"
		end
	end

	describe "#show" do
		before do
			@user = FactoryBot.create(:user)
			#id:10はテスト用に代入している
			@chat_room = ChatRoom.create(id: 10, title: "test",user_id: @user.id)
		end

		it "正常なレスポンスを返す" do
			sign_in @user
			get :show, params: {id: @chat_room.id}
			expect(response).to be_success
		end

		it "200レスポンスを返す" do
			sign_in @user
			get :show, params: {id: @chat_room.id}
			expect(response).to have_http_status "200"
		end

		context "ログインしない" do

			it "302レスポンスを返す" do
			get :show, params: {id: @chat_room}
			expect(response).to have_http_status "302"
			end

			it "サインイン画面へリダイレクト" do
				get :show, params: {id: @chat_room.id}
				expect(response).to redirect_to "/users/sign_in"
			end
		end	
	end

	describe "#create" do
		before do
			@user = FactoryBot.create(:user)
		end

		it "chatroomを追加できるか" do
			chat_room_params = FactoryBot.attributes_for(:chat_room)
			sign_in @user
			expect{post :create, params: {chat_room: chat_room_params}}.to change(@user.chat_rooms, :count).by(1)
		end

		it '作成画面へリダイレクト' do
			sign_in @user
			@chat_room = ChatRoom.create(id: 10, title: "" ,user_id: @user.id)
			expect(@chat_room.errors.added?(:title, :blank)).to be_truthy
		end

		context "ログインしない" do

			it "302レスポンスを返す" do
				chat_room_params = FactoryBot.attributes_for(:chat_room)
				post :create, params: {chat_room: chat_room_params}
				expect(response).to have_http_status "302"
			end

			it 'サインイン画面へリダイレクト' do
				chat_room_params = FactoryBot.attributes_for(:chat_room)
				post :create, params: {chat_room: chat_room_params}
				expect(response).to redirect_to "/users/sign_in"
			end
		end
	end

		describe "#destroy" do
			before do
				@user = FactoryBot.create(:user)
				@chatroom = FactoryBot.create(:chat_room)
			end

			it "chat_roomを削除できるか" do
				sign_in @user
				expect{delete :destroy, params:{id: @chatroom.id}}.to change(@user.chat_rooms, :count).by(-1)
			end

			it "自分のchatroomだけを削除できる" do
				sign_in @user 
				other_user = User.create(id:"2",first_name: "test3",last_name: "test4",email: "test@test2",password: "test4456",password_confirmation: "test4456")
				expect{delete :destroy,  params: {id: @chatroom.id}}.to_not change(other_user.chat_rooms, :count)
			end

			context "ログインしない" do

				it "302レスポンスを返す" do
					delete :destroy, params:{id: @chatroom.id}
					expect(response).to have_http_status "302"
				end

				it 'サインイン画面へリダイレクト' do
					delete :destroy, params:{id: @chatroom.id}
					expect(response).to redirect_to "/users/sign_in"
				end
			end
		end
end