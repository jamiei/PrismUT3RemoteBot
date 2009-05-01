
// RemObjects CS to Pascal 0.1

namespace UT3Bots;

interface
uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Text,
  UT3Bots.UTItems;
type
  BotSpawnedEventArgs = public class(EventArgs)
  assembly or protected
    constructor;
  end;

  HasDiedEventArgs = public class(EventArgs)
  private
    var     _killer: UTIdentifier;
    var     _killed: UTIdentifier;
  assembly or protected
    constructor(Killer: UTIdentifier; Killed: UTIdentifier);
    /// <summary>
    /// The bot that killed the other one
    /// </summary>
    
    property Killer: UTIdentifier read get_Killer;
    method get_Killer: UTIdentifier;
    /// <summary>
    /// The bot that died
    /// </summary>
    
    property Killed: UTIdentifier read get_Killed;
    method get_Killed: UTIdentifier;
  end;

  SeenBotEventArgs = public class(EventArgs)
  private
    var     _id: UTIdentifier;
    var     _name: String;
    var     _team: String;
    var     _weapon: String;
    var     _rotation: UTVector;
    var     _location: UTVector;
    var     _velocity: UTVector;
    var     _isReachable: Boolean;
  assembly or protected
    constructor(Id: UTIdentifier; Name: String; Team: String; Weapon: String; Rotation: UTVector; Location: UTVector; Velocity: UTVector; IsReachable: Boolean);
    /// <summary>
    /// The bot that you just saw
    /// </summary>
    
    property Id: UTIdentifier read get_Id;
    method get_Id: UTIdentifier;
    /// <summary>
    /// The name of the bot
    /// </summary>
    
    property Name: String read get_Name;
    method get_Name: String;
    /// <summary>
    /// The team the bot is on
    /// </summary>
    
    property Team: String read get_Team;
    method get_Team: String;
    /// <summary>
    /// The weapon that the bot is currently using
    /// </summary>
    
    property Weapon: String read get_Weapon;
    method get_Weapon: String;
    /// <summary>
    /// The vector that the bot is facing
    /// </summary>
    
    property Rotation: UTVector read get_Rotation;
    method get_Rotation: UTVector;
    /// <summary>
    /// The location of the bot
    /// </summary>
    
    property Location: UTVector read get_Location;
    method get_Location: UTVector;
    /// <summary>
    /// The velocity of the bot
    /// </summary>
    
    property Velocity: UTVector read get_Velocity;
    method get_Velocity: UTVector;
    /// <summary>
    /// True if the bot is reachable by running straight to it, False if soemthing is in the way
    /// </summary>
    
    property IsReachable: Boolean read get_IsReachable;
    method get_IsReachable: Boolean;
  end;

  BumpedEventArgs = public class(EventArgs)
  private
    var     _id: UTIdentifier;
    var     _location: UTVector;
    var     _hitNormal: UTVector;
  assembly or protected
    constructor(Id: UTIdentifier; Location: UTVector; HitNormal: UTVector);
    /// <summary>
    /// The id of the bot that you just bumped
    /// </summary>
    
    property Id: UTIdentifier read get_Id;
    method get_Id: UTIdentifier;
    /// <summary>
    /// The location that you just bumped into
    /// </summary>
    
    property Location: UTVector read get_Location;
    method get_Location: UTVector;
    /// <summary>
    /// The normal vector between your bot's rotation and that of the bot you bumped
    /// </summary>
    
    property HitNormal: UTVector read get_HitNormal;
    method get_HitNormal: UTVector;
  end;

  HeardSoundEventArgs = public class(EventArgs)
  private
    var     _id: UTIdentifier;
    var     _location: UTVector;
    var     _loudness: Single;
  assembly or protected
    constructor(Id: UTIdentifier; Location: UTVector; Loudness: Single);
    /// <summary>
    /// The id of the thing that made the sound
    /// </summary>
    
    property Id: UTIdentifier read get_Id;
    method get_Id: UTIdentifier;
    /// <summary>
    /// The location the sound came from
    /// </summary>
    
    property Location: UTVector read get_Location;
    method get_Location: UTVector;
    /// <summary>
    /// How loud the noise was
    /// </summary>
    
    property Loudness: Single read get_Loudness;
    method get_Loudness: Single;
  end;

  DamagedEventArgs = public class(EventArgs)
  private
    var     _id: UTIdentifier;
    var     _location: UTVector;
    var     _damageAmount: Integer;
    var     _damageType: String;
    var     _momentum: UTVector;
  assembly or protected
    constructor(Id: UTIdentifier; Location: UTVector; DamageAmount: Integer; DamageType: String; Momentum: UTVector);
    /// <summary>
    /// The Id of the thing that damaged you
    /// </summary>
    
    property Id: UTIdentifier read get_Id;
    method get_Id: UTIdentifier;
    /// <summary>
    /// The location you were hit from
    /// </summary>
    
    property Location: UTVector read get_Location;
    method get_Location: UTVector;
    /// <summary>
    /// The amount of damage you just took
    /// </summary>
    
    property DamageAmount: Integer read get_DamageAmount;
    method get_DamageAmount: Integer;
    /// <summary>
    /// A string describing the type of damage
    /// </summary>
    
    property DamageType: String read get_DamageType;
    method get_DamageType: String;
    /// <summary>
    /// The momentum of the thing that damaged you
    /// </summary>
    
    property Momentum: UTVector read get_Momentum;
    method get_Momentum: UTVector;
  end;

  ChatEventArgs = public class(EventArgs)
  private
    var     _id: UTIdentifier;
    var     _fromName: String;
    var     _isFromTeam: Boolean;
    var     _message: String;
  assembly or protected
    constructor(Id: UTIdentifier; FromName: String; IsFromTeam: Boolean; Message: String);
    /// <summary>
    /// The Id of the bot that just sent a chat message
    /// </summary>
    
    property Id: UTIdentifier read get_Id;
    method get_Id: UTIdentifier;
    /// <summary>
    /// The name of the bot that sent the chat message
    /// </summary>
    
    property FromName: String read get_FromName;
    method get_FromName: String;
    /// <summary>
    /// True if the message came from a bot on your team
    /// </summary>
    
    property IsFromTeam: Boolean read get_IsFromTeam;
    method get_IsFromTeam: Boolean;
    /// <summary>
    /// The message that was sent
    /// </summary>
    
    property Message: String read get_Message;
    method get_Message: String;
  end;

  TauntedEventArgs = public class(EventArgs)
  private
    var     _id: UTIdentifier;
    var     _fromName: String;
  assembly or protected
    constructor(Id: UTIdentifier; FromName: String);
    /// <summary>
    /// The Id of the bot that taunted you
    /// </summary>
    
    property Id: UTIdentifier read get_Id;
    method get_Id: UTIdentifier;
    /// <summary>
    /// The name of the bot that taunted you
    /// </summary>
    
    property FromName: String read get_FromName;
    method get_FromName: String;
  end;

  FallEventArgs = public class(EventArgs)
  private
    var     _didFall: Boolean;
    var     _location: UTVector;
  assembly or protected
    constructor(DidFall: Boolean; Location: UTVector);
    /// <summary>
    /// True if you fell off the ledge, false if you didn't
    /// </summary>
    
    property DidFall: Boolean read get_DidFall;
    method get_DidFall: Boolean;
    /// <summary>
    /// The location of the ledge
    /// </summary>
    
    property Location: UTVector read get_Location;
    method get_Location: UTVector;
  end;

  WeaponChangedEventArgs = public class(EventArgs)
  private
    var     _id: UTIdentifier;
    var     _weaponClass: String;
  assembly or protected
    constructor(Id: UTIdentifier; WeaponClass: String);
    /// <summary>
    /// The Id of the weapon
    /// </summary>
    
    property Id: UTIdentifier read get_Id;
    method get_Id: UTIdentifier;
    /// <summary>
    /// The string describing the class of the weapon
    /// </summary>
    
    property WeaponClass: String read get_WeaponClass;
    method get_WeaponClass: String;
  end;

  PickupEventArgs = public class(EventArgs)
  private
    var     _item: UTItem;
    var     _wasDropped: Boolean;
  assembly or protected
    constructor(Item: UTItem; WasFromDrop: Boolean);
    /// <summary>
    /// The item that you picked up
    /// </summary>
    
    property Item: UTItem read get_Item;
    method get_Item: UTItem;
    /// <summary>
    /// True if the item was dropped by someone else, False if it was from a pickup location
    /// </summary>
    
    property WasFromDrop: Boolean read get_WasFromDrop;
    method get_WasFromDrop: Boolean;
  end;

  MatchEndedEventArgs = public class(EventArgs)
  private
    var     _winnerId: UTIdentifier;
    var     _winnerName: String;
    var     _reason: String;
  assembly or protected
    constructor(WinnerId: UTIdentifier; WinnerName: String; Reason: String);
    /// <summary>
    /// The Id of the bot that won the game
    /// </summary>
    
    property WinnerId: UTIdentifier read get_WinnerId;
    method get_WinnerId: UTIdentifier;
    /// <summary>
    /// THe name of the bot that won the game
    /// </summary>
    
    property WinnerName: String read get_WinnerName;
    method get_WinnerName: String;
    /// <summary>
    /// A string describing the reason they won the match
    /// </summary>
    
    property Reason: String read get_Reason;
    method get_Reason: String;
  end;

  PathEventArgs = public class(EventArgs)
  private
    var     _id: String;
    var     _nodes: List<UTNavPoint>;
  assembly or protected
    constructor(Id: String; Nodes: List<UTNavPoint>);
    /// <summary>
    /// The Id that you sent in the GetPath method
    /// </summary>
    
    property Id: String read get_Id;
    method get_Id: String;
    /// <summary>
    /// A ordered list of nodes that you must travel to to get to the location you specified in the GetPath call
    /// </summary>
    
    property Nodes: List<UTNavPoint> read get_Nodes;
    method get_Nodes: List<UTNavPoint>;
  end;

  BotEvents = public class
  private
    var     _utBot: UTBot;
  assembly
    method Trigger_OnSpawned(e: BotSpawnedEventArgs);
    method Trigger_OnDied(e: HasDiedEventArgs);
    method Trigger_OnOtherBotDied(e: HasDiedEventArgs);
    method Trigger_OnSeenOtherBot(e: SeenBotEventArgs);
    method Trigger_OnBumped(e: BumpedEventArgs);
    method Trigger_OnBumpedWall(e: BumpedEventArgs);
    method Trigger_OnHeardNoise(e: HeardSoundEventArgs);
    method Trigger_OnDamaged(e: DamagedEventArgs);
    method Trigger_OnReceivedChat(e: ChatEventArgs);
    method Trigger_OnFoundFall(e: FallEventArgs);
    method Trigger_OnTaunted(e: TauntedEventArgs);
    method Trigger_OnWeaponChanged(e: WeaponChangedEventArgs);
    method Trigger_OnGotPickup(e: PickupEventArgs);
    method Trigger_OnMatchEnded(e: MatchEndedEventArgs);
    method Trigger_OnPathReceived(e: PathEventArgs);
  assembly or protected
    constructor(Bot: UTBot);
    /// <summary>
    /// Occurs when your bot spawns on the map after joining the game, and after dying
    /// </summary>
    
    event OnSpawned: EventHandler<BotSpawnedEventArgs>;
    /// <summary>
    /// Occurs when your bot is killed
    /// </summary>
    
    event OnDied: EventHandler<HasDiedEventArgs>;
    /// <summary>
    /// Occurs when another bot somewhere on the map dies
    /// </summary>
    
    event OnOtherBotDied: EventHandler<HasDiedEventArgs>;
    /// <summary>
    /// Occurs when your bot sees another bot
    /// </summary>
    
    event OnSeenOtherBot: EventHandler<SeenBotEventArgs>;
    /// <summary>
    /// Occurs when your bot bumps into another bot
    /// </summary>
    
    event OnBumped: EventHandler<BumpedEventArgs>;
    /// <summary>
    /// Occurs when your bot bumps into a wall
    /// </summary>
    
    event OnBumpedWall: EventHandler<BumpedEventArgs>;
    /// <summary>
    /// Occurs when your bot hears a noise such as a gun fire, or a bot walking
    /// </summary>
    
    event OnHeardNoise: EventHandler<HeardSoundEventArgs>;
    /// <summary>
    /// Occurs when your bot is damaged by something
    /// </summary>
    
    event OnDamaged: EventHandler<DamagedEventArgs>;
    /// <summary>
    /// Occurs when something is said in Chat
    /// </summary>
    
    event OnReceivedChat: EventHandler<ChatEventArgs>;
    /// <summary>
    /// Occurs when your bot runs into a ledge, if your bot is running, it is likely you have already started to fall
    /// </summary>
    
    event OnFoundFall: EventHandler<FallEventArgs>;
    /// <summary>
    /// Occurs when someone taunts your bot. Time for revenge!
    /// </summary>
    
    event OnTaunted: EventHandler<TauntedEventArgs>;
    /// <summary>
    /// Occurs when your bot changes weapon, either from a pickup or because you sent the ChangeWeapon command
    /// </summary>
    
    event OnWeaponChanged: EventHandler<WeaponChangedEventArgs>;
    /// <summary>
    /// Occurs when your bot picks up an item
    /// </summary>
    
    event OnGotPickup: EventHandler<PickupEventArgs>;
    /// <summary>
    /// Occurs when the match is over, because some one won or the host ended the game
    /// </summary>
    
    event OnMatchEnded: EventHandler<MatchEndedEventArgs>;
    /// <summary>
    /// Occurs when the server has calculated a path from your GetPath method
    /// </summary>
    
    event OnPathReceived: EventHandler<PathEventArgs>;
  end;


