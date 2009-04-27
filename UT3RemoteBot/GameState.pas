
// RemObjects CS to Pascal 0.1

namespace UT3Bots;

interface
uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Text,
  UT3Bots.UTItems,
  UT3Bots.Communications,
  System.IO;
type
  GameState = public class
  private
    class var     CHECK_INTERVAL: TimeSpan := new TimeSpan(0, 2, 0); readonly;
    //States in the current Game
    
    var     _oppList: List<UTBotOppState> := new List<UTBotOppState>();
    var     _invList: List<UTItemPoint> := new List<UTItemPoint>();
    var     _navList: List<UTNavPoint> := new List<UTNavPoint>();
    var     _scores: Dictionary<UTIdentifier, UTPlayerScore> := new Dictionary<UTIdentifier, UTPlayerScore>();
    var     _selfId: UTIdentifier;
    var     _fragLimit: Integer;
    var     _lastCheckTime: DateTime;
  assembly
    method UpdateGameState(MessageQueue: Queue<Message>);
    method UpdateGameState(msg: Message);
    method Clear();
    method SetScores(msg: Message);
  private
    method RemoveOldScores();
  assembly
    //Make sure that we arent holding scores for bots that have disconnected
    
    method PrintScores(output: TextWriter);
  assembly or protected
    /// <summary>
    /// Get a Bot's name from a given Id
    /// </summary>
    /// <param name="BotID">The Id to search for</param>
    /// <returns>The name of the bot with this id, or "" if the BotId isnt in the game</returns>
    
    method GetBotNameFromID(BotId: UTIdentifier): String;
    /// <summary>
    /// Check to see if a specified Id is from a Bot
    /// </summary>
    /// <param name="Id">The Id to check</param>
    /// <returns>True if the Id belongs to a Bot, false otherwise</returns>
    
    method IsBot(Id: UTIdentifier): Boolean;
  assembly
    //Constructor
    
    constructor GameState();
    /// <summary>
    /// List of UTBotOppState containing all the Opponent Bots that you can currently see
    /// </summary>
    
    property PlayersVisible: List<UTBotOppState> read get_PlayersVisible;
    method get_PlayersVisible: List<UTBotOppState>;
    /// <summary>
    /// List of UTInvItem containing all the inventory item pickups that you can currently see
    /// </summary>
    
    property ItemsVisible: List<UTItemPoint> read get_ItemsVisible;
    method get_ItemsVisible: List<UTItemPoint>;
    /// <summary>
    /// List of UTNavPoint containing all the Navigation Points you can currently see
    /// </summary>
    
    property NavPointsVisible: List<UTNavPoint> read get_NavPointsVisible;
    method get_NavPointsVisible: List<UTNavPoint>;
    /// <summary>
    /// List of UTPlayerScore containing all the bots in the game and their scores
    /// </summary>
    
    property CurrentScores: List<UTPlayerScore> read get_CurrentScores;
    method get_CurrentScores: List<UTPlayerScore>;
    property FragLimit: Integer read get_FragLimit write set_FragLimit;
    method get_FragLimit: Integer;
    method set_FragLimit(value: Integer);
  end;


implementation

method GameState.UpdateGameState(MessageQueue: Queue<Message>);
begin
  while MessageQueue.Count > 0do
  begin
    var m: Message := Message(MessageQueue.Dequeue());
    UpdateGameState(m)
  end
end;

