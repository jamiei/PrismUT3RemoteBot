
// RemObjects CS to Pascal 0.1

namespace UT3Bots.UTItems;

interface
uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Text,
  System.ComponentModel;
type
  UTPlayerScore = public class(IComparable<UTPlayerScore>, INotifyPropertyChanged)
  private
    //Private members
    
    var     _id: UTIdentifier;
    var     _name: String;
    var     _score: Integer;
    var     _lastUpdated: DateTime;
  assembly
    method SetScore(NewScore: Integer);
  assembly or protected
    method ToString(): String;override;
    method CompareTo(other: UTPlayerScore): Integer;
  protected
    method OnPropertyChanged(propName: String);virtual;
  assembly
    constructor UTPlayerScore(Id: UTIdentifier; Name: String; Score: Integer);
    property Id: UTIdentifier read get_Id;
    method get_Id: UTIdentifier;
    property Name: String read get_Name;
    method get_Name: String;
    property Score: Integer read get_Score;
    method get_Score: Integer;
    property LastUpdated: DateTime read get_LastUpdated;
    method get_LastUpdated: DateTime;
    event PropertyChanged: PropertyChangedEventHandler;
  end;


implementation

method UTPlayerScore.SetScore(NewScore: Integer);
begin
  this._score := NewScore;
  this._lastUpdated := DateTime.Now;
  OnPropertyChanged('Score')
end;

method UTPlayerScore.ToString(): String;
begin
  exit this._id.ToString().PadRight(30) + ' ' + this._name.PadRight(30) + ' ' + this._score
end;

method UTPlayerScore.CompareTo(other: UTPlayerScore): Integer;
begin
  if this._score > other._score then
  begin
    exit -1
  end
  else
  begin
    if this._score < other._score then
    begin
      exit 1
    end
    else
    begin
      exit this._id.CompareTo(other._id)
    end
  end
end;

method UTPlayerScore.OnPropertyChanged(propName: String);
begin
  if PropertyChanged <> nil then
  begin
    PropertyChanged(this, new PropertyChangedEventArgs(propName))
  end
  else
  begin
  end
end;

constructor UTPlayerScore.UTPlayerScore(Id: UTIdentifier; Name: String; Score: Integer);
begin
  this._id := Id;
  this._name := Name;
  this._score := Score
end;

method UTPlayerScore.get_Id: UTIdentifier;
begin
  exit this._id
end;

method UTPlayerScore.get_Name: String;
begin
  exit this._name
end;

method UTPlayerScore.get_Score: Integer;
begin
  exit this._score
end;

method UTPlayerScore.get_LastUpdated: DateTime;
begin
  exit this._lastUpdated
end;


end.
