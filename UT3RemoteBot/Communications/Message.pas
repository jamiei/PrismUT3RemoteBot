
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
  Message = public class(EventArgs)
    const     MESSAGE_SEPARATOR: Char = '|';
    const     MESSAGE_SUBSEPARATOR: Char = ',';
    const     MESSAGE_EOL: Char = '@';
  private
    class var     MESSAGE_EOM: array of String := ([#10#13]); readonly;
    var     _event: EventMessage;
    var     _info: InfoMessage := InfoMessage.None;
    var     _args: array of String;
  assembly
    //Trace.WriteLine(String.Format("UT3RemoteBot.Message.ctor: parsing string {0}.", message), Global.TRACE_NORMAL_CATEGORY);
    //Add the extra info
    
    class method FromData(Data: String): List<Message>;
    class method BuildMessage(Command: CommandMessage; params Args: array of String): String;
    constructor(message: String);
    property &Event: EventMessage read get_Event;
    method get_Event: EventMessage;
    property Info: InfoMessage read get_Info;
    method get_Info: InfoMessage;
    property Arguments: array of String read get_Arguments;
    method get_Arguments: array of String;
    property IsEvent: Boolean read get_IsEvent;
    method get_IsEvent: Boolean;
  end;


implementation

class method Message.FromData(Data: String): List<Message>;
begin
  var messages: List<Message> := new List<Message>();
  var lines: array of String := Data.Split(MESSAGE_EOM, StringSplitOptions.None);
  for each line: String in lines do
  begin
    messages.&Add(new Message(line));
  end;
  exit messages;
end;

class method Message.BuildMessage(Command: CommandMessage; params Args: array of String): String;
begin
  var sb: StringBuilder := new StringBuilder();
  sb.Append(Command.GetStringValue());
  for each arg: String in Args do
  begin
    sb.Append(MESSAGE_SEPARATOR);
    sb.Append(arg);
  end;
  exit sb.ToString();
end;

constructor Message(message: String);
begin
  if ((message <> '') and message.EndsWith('EOM')) then
  begin
    message := message.&Remove(message.Length - 3, 3);
    var tokens: List<String> := new List<String>(message.Split(MESSAGE_SEPARATOR));
    if tokens.Count > 2 then
    begin
      _event := tokens[0].GetAsEvent();
      tokens.RemoveAt(0);
      if _event = EventMessage.STATE then
      begin
        _info := tokens[0].GetAsInfo();
        tokens.RemoveAt(0)
      end;
      if tokens[tokens.Count - 1] = #10#13 then
      begin
        tokens.RemoveAt(tokens.Count - 1)
      end;
      _args := tokens.ToArray();
    end;
  end;
end;

method Message.get_Event: EventMessage;
begin
  Result := _event;
end;

method Message.get_Info: InfoMessage;
begin
  Result := _info;
end;

method Message.get_Arguments: array of String;
begin
  Result := _args;
end;

method Message.get_IsEvent: Boolean;
begin
  Result := (Self._event <> EventMessage.STATE);
end;


end.
