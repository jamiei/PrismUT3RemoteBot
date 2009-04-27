
// RemObjects CS to Pascal 0.1

namespace UT3Bots;

interface
uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Text,
  System.Diagnostics,
  System.Threading,
  UT3Bots.UTItems,
  UT3Bots.Communications;
type
  UTBot = public abstract class
  private
    const     GAME_PORT: Integer = 4530;
    const     VISUAL_PORT: Integer = 4531;
    var     _utConnection: UT3Connection;
    var     _vizConnection: UT3Connection;
    var     _botCommands: BotCommands;
    var     _botEvents: BotEvents;
    var     _gameState: GameState;
    var     _selfState: UTBotSelfState;
    var     _map: UTMap;
    var     _mainThread: Thread;
    var     _server: String;
    var     _botName: String;
    var     _botSkin: BotMesh;
    var     _botColour: BotColor;
    var     _isRunningBot: Boolean;
    var     _isInGame: Boolean;
    var     _id: UTIdentifier;
    //Set the bot settings
    //Add a trace listener
    //Create the connection to the game server
    //Create the connection to the visualizer server
    //Create the commands and events
    //Start the running thread
    
    method Disconnect();
    method GameErrorOccurred(sender: Object; e: TcpErrorEventArgs);
    method VisualizerErrorOccurred(sender: Object; e: TcpErrorEventArgs);
  assembly
    method GameDataReceived(sender: Object; e: TcpDataEventArgs);
    method VisualizerDataReceived(sender: Object; e: TcpDataEventArgs);
  private
    method ProcessEvent(msg: Message);
    //Return if no valid message
    //Do Command
    //Get the path nodes
    
    method ProcessVizEvent(msg: Message);
    //Return if no valid message
    //Do Command
    
    method PerformGameOver();
    method Run();
  protected
    /// <summary>
    /// This method is where you should put main actions for your bot.
    /// It gets called about twice a second.
    /// </summary>
    
    method ProcessActions();virtual;
  assembly or protected
    constructor UTBot(server: String; botName: String; botSkin: BotMesh; botColour: BotColor);
    /// <summary>
    /// Commands to control your bot
    /// </summary>
    
    property Commands: BotCommands read get_Commands;
    method get_Commands: BotCommands;
    /// <summary>
    /// Events that happen in the game, that you can react to
    /// </summary>
    
    property Events: BotEvents read get_Events;
    method get_Events: BotEvents;
    /// <summary>
    /// The state of the game as seen by your bot
    /// </summary>
    
    property GameState: GameState read get_GameState;
    method get_GameState: GameState;
    /// <summary>
    /// The state of your bot itself
    /// </summary>
    
    property SelfState: UTBotSelfState read get_SelfState;
    method get_SelfState: UTBotSelfState;
    /// <summary>
    /// Information about the Map that the server is running
    /// </summary>
    
    property GameMap: UTMap read get_GameMap;
    method get_GameMap: UTMap;
    /// <summary>
    /// The name of your bot
    /// </summary>
    
    property BotName: String read get_BotName;
    method get_BotName: String;
    /// <summary>
    /// The server you are connected to
    /// </summary>
    
    property Server: String read get_Server;
    method get_Server: String;
    /// <summary>
    /// Has the match begun and is your bot in it?
    /// </summary>
    
    property IsInGame: Boolean read get_IsInGame;
    method get_IsInGame: Boolean;
    /// <summary>
    /// Is the bot working?
    /// </summary>
    
    property IsWorking: Boolean read get_IsWorking;
    method get_IsWorking: Boolean;
  end;


implementation

method UTBot.Disconnect();
begin
  this._utConnection.Disconnect();
  this._vizConnection.Disconnect();
  this._isInGame := false;
  this._isRunningBot := false
end;

method UTBot.GameErrorOccurred(sender: Object; e: TcpErrorEventArgs);
begin
  Trace.WriteLine('There was a problem contacting the server.', &Global.TRACE_ERROR_CATEGORY);
  this.Disconnect()
end;

method UTBot.VisualizerErrorOccurred(sender: Object; e: TcpErrorEventArgs);
begin
  Trace.WriteLine('There was a problem contacting the visualizer server.', &Global.TRACE_ERROR_CATEGORY);
  this.Disconnect()
end;

method UTBot.GameDataReceived(sender: Object; e: TcpDataEventArgs);
begin
  var messages: List<Message> := Message.FromData(System.Text.UTF7Encoding.UTF7.GetString(e.Data));
  for each msg: Message in messages do
  begin
    ProcessEvent(msg)
  end
end;

method UTBot.VisualizerDataReceived(sender: Object; e: TcpDataEventArgs);
begin
  var messages: List<Message> := Message.FromData(System.Text.UTF7Encoding.UTF7.GetString(e.Data));
  for each msg: Message in messages do
  begin
    ProcessVizEvent(msg)
  end
end;