implementation

constructor BotSpawnedEventArgs();
begin
end;

constructor HasDiedEventArgs(Killer: UTIdentifier; Killed: UTIdentifier);
begin
  Self._killer := Killer;
  Self._killed := Killed
end;

method HasDiedEventArgs.get_Killer: UTIdentifier;
begin
  Result := _killer;
end;

method HasDiedEventArgs.get_Killed: UTIdentifier;
begin
  Result := _killed;
end;

constructor SeenBotEventArgs(Id: UTIdentifier; Name: String; Team: String; Weapon: String; Rotation: UTVector; Location: UTVector; Velocity: UTVector; IsReachable: Boolean);
begin
  Self._id := Id;
  Self._name := Name;
  Self._team := Team;
  Self._weapon := Weapon;
  Self._rotation := Rotation;
  Self._location := Location;
  Self._velocity := Velocity;
  Self._isReachable := IsReachable
end;

method SeenBotEventArgs.get_Id: UTIdentifier;
begin
  Result := _id;
end;

method SeenBotEventArgs.get_Name: String;
begin
  Result := _name;
end;

method SeenBotEventArgs.get_Team: String;
begin
  Result := _team;
end;

method SeenBotEventArgs.get_Weapon: String;
begin
  Result := _weapon;
end;

method SeenBotEventArgs.get_Rotation: UTVector;
begin
  Result := _rotation;
