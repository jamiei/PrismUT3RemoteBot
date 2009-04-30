
// RemObjects CS to Pascal 0.1

namespace UT3Bots.Communications;

interface
uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Text;
type
  BotMesh = public enum(
    IronGuard = -1,
    Lauren = 0,
    Barktooth,
    Reaper,
    Sharptooth,
    Harbinger,
    Matrix);  
    
  BotColor = public enum(
    Random = -2,
    None = -1,
    Red = 0,
    Blue = 1);  
    
  Emote = public enum(
    [StringValue('TauntA')]
    /// <summary>
    /// Oh Yeah, Bring it on baby!
    /// </summary>
    
    BringItOn,
    [StringValue('TauntB')]
    /// <summary>
    /// Got time to waste? Show off with some hoolahooping.
    /// </summary>
    
    HoolaHoop,
    [StringValue('TauntC')]
    /// <summary>
    /// I got your frags, right here!
    /// </summary>
    
    PelvicThrust,
    [StringValue('TauntD')]
    /// <summary>
    /// Boom! Headshot!
    /// </summary>
    
    BulletToTheHead,
    [StringValue('TauntE')]
    /// <summary>
    /// Come get some!
    /// </summary>
    
    ComeHere,
    [StringValue('TauntF')]
    /// <summary>
    /// Death is coming...
    /// </summary>
    
    SlitThroat);  
    
    FireType = public enum(
      None = 0,
      Firing = 1,
      AltFiring = 2);  
    
    ItemType = public enum(
      None = 0,
      Weapon,
      Ammo,
      Health,
      Armor);  
    
    WeaponType = public enum(
      [StringValue('')]
      None = 0,
      [StringValue('UTWeap_ImpactHammer')]
      ImpactHammer,
      [StringValue('UTWeap_Enforcer')]
      Enforcer,
      [StringValue('UTWeap_Translocator')]
      Translocator,
      [StringValue('UTWeap_BioRifle_Content')]
      BioRifle,
      [StringValue('UTWeap_ShockRifle')]
      ShockRifle,
      [StringValue('UTWeap_LinkGun')]
      LinkGun,
      [StringValue('UTWeap_Stinger')]
      Stinger,
      [StringValue('UTWeap_Avril')]
      Avril,
      [StringValue('UTWeap_FlakCannon')]
      FlakCannon,
      [StringValue('UTWeap_SniperRifle')]
      SniperRifle,
      [StringValue('UTWeap_RocketLauncher')]
      RocketLauncher,
      [StringValue('UTWeap_Redeemer')]
      Redeemer,
      [StringValue('UTWeap_InstagibRifle')]
      InstaGibRifle);  
      
    AmmoType = public enum(
      [StringValue('')]
      None = 0,
      [StringValue('UTAmmo_ImpactHammer')]
      ImpactHammer,
      [StringValue('UTAmmo_Enforcer')]
      Enforcer,
      [StringValue('UTAmmo_Translocator')]
      Translocator,
      [StringValue('UTAmmo_BioRifle')]
      BioRifle,
      [StringValue('UTAmmo_ShockRifle')]
      ShockRifle,
      [StringValue('UTAmmo_LinkGun')]
      LinkGun,
      [StringValue('UTAmmo_Stinger')]
      Stinger,
      [StringValue('UTAmmo_Avril')]
      Avril,
      [StringValue('UTAmmo_FlakCannon')]
      FlakCannon,
      [StringValue('UTAmmo_SniperRifle')]
      SniperRifle,
      [StringValue('UTAmmo_RocketLauncher')]
      RocketLauncher,
      [StringValue('UTAmmo_Redeemer')]
      Redeemer,
      [StringValue('UTAmmo_InstagibRifle')]
      InstaGibRifle);  
    
    HealthType = public enum(
      [StringValue('')]
      None = 0,
      [StringValue('UTPickupFactory_MediumHealth')]
      MediBox,
      [StringValue('UTPickupFactory_HealthVial')]
      HealthVial,
      [StringValue('UTPickupFactory_LargeHealth')]
      BigKegOHealth,
      [StringValue('UTPickupFactory_SuperHealth')]
      SuperHealth);  
    
    ArmorType = public enum(
      [StringValue('')]
      None = 0,
      [StringValue('UTArmorPickup_Thighpads')]
      ThighPads,
      [StringValue('UTArmorPickup_Vest')]
      ChestArmour,
      [StringValue('UTArmorPickup_ShieldBelt')]
      ShieldBelt,
      [StringValue('UTArmorPickup_Helmet')]
      Helmet,
      [StringValue('UTPickupFactory_Berserk')]
      Berserk,
      [StringValue('UTPickupFactory_UDamage')]
      MultiplyDamage,
      [StringValue('UTPickupFactory_Invisiblity')]
      Invisibility,
      [StringValue('UTPickupFactory_Invulnerability')]
      Invulnerability,
      [StringValue('UTPickupFactory_JumpBoots')]
      JumpBoots);

implementation


end.
