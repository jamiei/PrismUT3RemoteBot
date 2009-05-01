
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
  UTObject = public class(INotifyPropertyChanged)
  protected
    var     _id: UTIdentifier;
    var     _location: UTVector;
    method OnPropertyChanged(propName: String);virtual;
  public
    //Constructor
    
    constructor(Id: UTIdentifier; Location: UTVector);
    /// <summary>
    /// The unique UT3 game Id of this object
    /// </summary>
    
    property Id: UTIdentifier read get_Id;
    method get_Id: UTIdentifier;
    /// <summary>
    /// The 3D Vector of this object's position in the game
    /// </summary>
    
    property Location: UTVector read get_Location write set_Location;
    method get_Location: UTVector;
    method set_Location(value: UTVector);
    event PropertyChanged: PropertyChangedEventHandler;
  end;


implementation

method UTObject.OnPropertyChanged(propName: String);
begin
  if PropertyChanged <> nil then
  begin
    PropertyChanged(Self, new PropertyChangedEventArgs(propName));
  end;
end;

constructor UTObject(Id: UTIdentifier; Location: UTVector);
begin
  Self._id := Id;
  Self._location := Location
end;

method UTObject.get_Id: UTIdentifier;
begin
  Result := Self._id
end;

method UTObject.get_Location: UTVector;
begin
  Result := Self._location
end;

method UTObject.set_Location(value: UTVector);
begin
  Self._location := value;
  OnPropertyChanged('Location')
end;


end.