end;

method SeenBotEventArgs.get_Location: UTVector;
begin
  Result := _location;
end;

method SeenBotEventArgs.get_Velocity: UTVector;
begin
  Result := _velocity;
end;

method SeenBotEventArgs.get_IsReachable: Boolean;
begin
  Result := _isReachable;
end;

constructor BumpedEventArgs(Id: UTIdentifier; Location: UTVector; HitNormal: UTVector);
begin
  Self._id := Id;
  Self._location := Location;
  Self._hitNormal := HitNormal
end;

method BumpedEventArgs.get_Id: UTIdentifier;
begin
  Result :=  _id;
end;

method BumpedEventArgs.get_Location: UTVector;
begin
  Result := _location;
end;

method BumpedEventArgs.get_HitNormal: UTVector;
begin
  Result := _hitNormal;
end;

constructor HeardSoundEventArgs(Id: UTIdentifier; Location: UTVector; Loudness: Single);
begin
  Self._id := Id;
  Self._location := Location;
  Self._loudness := Loudness
end;

method HeardSoundEventArgs.get_Id: UTIdentifier;
begin
  Result := _id;
end;

method HeardSoundEventArgs.get_Location: UTVector;
begin
  Result := _location;
end;

method HeardSoundEventArgs.get_Loudness: Single;
begin
  Result := _loudness;