method UTBot.ProcessEvent(msg: Message);
begin
  if msg = nil then
  begin
    exit
  end
  else
  begin
  end;
  case msg.&Eventof
case EventMessage.STATE:begin
      if msg.Info = InfoMessage.SELF_INFO then
      begin
        this._selfState.UpdateState(msg)
      end
      else
      begin
      end;
      this._gameState.UpdateGameState(msg);
      break;
    end;
case EventMessage.INFO:begin
      Trace.WriteLine('Connected to Server ' + _server, &Global.TRACE_NORMAL_CATEGORY);
      this._utConnection.SendLine(Message.BuildMessage(CommandMessage.INITIALIZE, this._botName, this._botSkin.ToString(), (Integer(this._botColour)).ToString()));
      break;
    end;
case EventMessage.MATCH_ENDED:begin
      this._isInGame := false;
      this._botEvents.Trigger_OnMatchEnded(new MatchEndedEventArgs(new UTIdentifier(msg.Arguments[0]), msg.Arguments[1], msg.Arguments[2]));
      PerformGameOver();
      break;
    end;
case EventMessage.WAITING_FOR_SPAWN:begin
      Trace.WriteLine('Match Not Started. Waiting For Spawn...', &Global.TRACE_NORMAL_CATEGORY);
      break;
    end;
case EventMessage.SPAWNED:begin
      this._id := new UTIdentifier(msg.Arguments[1]);
      this._botEvents.Trigger_OnSpawned(new BotSpawnedEventArgs());
      this._isInGame := true;
      break;
    end;
case EventMessage.DIED:begin
      this._isInGame := false;
      this._botEvents.Trigger_OnDied(new HasDiedEventArgs(new UTIdentifier(msg.Arguments[0]), this._id));
      break;
    end;
case EventMessage.KILLED:begin
      this._botEvents.Trigger_OnOtherBotDied(new HasDiedEventArgs(new UTIdentifier(msg.Arguments[0]), new UTIdentifier(msg.Arguments[1])));
      break;
    end;
case EventMessage.SEEN_PLAYER:begin
      if msg.Arguments.Length = 8 then
      begin
        var isReachable: Boolean := not String.IsNullOrEmpty(msg.Arguments[7]);
        this._botEvents.Trigger_OnSeenOtherBot(new SeenBotEventArgs(new UTIdentifier(msg.Arguments[0]), msg.Arguments[1], msg.Arguments[2], msg.Arguments[3], UTVector.Parse(msg.Arguments[4]), UTVector.Parse(msg.Arguments[5]), UTVector.Parse(msg.Arguments[6]), isReachable))
      end
      else
      begin
      end;
      break;
    end;
case EventMessage.BUMPED:begin
      if msg.Arguments.Length = 3 then
      begin
        this._botEvents.Trigger_OnBumped(new BumpedEventArgs(new UTIdentifier(msg.Arguments[0]), UTVector.Parse(msg.Arguments[1]), UTVector.Parse(msg.Arguments[2])))
      end
      else
      begin
      end;
      break;
    end;
case EventMessage.HIT_WALL:begin
      if msg.Arguments.Length = 3 then
      begin
        this._botEvents.Trigger_OnBumpedWall(new BumpedEventArgs(new UTIdentifier(msg.Arguments[0]), UTVector.Parse(msg.Arguments[1]), UTVector.Parse(msg.Arguments[2])))
      end
      else
      begin
      end;
      break;
    end;
case EventMessage.HEARD_NOISE:begin
      if msg.Arguments.Length = 3 then
      begin
        this._botEvents.Trigger_OnHeardNoise(new HeardSoundEventArgs(new UTIdentifier(msg.Arguments[0]), UTVector.Parse(msg.Arguments[1]), Single.Parse(msg.Arguments[2])))
      end
      else
      begin
      end;
      break;
    end;
case EventMessage.DAMAGED:begin
      if msg.Arguments.Length = 5 then
      begin
        this._botEvents.Trigger_OnDamaged(new DamagedEventArgs(new UTIdentifier(msg.Arguments[0]), UTVector.Parse(msg.Arguments[1]), Integer.Parse(msg.Arguments[2]), msg.Arguments[3], UTVector.Parse(msg.Arguments[4])))
      end
      else
      begin
      end;
      break;
    end;
case EventMessage.CHAT:begin
      if msg.Arguments.Length = 4 then
      begin
        this._botEvents.Trigger_OnReceivedChat(new ChatEventArgs(new UTIdentifier(msg.Arguments[0]), msg.Arguments[1], Boolean.Parse(msg.Arguments[2]), msg.Arguments[3]))
      end
      else
      begin
      end;
      break;
    end;
case EventMessage.FOUNDFALL:begin
      if msg.Arguments.Length = 2 then
      begin
        this._botEvents.Trigger_OnFoundFall(new FallEventArgs(Boolean.Parse(msg.Arguments[0]), UTVector.Parse(msg.Arguments[1])))
      end
      else
      begin
      end;
      break;
    end;
