
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
  public
    constructor(Id: UTIdentifier; Name: String; Score: Integer);

    property Id: UTIdentifier read get_Id;
    property Name: String read get_Name;
    property Score: Integer read get_Score;
    property LastUpdated: DateTime read get_LastUpdated;

    method SetScore(NewScore: Integer);
    method OnPropertyChanged(propName: String);virtual;
    method get_Id: UTIdentifier;
    method get_Name: String;
    method get_Score: Integer;
    method get_LastUpdated: DateTime;

    event PropertyChanged: PropertyChangedEventHandler;
    method ToString: String; override;
    method CompareTo(other: UTPlayerScore): Integer;
  end;


implementation

method UTPlayerScore.SetScore(NewScore: Integer);
begin
  Self._score := NewScore;
  Self._lastUpdated := DateTime.Now;
  OnPropertyChanged('Score')
end;

method UTPlayerScore.ToString(): String;
begin
  exit Self._id.ToString().PadRight(30) + ' ' + Self._name.PadRight(30) + ' ' + Self._score;
end;

method UTPlayerScore.CompareTo(other: UTPlayerScore): Integer;
begin
  if Self._score > other._score then
  begin
    exit -1;
  end
  else
  begin
    if Self._score < other._score then
    begin
      exit 1;
    end
    else
    begin
      Result := Self._id.CompareTo(other._id);
    end
  end
end;

method UTPlayerScore.OnPropertyChanged(propName: String);
begin
  if PropertyChanged <> nil then
  begin
    PropertyChanged(Self, new PropertyChangedEventArgs(propName))
  end
  else
  begin
  end
end;

constructor UTPlayerScore(Id: UTIdentifier; Name: String; Score: Integer);
begin
  Self._id := Id;
  Self._name := Name;
  Self._score := Score;
end;

method UTPlayerScore.get_Id: UTIdentifier;
begin
  Result := Self._id;
end;

method UTPlayerScore.get_Name: String;
begin
  Result := Self._name;
end;

method UTPlayerScore.get_Score: Integer;
begin
  Result := Self._score;
end;

method UTPlayerScore.get_LastUpdated: DateTime;
begin
  Result := Self._lastUpdated;
end;


end.
