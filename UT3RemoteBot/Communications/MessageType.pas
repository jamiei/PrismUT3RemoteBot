namespace UT3Bots.Communications;

interface

uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Text,
  System.Diagnostics,
  System.Reflection,
  System.Runtime.CompilerServices;

type
  [AttributeUsage(AttributeTargets.Field)]
  StringValueAttribute = public class (Attribute)
    private
      _stringvalue: string;
    public
      property StringValue: string read _stringvalue write _stringvalue;
      constructor(value: String);
  end;

  EventMessage = assembly enum(
    [StringValue('')]
    None = 0,
    /// <summary>
		/// The message indicating that this a status update
		/// </summary>
		[StringValue('STATE')]
		STATE,

		/// <summary>
		/// The message containing info about the game that you have connected to
		/// </summary>
		[StringValue('INFO')]
		INFO,

		/// <summary>
		/// The message that the match is over
		/// </summary>
		[StringValue('ENDMATCH')]
		MATCH_ENDED,

		/// <summary>
		/// The message telling you that the match has not yet started
		/// </summary>
		[StringValue('WAITFORSPAWN')]
		WAITING_FOR_SPAWN,

		/// <summary>
		/// The message telling you that you've respawned and ready to fight
		/// </summary>
		[StringValue('SPAWNED')]
		SPAWNED,

		/// <summary>
		/// A message that a player has died
		/// </summary>
		[StringValue('KILLED')]
		KILLED,

		/// <summary>
		/// The message that this bot has died
		/// </summary>
		[StringValue('DIED')]
		DIED,

		/// <summary>
		/// The message that this bot might fall
		/// </summary>
		[StringValue('FOUNDFALL')]
		FOUNDFALL,

		/// <summary>
		/// The message about having seen another player
		/// </summary>
		[StringValue('SEENPLAYER')]
		SEEN_PLAYER,

		/// <summary>
		/// The message about having bumped into something
		/// </summary>
		[StringValue('BUMPED')]
		BUMPED,

		/// <summary>
		/// The message about having bumped into a wall
		/// </summary>
		[StringValue('HITWALL')]
		HIT_WALL,

		/// <summary>
		/// The message about having heard a noise nearby
		/// </summary>
		[StringValue('HEARDNOISE')]
		HEARD_NOISE,

		/// <summary>
		/// The message about being damages
		/// </summary>
		[StringValue('DAMAGED')]
		DAMAGED,

		/// <summary>
		/// The message about hearing a chat message
		/// </summary>
		[StringValue('CHAT')]
		CHAT,

		/// <summary>
		/// The message about someone taunting you
		/// </summary>
		[StringValue('TAUNTED')]
		TAUNTED,

		/// <summary>
		/// The message about the bot's weapon changing
		/// </summary>
		[StringValue('WEAPONCHANGED')]
		WEAPON_CHANGED,

		/// <summary>
		/// The message about the bot picking up an item
		/// </summary>
		[StringValue('GOTPICKUP')]
		GOT_PICKUP,

		/// <summary>
		/// The message about the path returned from a 'get path' call
		/// </summary>
		[StringValue('PATH')]
		PATH
  );  

  CommandMessage = assembly enum(
    [StringValue('')]
    None = 0,

    /// <summary>
		/// The command to setup the bot
		/// </summary>
		[StringValue('INIT')]
		INITIALIZE,

		/// <summary>
		/// The command to Fire your gun
		/// </summary>
		[StringValue('FIRE')]
		FIRE,

		/// <summary>
		/// The command to stop firing your gun
		/// </summary>
		[StringValue('STOPFIRE')]
		STOP_FIRE,

		/// <summary>
		/// The command to stop the bot moving
		/// </summary>
		[StringValue('STOP')]
		STOP,

		/// <summary>
		/// The command to Run to a location
		/// </summary>
		[StringValue('RUNTO')]
		RUN_TO,

		/// <summary>
		/// The command to Strafe to a location while looking at a target
		/// </summary>
		[StringValue('STRAFETO')]
		STRAFE_TO,

		/// <summary>
		/// The command to rotate the bot to point at a specific location
		/// </summary>
		[StringValue('ROTATETO')]
		ROTATE_TO,

		/// <summary>
		/// The command to rotate the bot by a certain amount
		/// </summary>
		[StringValue('ROTATEBY')]
		ROTATE_BY,

		/// <summary>
		/// The command to make the bot jump
		/// </summary>
		[StringValue('JUMP')]
		JUMP,

		/// <summary>
		/// The command to make the bot send a chat message
		/// </summary>
		[StringValue('SENDCHAT')]
		SENDCHAT,

		/// <summary>
		/// The command to make the bot send a taunt message
		/// </summary>
		[StringValue('SENDTAUNT')]
		SENDTAUNT,

		/// <summary>
		/// The command to make the bot send an emote
		/// </summary>
		[StringValue('SENDEMOTE')]
		SENDEMOTE,

		/// <summary>
		/// The command to make the bot walk or run
		/// </summary>
		[StringValue('SETWALK')]
		SETWALK,

		/// <summary>
		/// The command to make the bot change weapon
		/// </summary>
		[StringValue('CHANGEWEAPON')]
		CHANGE_WEAPON,

		/// <summary>
		/// The command to request a list of path nodes to a location
		/// </summary>
		[StringValue('GETPATH')]
		GET_PATH
    );

  InfoMessage = assembly enum(
    [StringValue('')]
    None = 0,
		/// <summary>
		/// The message stating that this is the beginning of a state update batch
		/// </summary>
		[StringValue('BEGIN')]
		&BEGIN,

		/// <summary>
		/// The message stating that this is the end of a state update batch
		/// </summary>
		[StringValue('END')]
		&END,

		/// <summary>
		/// The message about player scores
		/// </summary>
		[StringValue('SCORE')]
		SCORE_INFO,

		/// <summary>
		/// The message about player info
		/// </summary>
		[StringValue('PLAYER')]
		PLAYER_INFO,

		/// <summary>
		/// The message about navigation points
		/// </summary>
		[StringValue('NAV')]
		NAV_INFO,

		/// <summary>
		/// The message about power ups that are on the map
		/// </summary>
		[StringValue('PICKUP')]
		PICKUP_INFO,

		/// <summary>
		/// The message about the bot itself
		/// </summary>
		[StringValue('SELF')]
		SELF_INFO,

		/// <summary>
		/// The message about the game
		/// </summary>
		[StringValue('GAME')]
		GAME_INFO
    );

  [Extension]
  Extensions = assembly static class
  private
    class var     EventMessages: Dictionary<String, EventMessage>;
    class var     InfoMessages: Dictionary<String, InfoMessage>;
    class var     WeaponTypes: Dictionary<String, WeaponType>;
    class var     AmmoTypes: Dictionary<String, AmmoType>;
    class var     HealthTypes: Dictionary<String, HealthType>;
    class var     ArmorTypes: Dictionary<String, ArmorType>;
  assembly
    [Extension]
    class method GetStringValue(value : &Enum): String;
    [Extension]
    class method GetNames(t: &Type): array of String;
    [Extension]
    class method GetAsEvent(value: String): EventMessage;
    [Extension]
    class method GetAsInfo(value: String): InfoMessage;
    [Extension]
    class method GetAsWeaponType(value: String): WeaponType;
    [Extension]
    class method GetAsAmmoType(value: String): AmmoType;
    [Extension]
    class method GetAsHealthType(value: String): HealthType;
    [Extension]
    class method GetAsArmorType(value: String): ArmorType;
    constructor;
  end;


