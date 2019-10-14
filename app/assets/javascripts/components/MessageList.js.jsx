class MessageList extends React.Component {
  render(){
    return <div className="chat-box">
      {this.messagesList()}
    </div>
  }
    messagesList(){
      const { messages } = this.props //this.props.messagesでChatRoomから渡された値にアクセス出来る
      return messages.map((message, index) =>
        <div className="chat-message-area" key={index}>
          <div className="chats_item_owner_text"> {message.full_name}  {message.written_at}  </div>   {/* serializerからメソッドを呼び出す */}
          {message.body}
          <br/>
          <a href={`/users/show/${message.id}`}><img src={message.image} className="icon_image" alt="NotImage" /></a>
        </div>
      );
    }
  }