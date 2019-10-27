class ChatRoomsSerializer < ActiveModel::Serializer
  attributes :id, :title #メソッドに指定した値だけをレスポンス

  has_many :messages, serializer: MessagesSerializer
  
end