implementation

class method Extensions.GetNames(t: &Type): array of String;
begin
  var names: List<String> := new List<String>();
  var infoCollection: array of FieldInfo := t.GetFields(BindingFlags.&Public or BindingFlags.&Static);
  for each fi: FieldInfo in infoCollection do
  begin
    names.&Add(fi.Name)
  end;
  exit names.ToArray()
end;

class method Extensions.GetStringValue(value: &Enum): String;
begin
  var &type: &Type := value.GetType();
  var fieldInfo: FieldInfo := &type.GetField(value.ToString());
  var attribs: array of StringValueAttribute := array of StringValueAttribute(fieldInfo.GetCustomAttributes(typeOf(StringValueAttribute), false));
  exit iif(attribs.Length > 0, attribs[0].StringValue, nil)
end;

constructor Extensions;
begin
  EventMessages := new Dictionary<String, EventMessage>();
  var names: array of String := GetNames(typeOf(EventMessage));
  for each name: String in names do
  begin
    var &type: EventMessage := (EventMessage(&Enum.Parse(typeOf(EventMessage), name, true)));
    EventMessages.&Add(&type.GetStringValue(), &type)
  end;
  InfoMessages := new Dictionary<String, InfoMessage>();
  names := GetNames(typeOf(InfoMessage));
  for each name: String in names do
  begin
    var &type: InfoMessage := (InfoMessage(&Enum.Parse(typeOf(InfoMessage), name, true)));
    InfoMessages.&Add(&type.GetStringValue(), &type)
  end;
  WeaponTypes := new Dictionary<String, WeaponType>();
  names := GetNames(typeOf(WeaponType));
  for each name: String in names do
  begin
    var &type: WeaponType := (WeaponType(&Enum.Parse(typeOf(WeaponType), name, true)));
    WeaponTypes.&Add(&type.GetStringValue(), &type)
  end;
  AmmoTypes := new Dictionary<String, AmmoType>();
  names := GetNames(typeOf(AmmoType));
  for each name: String in names do
  begin
    var &type: AmmoType := (AmmoType(&Enum.Parse(typeOf(AmmoType), name, true)));
    AmmoTypes.&Add(&type.GetStringValue(), &type)
  end;
  HealthTypes := new Dictionary<String, HealthType>();
  names := GetNames(typeOf(HealthType));
  for each name: String in names do
  begin
    var &type: HealthType := (HealthType(&Enum.Parse(typeOf(HealthType), name, true)));
    HealthTypes.&Add(&type.GetStringValue(), &type)
  end;
  ArmorTypes := new Dictionary<String, ArmorType>();
  names := GetNames(typeOf(ArmorType));
  for each name: String in names do
  begin
    var &type: ArmorType := (ArmorType(&Enum.Parse(typeOf(ArmorType), name, true)));
    ArmorTypes.&Add(&type.GetStringValue(), &type)
  end