end;

constructor DamagedEventArgs(Id: UTIdentifier; Location: UTVector; DamageAmount: Integer; DamageType: String; Momentum: UTVector);
begin
  Self._id := Id;
  Self._location := Location;
  Self._damageAmount := DamageAmount;
  Self._damageType := DamageType;
  Self._momentum := Momentum
end;

method DamagedEventArgs.get_Id: UTIdentifier;
begin
  Result := _id;
end;

method DamagedEventArgs.get_Location: UTVector;
begin
  Result := _location;
end;

method DamagedEventArgs.get_DamageAmount: Integer;
begin
  Result := _damageAmount;
end;

method DamagedEventArgs.get_DamageType: String;
begin
  Result := _damageType;
end;

method DamagedEventArgs.get_Momentum: UTVector;
begin
  Result := _momentum;
end;

constructor ChatEventArgs(Id: UTIdentifier; FromName: String; IsFromTeam: Boolean; Message: String);
begin
  Self._id := Id;
  Self._fromName := FromName;
  Self._isFromTeam := IsFromTeam;
  Self._message := Message
end;

method ChatEventArgs.get_Id: UTIdentifier;
begin
  Result := _id;
end;

method ChatEventArgs.get_FromName: String;
begin
  Result := _fromName;
end;

method ChatEventArgs.get_IsFromTeam: Boolean;
begin
  Result := _isFromTeam;
