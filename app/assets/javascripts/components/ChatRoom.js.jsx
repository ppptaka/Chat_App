class ChatRoom extends React.Component {
  constructor(props) {
    super(props);
    this.textInput = React.createRef();
    this.state = {
      messages: props.chat_room.messages,
      errors: []
    };
  }
  
  newMessage(message){
    const { messages } = this.state;
    const msgs = messages;
    if(msgs.length >= 75) {
      msgs.shift();
    }
    msgs.push(message);
    this.setState({messages: msgs, errors: []});
  }

  postMessage(event) {
    {/*画面の遷移を行わないようにする */}
    event.preventDefault()
    App.chatChannel.perform("send_message", { chat_room_id: this.props.chat_room.id, body: this.textInput.current.value }); {/*chat_room_channleを呼び出している*/}
    this.textInput.current.value = ""; {/*送信後入力フォームを空にしている*/}
  }

  addErrors(errors){
    this.setState({errors: errors});
  }

  //ページを離れる時に実行
  componentWillUnmount(){ 
    App.chatChannel.unsubscribe() 
  }

  componentDidMount() {
    App.chatChannel = App.cable.subscriptions.create({
      channel: "ChatRoomsChannel",
      chat_room_id: this.props.chat_room.id,
    },
      {
        connected: () => { console.log('connectied')},
       disconnected: () => {console.log('desconnected')},
      received: ({type, data}) => {
        switch (type) {
          case 'new_message':
            this.newMessage(data);
            break;
          case 'errors':
            this.addErrors(data);
            break;
          default:
            console.error({type, data});
        }
      }
    });
  }

  errorMessages(){
    const {errors} = this.state
    if (errors.length) {
      return errors.map((error, index) => <div key={index}> {error} </div>)
    }
  }

  form(){
    return (
      <div className="form-groups">
        {this.errorMessages()}
        <form onSubmit={ this.postMessage.bind(this) }>  {/*bind(this)を書くと呼び出した先のthisが呼び出し先自身になる */}
          <div>
            <textarea ref={this.textInput}  rows="8" cols="60" maxLength="50" withe="50px" className="textarea"/>
          </div>
            <button type="submit" className="send_botton">send</button>
        </form>
      </div>
    )
  }

  render() {
    const { messages } = this.state;
    return (
      <div className="chat_all">
        <div>
          {this.form()}
        </div>
        <MessageList messages={ messages } />
      </div> 
    )
  }
}