end;


class method Extensions.GetAsEvent(value: String): EventMessage;
begin
  if (EventMessages.ContainsKey(value)) then Result := EventMessages[value] else Result := EventMessage.None;
end;

class method Extensions.GetAsInfo(value: String): InfoMessage;
begin
  if (InfoMessages.ContainsKey(value)) then Result := InfoMessages[value] else Result := InfoMessage.None;
end;

class method Extensions.GetAsWeaponType(value: String): WeaponType;
begin
  if (WeaponTypes.ContainsKey(value)) then Result := WeaponTypes[value] else Result := WeaponType.None;
end;

class method Extensions.GetAsAmmoType(value: String): AmmoType;
begin
  if (AmmoTypes.ContainsKey(value)) then Result := AmmoTypes[value] else Result := AmmoType.None;
end;

class method Extensions.GetAsHealthType(value: String): HealthType;
begin
  if (HealthTypes.ContainsKey(value)) then Result := HealthTypes[value] else Result := HealthType.None;
end;

class method Extensions.GetAsArmorType(value: String): ArmorType;
begin
  if (ArmorTypes.ContainsKey(value)) then Result := ArmorTypes[value] else Result := ArmorType.None;
end;

constructor StringValueAttribute(value: String);
begin
  Self._stringvalue := value;
end;

end.