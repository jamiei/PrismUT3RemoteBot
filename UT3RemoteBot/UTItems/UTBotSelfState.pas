
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
  UTBotSelfState = public class(UTBotState)
  private
    //Self state variables
    
    var     _currentAmmo: Integer;
    var     _inventory: Dictionary<WeaponType, UTIdentifier>;
  assembly or protected
    method UpdateState(selfMessage: Message);override;
    method AddInventoryItem(msg: Message): UTItem;
    method GetInvetoryItemID(&type: WeaponType): UTIdentifier;
  public
    /// <summary>
    /// Checks to see if your bot has a weapon in it's inventory
    /// </summary>
    /// <param name="type">The weaponType to check for</param>
    /// <returns>True if your bot has this weapon</returns>
    
    method HasWeapon(&type: WeaponType): Boolean;
    /// <summary>
    /// Checks to see if your bot is stood close to the specified location. 
    /// Useful to see if your bot has reached a Location it was running to.
    /// </summary>
    /// <param name="location">The location to check</param>
    /// <returns>True if your bot is currently stood at this location</returns>
    
    method IsCloseTo(location: UTVector): Boolean;
    /// <summary>
    /// Checks to see if your bot is stood close to the specified object. 
    /// Useful to see if your bot has reached a location it was running to.
    /// </summary>
    /// <param name="toObject">The object to check</param>
    /// <returns>True if your bot is currently stood at this location</returns>
    
    method IsCloseTo(toObject: UTObject): Boolean;
    constructor(Msg: Message);
    /// <summary>
    /// Ammo count for your currently selected weapon
    /// </summary>
    
    property CurrentAmmo: Integer read get_CurrentAmmo;
    method get_CurrentAmmo: Integer;
  end;


implementation

method UTBotSelfState.UpdateState(selfMessage: Message);
begin
  if ((selfMessage <> nil) and (selfMessage.Info = InfoMessage.SELF_INFO) and (selfMessage.Arguments.Length = 12)) then
  begin
    self._currentAmmo := Integer.Parse(selfMessage.Arguments[11])
  end;
  inherited UpdateState(selfMessage)
end;

method UTBotSelfState.AddInventoryItem(msg: Message): UTItem;
begin
  var newItem: UTItem := new UTItem(msg);
  if newItem.IsItem(ItemType.Weapon) then
  begin
    if Self._inventory.ContainsKey(WeaponType(newItem.ActualClass)) then
    begin
      Self._inventory[WeaponType(newItem.ActualClass)] := _id;
    end
    else
    begin
      Self._inventory.&Add(WeaponType(newItem.ActualClass), _id);
    end;
  end;
  exit newItem;
end;

method UTBotSelfState.GetInvetoryItemID(&type: WeaponType): UTIdentifier;
begin
  Result := Self._inventory[&type]
end;

method UTBotSelfState.HasWeapon(&type: WeaponType): Boolean;
begin
  Result := Self._inventory.ContainsKey(&type)
end;

method UTBotSelfState.IsCloseTo(location: UTVector): Boolean;
begin
  var dist: Single := Self._location.DistanceFrom(location);
  if dist <= 200 then
  begin
    exit true;
  end;
  exit false;
end;

method UTBotSelfState.IsCloseTo(toObject: UTObject): Boolean;
begin
  var dist: Single := Self._location.DistanceFrom(toObject.Location);
  if dist <= 200 then
  begin
    exit true;
  end;
  exit false;
end;

constructor UTBotSelfState(Msg: Message);
begin
  if ((Msg.Info = InfoMessage.PLAYER_INFO) and (Msg.Arguments.Length = 12)) then
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
    Self._currentAmmo := Integer.Parse(Msg.Arguments[11])
  end;
  Self._inventory := new Dictionary<WeaponType, UTIdentifier>()
end;

method UTBotSelfState.get_CurrentAmmo: Integer;
begin
  Result := Self._currentAmmo;
end;


end.