method GameState.UpdateGameState(msg: Message);
begin
  case msg.Info of

      case InfoMessage.&BEGIN:
      begin
        this.Clear();
        break;
      end;

      case InfoMessage.&END:    
      break;

      case InfoMessage.PLAYER_INFO:
      begin
        var playerSeen: UTBotOppState := new UTBotOppState(msg);
        Self._oppList.&Add(playerSeen);
        break;
      end;

      case InfoMessage.SELF_INFO:
      begin
        if this._selfId = nil then
        begin
          this._selfId := new UTIdentifier(msg.Arguments[0])
        end;
        break;
      end;

      case InfoMessage.NAV_INFO:
      begin
        var nav: UTNavPoint := new UTNavPoint(new UTIdentifier(msg.Arguments[0]), UTVector.Parse(msg.Arguments[1]), Boolean.Parse(msg.Arguments[2]));
        this._navList.&Add(nav);
        break;
      end;

      case InfoMessage.PICKUP_INFO:
      begin
        var item: UTItemPoint := new UTItemPoint(new UTIdentifier(msg.Arguments[0]), UTVector.Parse(msg.Arguments[1]), msg.Arguments[2], Boolean.Parse(msg.Arguments[3]), Boolean.Parse(msg.Arguments[4]));
        this._invList.&Add(item);
        break;
      end;

      case InfoMessage.GAME_INFO:    
      break;
      
      case InfoMessage.SCORE_INFO:
      begin
        SetScores(msg);
        if DateTime.Now > _lastCheckTime + CHECK_INTERVAL then
        begin
          RemoveOldScores();
          _lastCheckTime := DateTime.Now
        end;
        break;
      end;
end;

method GameState.Clear();
begin
  this._oppList.Clear();
  this._invList.Clear();
  this._navList.Clear()
end;

method GameState.SetScores(msg: Message);
begin
  for each scoreInfo: String in msg.Arguments do
  begin
    var info: array of String := scoreInfo.Split(Message.MESSAGE_SUBSEPARATOR);
    if info.Length = 3 then
    begin
      var id: UTIdentifier := new UTIdentifier(info[0]);
      var score: Integer := Integer(Single.Parse(info[2]));
      if this._scores.ContainsKey(id) then
      begin
        this._scores[id].SetScore(score)
      end
      else
      begin
        this._scores.&Add(id, new UTPlayerScore(id, info[1], score))
      end
    end
    else
    begin
    end
  end
end;

method GameState.RemoveOldScores();
begin
  var oldScores: List<UTPlayerScore> := new List<UTPlayerScore>();
  for each score: UTPlayerScore in this._scores.Values do
  begin
    if score.LastUpdated < DateTime.Now - CHECK_INTERVAL then
    begin
      oldScores.&Add(score)
    end
    else
    begin
    end
  end;
  for each score: UTPlayerScore in oldScores do
  begin
    this._scores.&Remove(score.Id)
  end
end;

method GameState.PrintScores(output: TextWriter);
begin
  var idTitle: String := 'ID';
  var nameTitle: String := 'Name';
  var scoreTitle: String := 'Score';
  output.WriteLine(#13#13 + new String('-', 65) + #13);
  output.WriteLine('End Of Game Scores Were:'#13);
  output.WriteLine(idTitle.PadRight(30) + ' ' + nameTitle.PadRight(30) + ' ' + scoreTitle);
  var scores: IOrderedEnumerable<KeyValuePair<UTIdentifier, UTPlayerScore>> := this._scores.OrderBy(score := );
  Score;
  for each keyValue: KeyValuePair<UTIdentifier, UTPlayerScore> in scores do
  begin
    output.WriteLine(keyValue.Value.ToString() + (iif(keyValue.Key = this._selfId, '     *YOU*', '')))
  end
end;

method GameState.GetBotNameFromID(BotId: UTIdentifier): String;
begin
  if this._scores.ContainsKey(BotId) then
  begin
    exit this._scores[BotId].Name
  end
  else
  begin
  end;
  exit ''
end;

method GameState.IsBot(Id: UTIdentifier): Boolean;
begin
  exit this._scores.ContainsKey(Id)
end;

constructor GameState.GameState();
begin
end;

method GameState.get_PlayersVisible: List<UTBotOppState>;
begin
  exit this._oppList
end;

method GameState.get_ItemsVisible: List<UTItemPoint>;
begin
  exit this._invList
end;

method GameState.get_NavPointsVisible: List<UTNavPoint>;
begin
  exit this._navList
end;

method GameState.get_CurrentScores: List<UTPlayerScore>;
begin
  exit this._scores.Values.ToList()
end;

method GameState.get_FragLimit: Integer;
begin
  exit this._fragLimit
end;

method GameState.set_FragLimit(value: Integer);
begin
  this._fragLimit := value
end;


end.
