
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
    
    method _vizConnection_OnErrorOccurred(sender: Object; e: TcpErrorEventArgs);
    method _vizConnection_OnDataReceived(sender: Object; e: TcpDataEventArgs);
    method _utConnection_OnErrorOccurred(sender: Object; e: TcpErrorEventArgs);
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
    
    method ProcessActions(); virtual;
  public
    constructor(server: String; botName: String; botSkin: BotMesh; botColour: BotColor);
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
  Self._utConnection.Disconnect();
  Self._vizConnection.Disconnect();
  Self._isInGame := false;
  Self._isRunningBot := false
end;

method UTBot.GameErrorOccurred(sender: Object; e: TcpErrorEventArgs);
begin
  Trace.WriteLine('There was a problem contacting the server.', &Global.TRACE_ERROR_CATEGORY);
  Self.Disconnect()
end;

method UTBot.VisualizerErrorOccurred(sender: Object; e: TcpErrorEventArgs);
begin
  Trace.WriteLine('There was a problem contacting the visualizer server.', &Global.TRACE_ERROR_CATEGORY);
  Self.Disconnect()
end;

method UTBot.GameDataReceived(sender: Object; e: TcpDataEventArgs);
begin
  var messages: List<Message> := Message.FromData(System.Text.UTF7Encoding.UTF7.GetString(e.Data));
  for each msg: Message in messages do
  begin
    ProcessEvent(msg);
  end;
end;

method UTBot.VisualizerDataReceived(sender: Object; e: TcpDataEventArgs);
begin
  var messages: List<Message> := Message.FromData(System.Text.UTF7Encoding.UTF7.GetString(e.Data));
  for each msg: Message in messages do
  begin
    ProcessVizEvent(msg);
  end;
end;

method UTBot.ProcessEvent(msg: Message);
var
   i: Integer;
begin
  if msg = nil then
  begin
    exit;
  end;

  case (msg.Event) of
    EventMessage.BUMPED: 
      begin
        if msg.Arguments.Length = 3 then
        begin
          Self._botEvents.Trigger_OnBumped(new BumpedEventArgs(new UTIdentifier(msg.Arguments[0]), UTVector.Parse(msg.Arguments[1]), UTVector.Parse(msg.Arguments[2])))
        end;
      end;
    EventMessage.CHAT: 
      begin
        if msg.Arguments.Length = 4 then
        begin
          Self._botEvents.Trigger_OnReceivedChat(new ChatEventArgs(new UTIdentifier(msg.Arguments[0]), msg.Arguments[1], Boolean.Parse(msg.Arguments[2]), msg.Arguments[3]))
        end;
      end;
    EventMessage.DAMAGED:
      begin
        if msg.Arguments.Length = 5 then
        begin
          Self._botEvents.Trigger_OnDamaged(new DamagedEventArgs(new UTIdentifier(msg.Arguments[0]), UTVector.Parse(msg.Arguments[1]), Integer.Parse(msg.Arguments[2]), msg.Arguments[3], UTVector.Parse(msg.Arguments[4])))
        end;
      end;
    EventMessage.DIED: 
      begin
        Self._isInGame := false;
        Self._botEvents.Trigger_OnDied(new HasDiedEventArgs(new UTIdentifier(msg.Arguments[0]), Self._id));
      end;
    EventMessage.FOUNDFALL: 
      begin
        if msg.Arguments.Length = 2 then
        begin
          Self._botEvents.Trigger_OnFoundFall(new FallEventArgs(Boolean.Parse(msg.Arguments[0]), UTVector.Parse(msg.Arguments[1])))
        end;
      end;
    EventMessage.GOT_PICKUP: 
      begin
        if msg.Arguments.Length = 3 then
        begin
          Self._botEvents.Trigger_OnGotPickup(new PickupEventArgs(Self._selfState.AddInventoryItem(msg), Boolean.Parse(msg.Arguments[2])))
        end;
      end;
    EventMessage.HEARD_NOISE: 
      begin
        if msg.Arguments.Length = 3 then
        begin
          Self._botEvents.Trigger_OnHeardNoise(new HeardSoundEventArgs(new UTIdentifier(msg.Arguments[0]), UTVector.Parse(msg.Arguments[1]), Single.Parse(msg.Arguments[2])))
        end;
      end;
    EventMessage.HIT_WALL: 
      begin
        if msg.Arguments.Length = 3 then
        begin
          Self._botEvents.Trigger_OnBumpedWall(new BumpedEventArgs(new UTIdentifier(msg.Arguments[0]), UTVector.Parse(msg.Arguments[1]), UTVector.Parse(msg.Arguments[2])))
        end;
      end;
    EventMessage.INFO: 
      begin
        Trace.WriteLine('Connected to Server ' + _server, &Global.TRACE_NORMAL_CATEGORY);
        Self._utConnection.SendLine(Message.BuildMessage(CommandMessage.INITIALIZE, Self._botName, Self._botSkin.ToString(), (Integer(Self._botColour)).ToString()));
      end;
    EventMessage.KILLED:
      begin
        Self._botEvents.Trigger_OnOtherBotDied(new HasDiedEventArgs(new UTIdentifier(msg.Arguments[0]), new UTIdentifier(msg.Arguments[1])));
      end;
    EventMessage.MATCH_ENDED: 
      begin
        Self._isInGame := false;
        Self._botEvents.Trigger_OnMatchEnded(new MatchEndedEventArgs(new UTIdentifier(msg.Arguments[0]), msg.Arguments[1], msg.Arguments[2]));
        PerformGameOver();
      end;
    EventMessage.PATH: 
      begin
        if ((msg.Arguments.Length > 0) and ((msg.Arguments.Length - 1) mod 2 = 0)) then
        begin
          var id: String := msg.Arguments[0];
          var nodes: List<UTNavPoint> := new List<UTNavPoint>();
          begin;
            i := 1;
            while (i < msg.Arguments.Length) do
            begin
              nodes.&Add(new UTNavPoint(new UTIdentifier(msg.Arguments[i]), UTVector.Parse(msg.Arguments[i + 1]), true));
              i := i + 2;
            end;      
          end;
          Self._botEvents.Trigger_OnPathReceived(new PathEventArgs(id, nodes))
        end;
      end;
    EventMessage.SEEN_PLAYER: 
      begin
        if msg.Arguments.Length = 8 then
        begin
          var isReachable: Boolean := not String.IsNullOrEmpty(msg.Arguments[7]);
          Self._botEvents.Trigger_OnSeenOtherBot(new SeenBotEventArgs(new UTIdentifier(msg.Arguments[0]), msg.Arguments[1], msg.Arguments[2], msg.Arguments[3], UTVector.Parse(msg.Arguments[4]), UTVector.Parse(msg.Arguments[5]), UTVector.Parse(msg.Arguments[6]), isReachable))
        end;
      end;
    EventMessage.SPAWNED: 
      begin
        Self._id := new UTIdentifier(msg.Arguments[1]);
        Self._botEvents.Trigger_OnSpawned(new BotSpawnedEventArgs());
        Self._isInGame := true;
      end;
    EventMessage.STATE: 
      begin
        if msg.Info = InfoMessage.SELF_INFO then
        begin
          Self._selfState.UpdateState(msg)
        end;
        Self._gameState.UpdateGameState(msg);
      end;
    EventMessage.TAUNTED: 
      begin
        if msg.Arguments.Length = 2 then
        begin
          Self._botEvents.Trigger_OnTaunted(new TauntedEventArgs(new UTIdentifier(msg.Arguments[0]), msg.Arguments[1]))
        end;
      end;
    EventMessage.WAITING_FOR_SPAWN: 
      begin
        Trace.WriteLine('Match Not Started. Waiting For Spawn...', &Global.TRACE_NORMAL_CATEGORY);
      end;
    EventMessage.WEAPON_CHANGED: 
      begin
        if msg.Arguments.Length = 2 then
        begin
          Self._botEvents.Trigger_OnWeaponChanged(new WeaponChangedEventArgs(new UTIdentifier(msg.Arguments[0]), msg.Arguments[1]))
        end;
      end;
  end; // case (msg.Event) of
