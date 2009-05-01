
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
  UTBotState = public abstract class(UTObject)
  protected
    //Common State variables
    
    var     _rotation: UTVector;
    var     _velocity: UTVector;
    var     _name: String;
    var     _health: Integer;
    var     _armor: Integer;
    var     _weapon: WeaponType := WeaponType.None;
    var     _firingType: FireType;
    var     _mesh: BotMesh;
    var     _colour: BotColor;

    method UpdateState(playerMessage: Message);virtual;
  public

    //Constructor
    
    constructor ();
    constructor (Id: UTIdentifier; Location: UTVector; Rotation: UTVector; Velocity: UTVector; Name: String; Health: Integer; Armor: Integer; Weapon: WeaponType; Firing: FireType; Mesh: BotMesh; Color: BotColor);
    /// <summary>
    /// The actual name of this bot
    /// </summary>
    
    property Name: String read get_Name write set_Name;
    method get_Name: String;
    method set_Name(value: String);
    /// <summary>
    /// The amount of health this bot has (Between 0 and 200)
    /// </summary>
    
    property Health: Integer read get_Health write set_Health;
    method get_Health: Integer;
    method set_Health(value: Integer);
    /// <summary>
    /// The amount of armor this bot has 
    /// </summary>
    
    property ArmorStrength: Integer read get_ArmorStrength write set_ArmorStrength;
    method get_ArmorStrength: Integer;
    method set_ArmorStrength(value: Integer);
    /// <summary>
    /// The 3D Vector of which way this bot is facing (X, Y, Z = Yaw, Pitch, Roll)
    /// </summary>
    
    property Rotation: UTVector read get_Rotation write set_Rotation;
    method get_Rotation: UTVector;
    method set_Rotation(value: UTVector);
    /// <summary>
    /// The Angle in degrees of which way this bot is facing from a top down view
    /// </summary>
    
    property RotationAngle: Double read get_RotationAngle;
    method get_RotationAngle: Double;
    /// <summary>
    /// The 3D Vector of which direction and how fast this bot is moving
    /// </summary>
    
    property Velocity: UTVector read get_Velocity;
    method get_Velocity: UTVector;
    /// <summary>
    /// The skinned colour of this bot
    /// </summary>
    
    property Color: BotColor read get_Color;
    method get_Color: BotColor;
    /// <summary>
    /// The mesh of this bot
    /// </summary>
    
    property Mesh: BotMesh read get_Mesh;
    method get_Mesh: BotMesh;
    /// <summary>
    /// The weapon currently selected by this bot
    /// </summary>
    
    property Weapon: WeaponType read get_Weapon;
    method get_Weapon: WeaponType;
    /// <summary>
    /// Whether this bot is currently not firing, firing or alt-firing
    /// </summary>
    
    property FiringType: FireType read get_FiringType write set_FiringType;
    method get_FiringType: FireType;
    method set_FiringType(value: FireType);
    /// <summary>
    /// Is the bot firing
    /// </summary>
    
    property IsFiring: Boolean read get_IsFiring;
    method get_IsFiring: Boolean;
  end;


implementation

method UTBotState.UpdateState(playerMessage: Message);
begin
  if ((playerMessage <> nil) and ((playerMessage.Info = InfoMessage.PLAYER_INFO) or (playerMessage.Info = InfoMessage.SELF_INFO))) then
  begin
    Self._id := new UTIdentifier(playerMessage.Arguments[0]);
    Self._location := UTVector.Parse(playerMessage.Arguments[1]);
    Self._rotation := UTVector.Parse(playerMessage.Arguments[2]);
    Self._velocity := UTVector.Parse(playerMessage.Arguments[3]);
    Self._name := playerMessage.Arguments[4];
    Self._health := Integer.Parse(playerMessage.Arguments[5]);
    Self._armor := Integer.Parse(playerMessage.Arguments[6]);
    Self._weapon := playerMessage.Arguments[7].GetAsWeaponType();
    Self._firingType := FireType((Integer.Parse(playerMessage.Arguments[8])));
    Self._mesh := BotMesh((Integer.Parse(playerMessage.Arguments[9])));
    Self._colour := BotColor((Integer.Parse(playerMessage.Arguments[10])));
  end;
end;

constructor UTBotState();
begin
  inherited constructor(nil, nil);
end;

constructor UTBotState(Id: UTIdentifier; Location: UTVector; Rotation: UTVector; Velocity: UTVector; Name: String; Health: Integer; Armor: Integer; Weapon: WeaponType; Firing: FireType; Mesh: BotMesh; Color: BotColor);
begin
  inherited constructor(Id, Location);
  Self._rotation := Rotation;
  Self._velocity := Velocity;
  Self._name := Name;
  Self._health := Health;
  Self._armor := Armor;
  Self._weapon := Weapon;
  Self._firingType := Firing;
  Self._mesh := Mesh;
  Self._colour := Color;
end;

method UTBotState.get_Name: String;
begin
  Result := Self._name;
end;

method UTBotState.set_Name(value: String);
begin
  Self._name := value;
  OnPropertyChanged('Name')
end;

method UTBotState.get_Health: Integer;
begin
  Result := Self._health;
end;

method UTBotState.set_Health(value: Integer);
begin
  Self._health := value;
  OnPropertyChanged('Health')
end;

method UTBotState.get_ArmorStrength: Integer;
begin
  Result := Self._armor;
end;

method UTBotState.set_ArmorStrength(value: Integer);
begin
  Self._armor := value;
  OnPropertyChanged('ArmorStrength')
end;

method UTBotState.get_Rotation: UTVector;
begin
  Result := Self._rotation;
end;

method UTBotState.set_Rotation(value: UTVector);
begin
  Self._rotation := value;
  OnPropertyChanged('Rotation');
  OnPropertyChanged('RotationAngle')
end;

method UTBotState.get_RotationAngle: Double;
begin
  Result := (Self._rotation.Y / 65535) * 360;
end;

method UTBotState.get_Velocity: UTVector;
begin
  Result := Self._velocity;
end;

method UTBotState.get_Color: BotColor;
begin
  Result := Self._colour;
end;

method UTBotState.get_Mesh: BotMesh;
begin
  Result := Self._mesh;
end;

method UTBotState.get_Weapon: WeaponType;
begin
  Result := Self._weapon;
end;

method UTBotState.get_FiringType: FireType;
begin
  Result := Self._firingType;
end;

method UTBotState.set_FiringType(value: FireType);
begin
  Self._firingType := value;
  OnPropertyChanged('FiringType');
  OnPropertyChanged('IsFiring');
end;

method UTBotState.get_IsFiring: Boolean;
begin
  Result := (Self._firingType <> FireType.None);
end;


end.
