
// RemObjects CS to Pascal 0.1

namespace UT3Bots.Communications;

interface
uses
  System,
  System.IO,
  System.Net.Sockets,
  System.Text,
  System.Diagnostics;
type
  UT3Connection = public class
  private
    var     _tcpClient: TcpClient;
    var     _streamReader: StreamReader;
    var     _streamWriter: StreamWriter;
    var     _networkStream: NetworkStream;
    var     _server: String;
    var     _port: Integer;
  assembly
    method Connect(): Boolean;
  private
    //throw;
    
    method Listen();
  assembly
    method HandleRead(ar: IAsyncResult);
      method OnData(args: TcpDataEventArgs);
    method OnError(args: TcpErrorEventArgs);
  assembly
    method Disconnect();
    method ReadLine(): String;
    method SendLine(Message: String);
    constructor(server: String; port: Integer);
    property IsConnected: Boolean read get_IsConnected;
    method get_IsConnected: Boolean;
    event OnDataReceived: EventHandler<TcpDataEventArgs>;
    event OnErrorOccurred: EventHandler<TcpErrorEventArgs>;
  end;

  SocketState = class
  assembly or protected
    var     data: array of Byte := new Byte[300];
    var     stream: NetworkStream;
  end;

  TcpDataEventArgs = public class(EventArgs)
  private
    var     _data: array of Byte;
  assembly or protected
    constructor(Data: array of Byte);
    property Data: array of Byte read get_Data;
    method get_Data: array of Byte;
  end;

  TcpErrorEventArgs = public class(EventArgs)
  private
    var     _error: Exception;
  assembly or protected
    constructor (Error: Exception);
    property Error: Exception read get_Error;
    method get_Error: Exception;
  end;


implementation

method UT3Connection.Connect(): Boolean;
begin
  if IsConnected then
  begin
    Trace.WriteLine('Already Connected - Disconnect First', &Global.TRACE_ERROR_CATEGORY);
    exit false
  end;

  try
    Self._tcpClient := new TcpClient(Self._server, Self._port);
    _networkStream := Self._tcpClient.GetStream();
    Self._streamReader := new StreamReader(new StreamReader(_networkStream).BaseStream, System.Text.Encoding.ASCII);
    Self._streamWriter := new StreamWriter(new StreamWriter(_networkStream).BaseStream, System.Text.Encoding.ASCII);
    Listen();
  except
    on ex: Exception do
    begin
      Trace.WriteLine(String.Format('The Connection Could Not Be Established: {0}.', ex.Message), &Global.TRACE_ERROR_CATEGORY);
      if (Self._streamReader <> nil) then
      begin
        Self._streamReader.Close()
      end;
      if (Self._streamWriter <> nil) then
      begin
        Self._streamWriter.Close()
      end;
    end;
  end;
  exit ((Self._streamReader <> nil) and (Self._streamWriter <> nil));
end;

method UT3Connection.Listen();
begin
  var state: SocketState := new SocketState();
  state.stream := _networkStream;
  var ar: IAsyncResult := _networkStream.BeginRead(state.data, 0, state.data.Length, @HandleRead, state)
end;

method UT3Connection.HandleRead(ar: IAsyncResult);
begin
  var state: SocketState := SocketState(ar.AsyncState);
  var stream: NetworkStream := state.stream;
  var r: Integer;
  if not stream.CanRead then
  begin
    exit
  end
  else
  begin
  end;
try
        r := stream.EndRead(ar)

  except
    on ex: Exception do
    begin
      OnError(new TcpErrorEventArgs(ex));
      Trace.WriteLine(String.Format('TCP Connection Error: {0}.', ex.Message), &Global.TRACE_NORMAL_CATEGORY);
      Disconnect();
      exit
    end
end;
  var rdata: array of Byte := new Byte[r];
  Buffer.BlockCopy(state.data, 0, rdata, 0, r);
  OnData(new TcpDataEventArgs(rdata));
try
  Listen();

  except
    on ex: Exception do
    begin
      OnError(new TcpErrorEventArgs(ex))
    end
end
end;

method UT3Connection.OnData(args: TcpDataEventArgs);
begin
  var temp: EventHandler<TcpDataEventArgs> := OnDataReceived;
  if (temp <> nil) then
  begin
    temp(Self, args)
  end;
end;

method UT3Connection.OnError(args: TcpErrorEventArgs);
begin
  var temp: EventHandler<TcpErrorEventArgs> := OnErrorOccurred;
  if temp <> nil then
  begin
    temp(Self, args)
  end;
end;

method UT3Connection.Disconnect();
begin
  if Self._tcpClient.Client.Connected then
  begin
    Self._tcpClient.Client.Disconnect(false);
    Self._tcpClient.Client.Close();
    Self._tcpClient.Close()
  end;
  Self._streamReader.Close()
end;

method UT3Connection.ReadLine(): String;
begin
  if Self._streamReader <> nil then
  begin
    var line: String := Self._streamReader.ReadLine();
    Trace.WriteLine(String.Format('Received Server Line: {0}.', line), &Global.TRACE_NORMAL_CATEGORY);
    exit line
  end
  else
  begin
    Trace.WriteLine('Error reading from connection!', &Global.TRACE_ERROR_CATEGORY);
    exit ''
  end
end;

method UT3Connection.SendLine(Message: String);
begin
  if Self._streamWriter <> nil then
  begin
    Trace.WriteLine(String.Format('Sending Server Line: {0}.', Message), &Global.TRACE_NORMAL_CATEGORY);
    Self._streamWriter.WriteLine(Message);
    Self._streamWriter.Flush()
  end
  else
  begin
    Trace.WriteLine('Error writing to connection!', &Global.TRACE_ERROR_CATEGORY)
  end;
end;

constructor UT3Connection(server: String; port: Integer);
begin
  Self._server := server;
  Self._port := port;
  Connect();
end;

method UT3Connection.get_IsConnected: Boolean;
begin
  Result := ((Self._tcpClient <> nil) and (Self._tcpClient.Connected));
end;

constructor TcpDataEventArgs(Data: array of Byte);
begin
  Self._data := Data;
end;

method TcpDataEventArgs.get_Data: array of Byte;
begin
  Result := Self._data;
end;

constructor TcpErrorEventArgs(Error: Exception);
begin
  Self._error := Error
end;

method TcpErrorEventArgs.get_Error: Exception;
begin
  Result := Self._error
end;


end.
