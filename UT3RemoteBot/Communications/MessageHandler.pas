
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
    constructor MessageEventArgs(Message: Message);
    property Message: Message read get_Message;
    method get_Message: Message;
  end;

  MessageHandler = internal class
  private
    var     _connection: UT3Connection;
    var     _messageQueue: Queue<Message>;
  assembly
    method Disconnect();
  private
    method ErrorOccurred(sender: Object; e: TcpErrorEventArgs);
    method DataReceived(sender: Object; e: TcpDataEventArgs);
  assembly
    //Constructor
    
    constructor MessageHandler(Server: String; Port: Integer);
    property Connection: UT3Connection read get_Connection;
    method get_Connection: UT3Connection;
    property MessageQueue: Queue<Message> read get_MessageQueue;
    method get_MessageQueue: Queue<Message>;
    event OnEventReceived: EventHandler<MessageEventArgs>;
  end;


implementation

constructor MessageEventArgs.MessageEventArgs(Message: Message);
begin
  this._message := Message
end;

method MessageEventArgs.get_Message: Message;
begin
  exit this._message
end;

method MessageHandler.Disconnect();
begin
  this._connection.Disconnect()
end;

method MessageHandler.ErrorOccurred(sender: Object; e: TcpErrorEventArgs);
begin
  this.Disconnect()
end;

method MessageHandler.DataReceived(sender: Object; e: TcpDataEventArgs);
begin
  var newMessages: List<Message> := Message.FromData(System.Text.UTF8Encoding.UTF8.GetString(e.Data, 0, e.Data.Length));
  locking this._messageQueuedo
  begin
    for each m: Message in newMessages do
    begin
      if m.IsEvent and this.OnEventReceived <> nil then
      begin
        OnEventReceived.Invoke(this, new MessageEventArgs(m))
      end
      else
      begin
        this._messageQueue.Enqueue(m)
      end
    end
  end
end;

constructor MessageHandler.MessageHandler(Server: String; Port: Integer);
begin
  this._messageQueue := new Queue<Message>();
  this._connection := new UT3Connection(Server, Port);
  this._connection.OnDataReceived := this._connection.OnDataReceived + new EventHandler<TcpDataEventArgs>(DataReceived);
  this._connection.OnErrorOccurred := this._connection.OnErrorOccurred + new EventHandler<TcpErrorEventArgs>(ErrorOccurred)
end;

method MessageHandler.get_Connection: UT3Connection;
begin
  exit this._connection
end;

method MessageHandler.get_MessageQueue: Queue<Message>;
begin
  exit this._messageQueue
end;


end.
