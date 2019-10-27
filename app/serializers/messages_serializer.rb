class MessagesSerializer < ActiveModel::Serializer
  attributes :id, :body, :written_at, :user, :full_name, :image #メソッドに指定した値だけをレスポンス

 def id
   object.user.id
 end

  def written_at
    object.created_at.strftime('%H:%M:%S %d %B %Y')
  end

  def full_name
    object.user.first_name + " " + object.user.last_name
  end

  def image
    object.user.image.url
  end
  
end