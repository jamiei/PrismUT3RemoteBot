
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
  UTItem = public class
  private
    var     _id: UTIdentifier;
    var     _itemType: ItemType;
    var     _actualClass: Integer;
  assembly
    method IsItem(&type: ItemType): Boolean;
    method IsItem(&type: WeaponType): Boolean;
    method IsItem(&type: HealthType): Boolean;
    method IsItem(&type: ArmorType): Boolean;
    method IsItem(&type: AmmoType): Boolean;
  public  
    constructor(Id: String; &Type: String);
    constructor(invMessage: Message);

    method ToString(): String; override;

    /// <summary>
    /// The actual item as an int, you might want to cast it to the correct (Weapon/Ammo/Health/Armor)Type Enum
    /// </summary>
    property ActualClass: Integer read get_ActualClass;
    /// <summary>
    /// The type of item
    /// </summary>
    property ItemType: ItemType read get_ItemType;
    property Id: UTIdentifier read get_Id;
    method get_ActualClass: Integer;
    method get_ItemType: ItemType;
    method get_Id: UTIdentifier;
  end;


implementation

method UTItem.IsItem(&type: ItemType): Boolean;
begin
  if (Self._itemType = &type) then
  begin
    exit true
  end;
  exit false;
end;

method UTItem.IsItem(&type: WeaponType): Boolean;
begin
  if ((Self._itemType = ItemType.Weapon) and (Self._actualClass = Integer(&type))) then
  begin
    exit true
  end;
  exit false
end;

method UTItem.IsItem(&type: HealthType): Boolean;
begin
  if ((Self._itemType = ItemType.Health) and (Self._actualClass = Integer(&type))) then
  begin
    exit true
  end;
  exit false
end;

method UTItem.IsItem(&type: ArmorType): Boolean;
begin
  if ((Self._itemType = ItemType.Armor) and (Self._actualClass = Integer(&type))) then
  begin
    exit true
  end;
  exit false
end;

method UTItem.IsItem(&type: AmmoType): Boolean;
begin
  if ((Self._itemType = ItemType.Ammo) and (Self._actualClass = Integer(&type))) then
  begin
    exit true
  end;
  exit false
end;

method UTItem.ToString(): String;
begin
  case Self.ItemType of 
    ItemType.Ammo: 
       case (AmmoType(Self.ActualClass)) of
         AmmoType.Avril: Result := 'Anvil ammo';
         AmmoType.BioRifle: Result := 'Bio rifle ammo';
         AmmoType.Enforcer: Result := 'Enforcer ammo';
         AmmoType.FlakCannon: Result := 'Flak Cannon ammo';
         AmmoType.LinkGun: Result := 'Link gun ammo';
         AmmoType.RocketLauncher: Result := 'Rocket Launcher ammo';
         AmmoType.ShockRifle: Result := 'Shock Rifle ammo';
         AmmoType.SniperRifle: Result := 'Sniper Rifle ammo';
         AmmoType.Stinger: Result := 'Stinger ammo';
         else Result := 'Unknown';
       end; // case
    ItemType.Armor: 
      case (ArmorType(Self.ActualClass)) of
        ArmorType.Berserk: Result := 'Beserk Powerup';
        ArmorType.ChestArmour: Result := 'Chest Armour';
        ArmorType.Helmet: Result := 'Helmet';
        ArmorType.Invisibility: Result := 'Invisibility Powerup';
        ArmorType.Invulnerability: Result := 'Invulnerability Powerup';
        ArmorType.JumpBoots: Result := 'Jump Boots';
        ArmorType.MultiplyDamage: Result := 'Damage Multiplier powerup';
        ArmorType.ShieldBelt: Result := 'Shield belt';
        ArmorType.ThighPads: Result := 'Thigh Pad Armour';
        else Result := 'Unknown';
      end; // case
    ItemType.Health: 
      case (HealthType(Self.ActualClass)) of
        HealthType.BigKegOHealth: Result := 'Big Keg o Health';
        HealthType.HealthVial: Result := 'Health Vial';
        HealthType.MediBox: Result := 'Medi box';
        HealthType.SuperHealth: Result := 'Super Health';
        else Result := 'Unknown';
      end; // case
    ItemType.Weapon: 
      case (WeaponType(Self.ActualClass)) of
        WeaponType.Avril: Result := 'Avril';
        WeaponType.BioRifle: Result := 'Bio Rifle';
        WeaponType.Enforcer: Result := 'Enforcer';
        WeaponType.FlakCannon: Result := 'Flack Cannon';
        WeaponType.ImpactHammer: Result := 'Impact Hammer';
        WeaponType.InstaGibRifle: Result := 'Insta Gib Rifle';
        WeaponType.LinkGun: Result := 'Link Gun';
        WeaponType.Redeemer: Result := 'Redeemer';
        WeaponType.RocketLauncher: Result := 'Rocket Launcher';
        WeaponType.ShockRifle: Result := 'Shock Rifle';
        WeaponType.SniperRifle: Result := 'Sniper Rifle';
        WeaponType.Stinger: Result := 'Stinger';
        WeaponType.Translocator: Result := 'Translocator';
        else Result := 'Unknown';
      end; // case
    else Result := 'Unknown';
  end; // case Self.ItemType of 
end;

constructor UTItem(Id: String; &Type: String);
begin
  Self._id := new UTIdentifier(Id);
  var weaponType: WeaponType := &Type.GetAsWeaponType();
  var ammoType: AmmoType := &Type.GetAsAmmoType();
  var healthType: HealthType := &Type.GetAsHealthType();
  var armorType: ArmorType := &Type.GetAsArmorType();

  if weaponType <> WeaponType.None then
  begin
    Self._itemType := ItemType.Weapon;
    Self._actualClass := Integer(weaponType)
  end;
  if ammoType <> AmmoType.None then
  begin
    Self._itemType := ItemType.Ammo;
    Self._actualClass := Integer(ammoType)
  end;
  if healthType <> HealthType.None then
  begin
    Self._itemType := ItemType.Health;
    Self._actualClass := Integer(healthType)
  end;
  if armorType <> ArmorType.None then
  begin
    Self._itemType := ItemType.Armor;
    Self._actualClass := Integer(armorType)
  end;
end;

constructor UTItem(invMessage: Message);
begin
  constructor(invMessage.Arguments[0], invMessage.Arguments[1]);
end;

method UTItem.get_Id: UTIdentifier;
begin
  Result := Self._id;
end;

method UTItem.get_ItemType: ItemType;
begin
  Result := Self._itemType;
end;

method UTItem.get_ActualClass: Integer;
begin
  Result := Self._actualClass;
end;


end.
