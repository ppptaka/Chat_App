Rails.application.routes.draw do
  root 'chat_rooms#index'
  get 'users/show/:id' => 'users#show'
  get 'users/edit'
  patch 'users/update'
  patch 'messages/destroy'
  devise_for :users
  resources :chat_rooms
end
