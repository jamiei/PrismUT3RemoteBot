
// RemObjects CS to Pascal 0.1

namespace UT3Bots.Communications;

interface
uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Text,
  System.Diagnostics;
type
  MessageEventArgs = assembly class(EventArgs)
  private
    var     _message: Message;
  assembly or protected
    constructor(Message: Message);
    property Message: Message read get_Message;
    method get_Message: Message;
  end;

  MessageHandler = assembly class
  private
    var     _connection: UT3Connection;
    var     _messageQueue: Queue<Message>;
    method _connection_OnErrorOccurred(sender: Object; e: TcpErrorEventArgs);
  assembly
    method Disconnect();
  private
    method ErrorOccurred(sender: Object; e: TcpErrorEventArgs);
    method DataReceived(sender: Object; e: TcpDataEventArgs);
  assembly
    //Constructor
    
    constructor(Server: String; Port: Integer);
    property Connection: UT3Connection read get_Connection;
    method get_Connection: UT3Connection;
    property MessageQueue: Queue<Message> read get_MessageQueue;
    method get_MessageQueue: Queue<Message>;
    event OnEventReceived: EventHandler<MessageEventArgs>;
  end;


implementation

constructor MessageEventArgs(Message: Message);
begin
  Self._message := Message
end;

method MessageEventArgs.get_Message: Message;
begin
  Result := Self._message
end;

method MessageHandler.Disconnect();
begin
  Self._connection.Disconnect()
end;

method MessageHandler.ErrorOccurred(sender: Object; e: TcpErrorEventArgs);
begin
  Self.Disconnect()
end;

method MessageHandler.DataReceived(sender: Object; e: TcpDataEventArgs);
begin
  var newMessages: List<Message> := Message.FromData(System.Text.UTF8Encoding.UTF8.GetString(e.Data, 0, e.Data.Length));
  locking Self._messageQueue do
  begin
    for each m: Message in newMessages do
    begin
      if (m.IsEvent and (Self.OnEventReceived <> nil)) then
      begin
        OnEventReceived.Invoke(Self, new MessageEventArgs(m))
      end
      else
      begin
        Self._messageQueue.Enqueue(m)
      end
    end
  end
end;

constructor MessageHandler(Server: String; Port: Integer);
begin
  Self._messageQueue := new Queue<Message>();
  Self._connection := new UT3Connection(Server, Port);
  Self._connection.OnDataReceived += @Self.DataReceived;
  Self._connection.OnErrorOccurred += @Self.ErrorOccurred;
  //Self._connection.OnDataReceived := Self._connection.OnDataReceived + new EventHandler<TcpDataEventArgs>(DataReceived);
  //Self._connection.OnErrorOccurred := Self._connection.OnErrorOccurred + new EventHandler<TcpErrorEventArgs>(ErrorOccurred)
end;

method MessageHandler.get_Connection: UT3Connection;
begin
  Result := Self._connection
end;

method MessageHandler.get_MessageQueue: Queue<Message>;
begin
  Result :=  Self._messageQueue
end;


method MessageHandler._connection_OnErrorOccurred(sender: Object; e: TcpErrorEventArgs);
begin
end;

end.
