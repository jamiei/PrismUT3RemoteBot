
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
  assembly or protected
    method IsItem(&type: ItemType): Boolean;
    method IsItem(&type: WeaponType): Boolean;
    method IsItem(&type: HealthType): Boolean;
    method IsItem(&type: ArmorType): Boolean;
    method IsItem(&type: AmmoType): Boolean;
    method ToString(): String;override;
  assembly
    constructor UTItem(invMessage: Message);
    constructor UTItem(Id: String; &Type: String);
    property Id: UTIdentifier read get_Id;
    method get_Id: UTIdentifier;
    /// <summary>
    /// The type of item
    /// </summary>
    
    property ItemType: ItemType read get_ItemType;
    method get_ItemType: ItemType;
    /// <summary>
    /// The actual item as an int, you might want to cast it to the correct (Weapon/Ammo/Health/Armor)Type Enum
    /// </summary>
    
    property ActualClass: Integer read get_ActualClass;
    method get_ActualClass: Integer;
  end;


implementation

method UTItem.IsItem(&type: ItemType): Boolean;
begin
  if this._itemType = &type then
  begin
    exit true
  end
  else
  begin
  end;
  exit false
end;

method UTItem.IsItem(&type: WeaponType): Boolean;
begin
  if this._itemType = ItemType.Weapon and this._actualClass = Integer(&type) then
  begin
    exit true
  end
  else
  begin
  end;
  exit false
end;

method UTItem.IsItem(&type: HealthType): Boolean;
begin
  if this._itemType = ItemType.Health and this._actualClass = Integer(&type) then
  begin
    exit true
  end
  else
  begin
  end;
  exit false
end;

method UTItem.IsItem(&type: ArmorType): Boolean;
begin
  if this._itemType = ItemType.Armor and this._actualClass = Integer(&type) then
  begin
    exit true
  end
  else
  begin
  end;
  exit false
end;

method UTItem.IsItem(&type: AmmoType): Boolean;
begin
  if this._itemType = ItemType.Ammo and this._actualClass = Integer(&type) then
  begin
    exit true
  end
  else
  begin
  end;
  exit false
end;

method UTItem.ToString(): String;
begin
  case this.ItemTypeof
case ItemType.Ammo:begin
      case AmmoType(this.ActualClass)of
case AmmoType.Avril:        exit 'Avril ammo';case AmmoType.BioRifle:        exit 'Bio rifle ammo';case AmmoType.Enforcer:        exit 'Enforcer ammo';case AmmoType.FlakCannon:        exit 'Flak cannon ammo';case AmmoType.LinkGun:        exit 'Link gun ammo';case AmmoType.RocketLauncher:        exit 'Rocket launcher ammo';case AmmoType.ShockRifle:        exit 'Shock rifle ammo';case AmmoType.SniperRifle:        exit 'Sniper rifle ammo';case AmmoType.Stinger:        exit 'Stinger ammo';else        exit 'Unknown';      end;
      break;
    end;
case ItemType.Armor:begin
      case ArmorType(this.ActualClass)of
case ArmorType.Berserk:        exit 'Beserk powerup';case ArmorType.ChestArmour:        exit 'Chest armor';case ArmorType.Helmet:        exit 'Helmet';case ArmorType.Invisibility:        exit 'invistibilty powerup';case ArmorType.Invulnerability:        exit 'Invulnerability powerup';case ArmorType.JumpBoots:        exit 'Jump boots';case ArmorType.ShieldBelt:        exit 'Shield belt';case ArmorType.ThighPads:        exit 'Thigh pad armor';case ArmorType.MultiplyDamage:        exit 'Damaage multiplier powerup';else        exit 'Unknown';      end;
      break;
    end;
case ItemType.Health:begin
      case HealthType(this.ActualClass)of
case HealthType.HealthVial:        exit 'Health vial';case HealthType.MediBox:        exit 'Medi box';case HealthType.BigKegOHealth:        exit 'Big Keg o'' Health';case HealthType.SuperHealth:        exit 'Super Health';else        exit 'Unknown';      end;
      break;
    end;
case ItemType.Weapon:begin
      case WeaponType(this.ActualClass)of
case WeaponType.Avril:        exit 'Avril';case WeaponType.BioRifle:        exit 'Bio rifle';case WeaponType.Enforcer:        exit 'Enforcer';case WeaponType.FlakCannon:        exit 'Flak cannon';case WeaponType.ImpactHammer:        exit 'Impact hammer';case WeaponType.InstaGibRifle:        exit 'Insta gib rifle';case WeaponType.LinkGun:        exit 'Link gun';case WeaponType.Redeemer:        exit 'Redeemer';case WeaponType.RocketLauncher:        exit 'Rocket Launcher';case WeaponType.ShockRifle:        exit 'Shock rifle';case WeaponType.SniperRifle:        exit 'Sniper rifle';case WeaponType.Stinger:        exit 'Stinger';case WeaponType.Translocator:        exit 'Trans locator';else        exit 'Unkown';      end;
      break;
    end;
else    exit 'Unknown';  end;
  exit 'Unknown'
end;

constructor UTItem.UTItem(invMessage: Message);
begin
end;

constructor UTItem.UTItem(Id: String; &Type: String);
begin
  this._id := new UTIdentifier(Id);
  var weaponType: WeaponType := &Type.GetAsWeaponType();
  var ammoType: AmmoType := &Type.GetAsAmmoType();
  var healthType: HealthType := &Type.GetAsHealthType();
  var armorType: ArmorType := &Type.GetAsArmorType();
  if weaponType <> WeaponType.None then
  begin
    this._itemType := ItemType.Weapon;
    this._actualClass := Integer(weaponType)
  end
  else
  begin
    if ammoType <> AmmoType.None then
    begin
      this._itemType := ItemType.Ammo;
      this._actualClass := Integer(ammoType)
    end
    else
    begin
      if healthType <> HealthType.None then
      begin
        this._itemType := ItemType.Health;
        this._actualClass := Integer(healthType)
      end
      else
      begin
        if armorType <> ArmorType.None then
        begin
          this._itemType := ItemType.Armor;
          this._actualClass := Integer(armorType)
        end
        else
        begin
        end
      end
    end
  end
end;

method UTItem.get_Id: UTIdentifier;
begin
  exit this._id
end;

method UTItem.get_ItemType: ItemType;
begin
  exit this._itemType
end;

method UTItem.get_ActualClass: Integer;
begin
  exit this._actualClass
end;


end.