end;

method ChatEventArgs.get_Message: String;
begin
  Result := _message;
end;

constructor TauntedEventArgs(Id: UTIdentifier; FromName: String);
begin
  Self._id := Id;
  Self._fromName := FromName
end;

method TauntedEventArgs.get_Id: UTIdentifier;
begin
  Result := _id;
end;

method TauntedEventArgs.get_FromName: String;
begin
  Result := _fromName;
end;

constructor FallEventArgs(DidFall: Boolean; Location: UTVector);
begin
  Self._didFall := DidFall;
  Self._location := Location
end;

method FallEventArgs.get_DidFall: Boolean;
begin
  Result := _didFall;
end;

method FallEventArgs.get_Location: UTVector;
begin
  Result := _location;
end;

constructor WeaponChangedEventArgs(Id: UTIdentifier; WeaponClass: String);
begin
  Self._id := Id;
  Self._weaponClass := WeaponClass
end;

method WeaponChangedEventArgs.get_Id: UTIdentifier;
begin
  Result := _id;
end;

method WeaponChangedEventArgs.get_WeaponClass: String;
begin
  Result := _weaponClass;
end;

constructor PickupEventArgs(Item: UTItem; WasFromDrop: Boolean);
begin
  Self._item := Item;
  Self._wasDropped := WasFromDrop
end;

method PickupEventArgs.get_Item: UTItem;
begin
  Result := _item;
end;

method PickupEventArgs.get_WasFromDrop: Boolean;
begin
  Result := _wasDropped;
end;

constructor MatchEndedEventArgs(WinnerId: UTIdentifier; WinnerName: String; Reason: String);
begin
  Self._winnerId := WinnerId;
  Self._winnerName := WinnerName;
  Self._reason := Reason
end;

method MatchEndedEventArgs.get_WinnerId: UTIdentifier;
begin
  Result := _winnerId;