end;

method UTBot.ProcessVizEvent(msg: Message);
begin
  // Return if no valid message
  if msg = nil then
  begin
    exit;
  end;
  // Do Command
  case (msg.Event) of
    EventMessage.STATE: 
      begin
        if ((msg.Info = InfoMessage.NAV_INFO) or (msg.Info = InfoMessage.PICKUP_INFO)) then
        begin
          Self._map.UpdateState(msg)
        end;
      end;
  end; // case (msg.Event) of
end;

method UTBot.PerformGameOver();
begin
  Self._gameState.PrintScores(Console.&Out);
  Self.Disconnect()
end;

method UTBot.Run();
begin
  while Self._isRunningBot do
  begin
    if Self._isInGame then
    begin
      ProcessActions();
    end;
    Thread.Sleep(500);
  end;
end;

method UTBot.ProcessActions();
begin
end;

constructor UTBot(server: String; botName: String; botSkin: BotMesh; botColour: BotColor);
begin
  Self._server := server;
  Self._botName := botName;
  Self._botSkin := botSkin;
  Self._botColour := botColour;
  Self._isRunningBot := true;
  Self._isInGame := false;
  var tl: TextWriterTraceListener := new TextWriterTraceListener(Console.&Out);
  Trace.Listeners.&Add(tl);
  Self._utConnection := new UT3Connection(server, GAME_PORT);
  Self._utConnection.OnDataReceived += @GameDataReceived;
  Self._utConnection.OnErrorOccurred += @GameErrorOccurred;
  Self._vizConnection := new UT3Connection(server, VISUAL_PORT);
  Self._vizConnection.OnDataReceived += @VisualizerDataReceived;
  Self._vizConnection.OnErrorOccurred += @VisualizerErrorOccurred;
  Self._botCommands := new BotCommands(Self, Self._utConnection);
  Self._botEvents := new BotEvents(Self);
  Self._gameState := new GameState();
  Self._selfState := new UTBotSelfState(new Message(''));
  Self._map := new UTMap(Self._selfState);
  Self._mainThread := new Thread(new ThreadStart(Run));
  Self._mainThread.IsBackground := false;
  Self._mainThread.Start()
end;

method UTBot.get_Commands: BotCommands;
begin
  Result := Self._botCommands;
end;

method UTBot.get_Events: BotEvents;
begin
  Result := Self._botEvents;
end;

method UTBot.get_GameState: GameState;
begin
  Result := Self._gameState;
end;

method UTBot.get_SelfState: UTBotSelfState;
begin
  Result := Self._selfState;
end;

method UTBot.get_GameMap: UTMap;
begin
  Result := Self._map;
end;

method UTBot.get_BotName: String;
begin
  Result := Self._botName;
end;

method UTBot.get_Server: String;
begin
  Result := Self._server;
end;

method UTBot.get_IsInGame: Boolean;
begin
  Result := Self._isInGame;
end;

method UTBot.get_IsWorking: Boolean;
begin
  Result := Self._isRunningBot;
end;


method UTBot._utConnection_OnErrorOccurred(sender: Object; e: TcpErrorEventArgs);
begin
end;

method UTBot._vizConnection_OnDataReceived(sender: Object; e: TcpDataEventArgs);
begin
end;

method UTBot._vizConnection_OnErrorOccurred(sender: Object; e: TcpErrorEventArgs);
begin
end;

end.