case EventMessage.TAUNTED:begin
      if msg.Arguments.Length = 2 then
      begin
        this._botEvents.Trigger_OnTaunted(new TauntedEventArgs(new UTIdentifier(msg.Arguments[0]), msg.Arguments[1]))
      end
      else
      begin
      end;
      break;
    end;
case EventMessage.WEAPON_CHANGED:begin
      if msg.Arguments.Length = 2 then
      begin
        this._botEvents.Trigger_OnWeaponChanged(new WeaponChangedEventArgs(new UTIdentifier(msg.Arguments[0]), msg.Arguments[1]))
      end
      else
      begin
      end;
      break;
    end;
case EventMessage.GOT_PICKUP:begin
      if msg.Arguments.Length = 3 then
      begin
        this._botEvents.Trigger_OnGotPickup(new PickupEventArgs(this._selfState.AddInventoryItem(msg), Boolean.Parse(msg.Arguments[2])))
      end
      else
      begin
      end;
      break;
    end;
case EventMessage.PATH:begin
      if msg.Arguments.Length > 0 and (msg.Arguments.Length - 1) mod 2 = 0 then
      begin
        var id: String := msg.Arguments[0];
        var nodes: List<UTNavPoint> := new List<UTNavPoint>();
        begin {C# for loop};
          while i < msg.Arguments.Length do begin
            nodes.&Add(new UTNavPoint(new UTIdentifier(msg.Arguments[i]), UTVector.Parse(msg.Arguments[i + 1]), true));
            { This is the for loop test, note that continue will skip this, while it shouldn't }
            i := i + 2;
          end        end;
        this._botEvents.Trigger_OnPathReceived(new PathEventArgs(id, nodes))
      end
      else
      begin
      end;
      break;
    end;
  end
end;

method UTBot.ProcessVizEvent(msg: Message);
begin
  if msg = nil then
  begin
    exit
  end
  else
  begin
  end;
  case msg.&Eventof
case EventMessage.STATE:begin
      if msg.Info = InfoMessage.NAV_INFO or msg.Info = InfoMessage.PICKUP_INFO then
      begin
        this._map.UpdateState(msg)
      end
      else
      begin
      end;
      break;
    end;
  end
end;

method UTBot.PerformGameOver();
begin
  this._gameState.PrintScores(Console.&Out);
  this.Disconnect()
end;

method UTBot.Run();
begin
  while this._isRunningBotdo
  begin
    if this._isInGame then
    begin
      ProcessActions()
    end
    else
    begin
    end;
    Thread.Sleep(500)
  end
end;

method UTBot.ProcessActions();
begin
end;

constructor UTBot.UTBot(server: String; botName: String; botSkin: BotMesh; botColour: BotColor);
begin
  this._server := server;
  this._botName := botName;
  this._botSkin := botSkin;
  this._botColour := botColour;
  this._isRunningBot := true;
  this._isInGame := false;
  var tl: TextWriterTraceListener := new TextWriterTraceListener(Console.&Out);
  Trace.Listeners.&Add(tl);
  this._utConnection := new UT3Connection(server, GAME_PORT);
  this._utConnection.OnDataReceived := this._utConnection.OnDataReceived + new EventHandler<TcpDataEventArgs>(GameDataReceived);
  this._utConnection.OnErrorOccurred := this._utConnection.OnErrorOccurred + new EventHandler<TcpErrorEventArgs>(GameErrorOccurred);
  this._vizConnection := new UT3Connection(server, VISUAL_PORT);
  this._vizConnection.OnDataReceived := this._vizConnection.OnDataReceived + new EventHandler<TcpDataEventArgs>(VisualizerDataReceived);
  this._vizConnection.OnErrorOccurred := this._vizConnection.OnErrorOccurred + new EventHandler<TcpErrorEventArgs>(VisualizerErrorOccurred);
  this._botCommands := new BotCommands(this, this._utConnection);
  this._botEvents := new BotEvents(this);
  this._gameState := new GameState();
  this._selfState := new UTBotSelfState(new Message(''));
  this._map := new UTMap(this._selfState);
  this._mainThread := new Thread(new ThreadStart(Run));
  this._mainThread.IsBackground := false;
  this._mainThread.Start()
end;

method UTBot.get_Commands: BotCommands;
begin
  exit this._botCommands
end;

method UTBot.get_Events: BotEvents;
begin
  exit this._botEvents
end;

method UTBot.get_GameState: GameState;
begin
  exit this._gameState
end;

method UTBot.get_SelfState: UTBotSelfState;
begin
  exit this._selfState
end;

method UTBot.get_GameMap: UTMap;
begin
  exit this._map
end;

method UTBot.get_BotName: String;
begin
  exit _botName
end;

method UTBot.get_Server: String;
begin
  exit _server
end;

method UTBot.get_IsInGame: Boolean;
begin
  exit _isInGame
end;

method UTBot.get_IsWorking: Boolean;
begin
  exit _isRunningBot
end;


end.
