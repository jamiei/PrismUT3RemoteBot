
// RemObjects CS to Pascal 0.1

namespace UT3Bots.UTItems;

interface
uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Text,
  UT3Bots.Communications;
type
  UTBotOppState = public class(UTBotState)
  private
    //Opponent state variables
    
    var     _isReachable: Boolean;
    var     _ammoCount: Integer;
    var     _lastChatMessage: String := '';
    var     _lastUpdated: DateTime;
  assembly
    constructor(Msg: Message);
    /// <summary>
    /// True if you can reach this bot, false if there is something between you (eg. A Pit)
    /// </summary>
    
    property IsReachable: Boolean read get_IsReachable;
    method get_IsReachable: Boolean;
    property CurrentAmmo: Integer read get_CurrentAmmo write set_CurrentAmmo;
    method get_CurrentAmmo: Integer;
    method set_CurrentAmmo(value: Integer);
    property LastChatMessage: String read get_LastChatMessage write set_LastChatMessage;
    method get_LastChatMessage: String;
    method set_LastChatMessage(value: String);
    property LastUpdated: DateTime read get_LastUpdated write set_LastUpdated;
    method get_LastUpdated: DateTime;
    method set_LastUpdated(value: DateTime);
  end;


implementation

constructor UTBotOppState(Msg: Message);
begin
  if Msg.Info = InfoMessage.PLAYER_INFO then
  begin
    Self._id := new UTIdentifier(Msg.Arguments[0]);
    Self._location := UTVector.Parse(Msg.Arguments[1]);
    Self._rotation := UTVector.Parse(Msg.Arguments[2]);
    Self._velocity := UTVector.Parse(Msg.Arguments[3]);
    Self._name := Msg.Arguments[4];
    Self._health := Integer.Parse(Msg.Arguments[5]);
    Self._armor := Integer.Parse(Msg.Arguments[6]);
    Self._weapon := Msg.Arguments[7].GetAsWeaponType();
    Self._firingType := FireType((Integer.Parse(Msg.Arguments[8])));
    Self._mesh := BotMesh((Integer.Parse(Msg.Arguments[9])));
    Self._colour := BotColor((Integer.Parse(Msg.Arguments[10])));
    Self._isReachable := Boolean.Parse(Msg.Arguments[11]);
    if Msg.Arguments.Length > 12 then
    begin
      Self._ammoCount := Integer.Parse(Msg.Arguments[12])
    end;
  end;
end;

method UTBotOppState.get_IsReachable: Boolean;
begin
  Result := Self._isReachable;
end;

method UTBotOppState.get_CurrentAmmo: Integer;
begin
  Result := Self._ammoCount;
end;

method UTBotOppState.set_CurrentAmmo(value: Integer);
begin
  Self._ammoCount := value;
  OnPropertyChanged('CurrentAmmo')
end;

method UTBotOppState.get_LastChatMessage: String;
begin
  Result := Self._lastChatMessage;
end;

method UTBotOppState.set_LastChatMessage(value: String);
begin
  Self._lastChatMessage := value;
  OnPropertyChanged('LastChatMessage')
end;

method UTBotOppState.get_LastUpdated: DateTime;
begin
  Result := Self._lastUpdated;
end;

method UTBotOppState.set_LastUpdated(value: DateTime);
begin
  Self._lastUpdated := value;
  OnPropertyChanged('LastUpdated')
end;


end.
