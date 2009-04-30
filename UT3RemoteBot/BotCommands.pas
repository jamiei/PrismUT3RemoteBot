
// RemObjects CS to Pascal 0.1

namespace UT3Bots;

interface
uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Text,
  UT3Bots.UTItems,
  UT3Bots.Communications;
type
  BotCommands = public class
  private
    var     _utBot: UTBot;
    var     _utConnection: UT3Connection;
  assembly or protected
    /// <summary>
    /// Command your bot to shoot in the direction it is facing
    /// </summary>
    /// <param name="useSecondaryFire">True if you want to use the Alternative Fire of your current gun instead of its primary fire</param>
    
    method StartFiring(useSecondaryFire: Boolean);
    /// <summary>
    /// Command your bot to shoot at a specific location
    /// </summary>
    /// <param name="Location">The location to fire at</param>
    /// <param name="useSecondaryFire">True if you want to use the Alternative Fire of your current gun instead of its primary fire</param>
    
    method StartFiring(Location: UTVector; useSecondaryFire: Boolean);
    /// <summary>
    /// Command your bot to shoot at a specific target
    /// </summary>
    /// <param name="Target">The target to fire at</param>
    /// <param name="useSecondaryFire">True if you want to use the Alternative Fire of your current gun instead of its primary fire</param>
    
    method StartFiring(Target: UTIdentifier; useSecondaryFire: Boolean);
    /// <summary>
    /// Command your bot to stop shooting
    /// </summary>
    
    method StopFiring();
    /// <summary>
    /// Command your bot to stop moving
    /// </summary>
    
    method StopMoving();
    /// <summary>
    /// Command your bot to jump
    /// </summary>
    
    method Jump();
    /// <summary>
    /// Command your bot to automatically turn towards and move directly to the destination
    /// </summary>
    /// <param name="Location">The location you want to go to (The location must be visible to you when the command is recieved or your bot will do nothing.)</param>
    
    method RunTo(Location: UTVector);
    /// <summary>
    /// Command your bot to automatically turn towards and move directly to the destination
    /// </summary>
    /// <param name="Target">The target you want to go to (The object must be visible to you when the command is recieved or your bot will do nothing.)</param>
    
    method RunTo(Target: UTIdentifier);
    /// <summary>
    /// Command your bot to move towards a destination while facing another object
    /// </summary>
    /// <param name="Location">The location that you want to move to</param>
    /// <param name="Target">The object you want to face while moving  (The object must be visible to you when the command is recieved or your bot will do nothing.)</param>
    
    method StrafeTo(Location: UTVector; Target: UTIdentifier);
    /// <summary>
    /// Command your bot to move towards a destination while facing another location
    /// </summary>
    /// <param name="Location">The location that you want to move to</param>
    /// <param name="Target">The target you want to face while moving  (The target must be visible to you when the command is recieved or your bot will do nothing.)</param>
    
    method StrafeTo(Location: UTVector; Target: UTVector);
    /// <summary>
    /// Command your bot to turn to face a specified location
    /// </summary>
    /// <param name="Location">The location you want to turn to</param>
    
    method RotateTo(Location: UTVector);
    /// <summary>
    /// Command your bot to turn to face a specified object
    /// </summary>
    /// <param name="Target">The object you want to turn to</param>
    
    method RotateTo(Target: UTIdentifier);
    /// <summary>
    /// Command your bot to turn to face a specified angle
    /// </summary>
    /// <param name="Target">The angle you want to turn to in degrees</param>
    
    method RotateTo(Degrees: Integer);
    //(2pi = 65535 UT units)
    /// <summary>
    /// Command your bot to turn a specified amount
    /// </summary>
    /// <param name="Degrees">The number of degrees your want to turn from where you are facing at the moment</param>
    
    method RotateBy(Degrees: Integer);
    //(2pi = 65535 UT units)
    /// <summary>
    /// Send a chat message to the server
    /// </summary>
    /// <param name="Message">The message you want to send</param>
    /// <param name="SendToTeam">True if you want to only send this to your team</param>
    
    method SendChatMessage(Message: String; SendToTeam: Boolean);
    /// <summary>
    /// Taunt a player with the built in voice taunts
    /// </summary>
    /// <param name="Target">The ID of the player you want to taunt (this must be a valid player, or nothing will happen)</param>
    
    method SendTauntMessage(Target: UTIdentifier);
    /// <summary>
    /// Just killed someone? Why not taunt them with some fetching pelvic thrusts!
    /// </summary>
    /// <param name="Emote">The emote you want to send</param>
    
    method PerformEmote(Emote: Emote);
    /// <summary>
    /// Set whether you are walking or running (default is run). 
    /// Walking means you move at about 1/3 normal speed, make less noise, and won't fall off ledges
    /// </summary>
    /// <param name="UseWalk">Send True to go into walk mode or False to go into run mode</param>
    
    method SetMovingSpeed(UseWalk: Boolean);
    /// <summary>
    /// Command your bot to change to its most powerful weapon
    /// </summary>
    
    method ChangeWeapon();
    /// <summary>
    /// Command your bot to change to a specific weapon 
    /// The weapon will be changed if you have this weapon in your inventory and it has ammo left
    /// </summary>
    /// <param name="Weapon">The Weapon ID you want to switch to</param>
    
    method ChangeWeapon(Weapon: UTIdentifier);
    /// <summary>
    /// Get a path to a specified target. 
    /// An ordered list of nay points will be returned to you via the OnPathReceived() event that you should attach to
    /// </summary>
    /// <param name="Id">A message ID made up by you and echoed in respose so you can match up response with query</param>
    /// <param name="Target">The target you would like to go to</param>
    
    method GetPath(Id: String; Target: UTIdentifier);
    /// <summary>
    /// Get a path to a specified location. 
    /// An ordered list of nay points will be returned to you via the OnPathReceived() event that you should attach to
    /// </summary>
    /// <param name="Id">A message ID made up by you and echoed in respose so you can match up response with query</param>
    /// <param name="Location">The location you would like to go to</param>
    
    method GetPath(Id: String; Location: UTVector);
    constructor (Bot: UTBot; Connection: UT3Connection);
  end;


