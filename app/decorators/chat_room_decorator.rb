class ChatRoomDecorator < Draper::Decorator #Modelの情報を加工してViewに表示
  delegate_all

  def owner #index.htmlで表示している
    object.user.first_name + " " + object.user.last_name
  end
  
  def created_at　#index.htmlで表示している
    object.created_at.strftime("%Y/%m/%d")
  end
end