end;

method MatchEndedEventArgs.get_WinnerName: String;
begin
  Result := _winnerName;
end;

method MatchEndedEventArgs.get_Reason: String;
begin
  Result := _reason;
end;

constructor PathEventArgs(Id: String; Nodes: List<UTNavPoint>);
begin
  Self._id := Id;
  Self._nodes := Nodes
end;

method PathEventArgs.get_Id: String;
begin
  Result := _id;
end;

method PathEventArgs.get_Nodes: List<UTNavPoint>;
begin
  Result := _nodes;
end;

method BotEvents.Trigger_OnSpawned(e: BotSpawnedEventArgs);
begin
  if OnSpawned <> nil then
  begin
    OnSpawned.Invoke(Self._utBot, e)
  end;
end;

method BotEvents.Trigger_OnDied(e: HasDiedEventArgs);
begin
  if OnDied <> nil then
  begin
    OnDied.Invoke(Self._utBot, e)
  end;
end;

method BotEvents.Trigger_OnOtherBotDied(e: HasDiedEventArgs);
begin
  if OnOtherBotDied <> nil then
  begin
    OnOtherBotDied.Invoke(Self._utBot, e)
  end;
end;

method BotEvents.Trigger_OnSeenOtherBot(e: SeenBotEventArgs);
begin
  if OnSeenOtherBot <> nil then
  begin
    OnSeenOtherBot.Invoke(Self._utBot, e)
  end;
end;

method BotEvents.Trigger_OnBumped(e: BumpedEventArgs);
begin
  if OnBumped <> nil then
  begin
    OnBumped.Invoke(Self._utBot, e)
  end;
end;

method BotEvents.Trigger_OnBumpedWall(e: BumpedEventArgs);
begin
  if OnBumpedWall <> nil then
  begin
    OnBumpedWall.Invoke(Self._utBot, e)
  end;
end;

method BotEvents.Trigger_OnHeardNoise(e: HeardSoundEventArgs);
begin
  if OnHeardNoise <> nil then
  begin
    OnHeardNoise.Invoke(Self._utBot, e)
  end;
end;

method BotEvents.Trigger_OnDamaged(e: DamagedEventArgs);
begin
  if OnDamaged <> nil then
  begin
    OnDamaged.Invoke(Self._utBot, e)
  end;
end;

method BotEvents.Trigger_OnReceivedChat(e: ChatEventArgs);
begin
  if OnReceivedChat <> nil then
  begin
    OnReceivedChat.Invoke(Self._utBot, e)
  end;
end;

method BotEvents.Trigger_OnFoundFall(e: FallEventArgs);
begin
  if OnFoundFall <> nil then
  begin
    OnFoundFall.Invoke(Self._utBot, e)
  end;
end;

method BotEvents.Trigger_OnTaunted(e: TauntedEventArgs);
begin
  if OnTaunted <> nil then
  begin
    OnTaunted.Invoke(Self._utBot, e)
  end;
end;

method BotEvents.Trigger_OnWeaponChanged(e: WeaponChangedEventArgs);
begin
  if OnWeaponChanged <> nil then
  begin
    OnWeaponChanged.Invoke(Self._utBot, e)
  end;
end;

method BotEvents.Trigger_OnGotPickup(e: PickupEventArgs);
begin
  if OnGotPickup <> nil then
  begin
    OnGotPickup.Invoke(Self._utBot, e)
  end;
end;

method BotEvents.Trigger_OnMatchEnded(e: MatchEndedEventArgs);
begin
  if OnMatchEnded <> nil then
  begin
    OnMatchEnded.Invoke(Self._utBot, e)
  end;
end;

method BotEvents.Trigger_OnPathReceived(e: PathEventArgs);
begin
  if OnPathReceived <> nil then
  begin
    OnPathReceived.Invoke(Self._utBot, e)
  end;
end;

constructor BotEvents(Bot: UTBot);
begin
  Self._utBot := Bot
end;


end.