implementation

method BotCommands.StartFiring(useSecondaryFire: Boolean);
begin
  Self._utConnection.SendLine(Message.BuildMessage(CommandMessage.FIRE, 'None', useSecondaryFire.ToString()))
end;

method BotCommands.StartFiring(Location: UTVector; useSecondaryFire: Boolean);
begin
  Self._utConnection.SendLine(Message.BuildMessage(CommandMessage.FIRE, Location.ToString(), useSecondaryFire.ToString()))
end;

method BotCommands.StartFiring(Target: UTIdentifier; useSecondaryFire: Boolean);
begin
  Self._utConnection.SendLine(Message.BuildMessage(CommandMessage.FIRE, Target.ToString(), useSecondaryFire.ToString()))
end;

method BotCommands.StopFiring();
begin
  Self._utConnection.SendLine(Message.BuildMessage(CommandMessage.STOP_FIRE))
end;

method BotCommands.StopMoving();
begin
  Self._utConnection.SendLine(Message.BuildMessage(CommandMessage.STOP))
end;

method BotCommands.Jump();
begin
  Self._utConnection.SendLine(Message.BuildMessage(CommandMessage.JUMP))
end;

method BotCommands.RunTo(Location: UTVector);
begin
  Self._utConnection.SendLine(Message.BuildMessage(CommandMessage.RUN_TO, '0.0', '0.0', Location.ToString()))
end;

method BotCommands.RunTo(Target: UTIdentifier);
begin
  Self._utConnection.SendLine(Message.BuildMessage(CommandMessage.RUN_TO, '0.0', '0.0', Target.ToString()))
end;

method BotCommands.StrafeTo(Location: UTVector; Target: UTIdentifier);
begin
  Self._utConnection.SendLine(Message.BuildMessage(CommandMessage.STRAFE_TO, Location.ToString(), Target.ToString()))
end;

method BotCommands.StrafeTo(Location: UTVector; Target: UTVector);
begin
  Self._utConnection.SendLine(Message.BuildMessage(CommandMessage.STRAFE_TO, Location.ToString(), Target.ToString()))
end;

method BotCommands.RotateTo(Location: UTVector);
begin
  Self._utConnection.SendLine(Message.BuildMessage(CommandMessage.ROTATE_TO, Location.ToString(), 'Location'))
end;

method BotCommands.RotateTo(Target: UTIdentifier);
begin
  Self._utConnection.SendLine(Message.BuildMessage(CommandMessage.ROTATE_TO, Target.ToString(), 'Target'))
end;

method BotCommands.RotateTo(Degrees: Integer);
begin
  Degrees := Degrees mod 360;
  var units: Integer := Integer(((Degrees / 360) * 65535));
  Self._utConnection.SendLine(Message.BuildMessage(CommandMessage.ROTATE_TO, units.ToString(), 'Rotation'))
end;

method BotCommands.RotateBy(Degrees: Integer);
begin
  Degrees := Degrees mod 360;
  var units: Integer := Integer(((Degrees / 360) * 65535));
  Self._utConnection.SendLine(Message.BuildMessage(CommandMessage.ROTATE_BY, units.ToString(), 'Horizontal'))
end;

method BotCommands.SendChatMessage(Message: String; SendToTeam: Boolean);
begin
  Message := Message.Replace(#13, ' ');
  Message := Message.Replace(#10, ' ');
  Message := Message.Replace('|', ' ');
  Self._utConnection.SendLine(Communications.Message.BuildMessage(CommandMessage.SENDCHAT, Message, iif(SendToTeam, 'Team', 'Global')))
end;

method BotCommands.SendTauntMessage(Target: UTIdentifier);
begin
  if Target <> nil then
  begin
    Self._utConnection.SendLine(Communications.Message.BuildMessage(CommandMessage.SENDTAUNT, Target.ToString()))
  end;
end;

method BotCommands.PerformEmote(Emote: Emote);
begin
  Self._utConnection.SendLine(Communications.Message.BuildMessage(CommandMessage.SENDEMOTE, Emote.GetStringValue()))
end;

method BotCommands.SetMovingSpeed(UseWalk: Boolean);
begin
  Self._utConnection.SendLine(Message.BuildMessage(CommandMessage.SETWALK, UseWalk.ToString()))
end;

method BotCommands.ChangeWeapon();
begin
  Self._utConnection.SendLine(Communications.Message.BuildMessage(CommandMessage.CHANGE_WEAPON, 'BEST'))
end;

method BotCommands.ChangeWeapon(Weapon: UTIdentifier);
begin
  Self._utConnection.SendLine(Communications.Message.BuildMessage(CommandMessage.CHANGE_WEAPON, Weapon.ToString()))
end;

method BotCommands.GetPath(Id: String; Target: UTIdentifier);
begin
  if Target <> nil then
  begin
    Self._utConnection.SendLine(Communications.Message.BuildMessage(CommandMessage.GET_PATH, Id, Target.ToString()))
  end;
end;

method BotCommands.GetPath(Id: String; Location: UTVector);
begin
  Self._utConnection.SendLine(Communications.Message.BuildMessage(CommandMessage.GET_PATH, Id, Location.ToString()))
end;

constructor BotCommands(Bot: UTBot; Connection: UT3Connection);
begin
  Self._utBot := Bot;
  Self._utConnection := Connection
end;


end.
