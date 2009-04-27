
// RemObjects CS to Pascal 0.1

namespace UT3Bots.UTItems;

interface
uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Text,
  System.ComponentModel,
  UT3Bots.Communications;
type
  UTItemPoint = public class(UTPoint, INotifyPropertyChanged)
  private
    var     _item: UTItem;
    var     _isReadyToPickup: Boolean;
  assembly
    //Constructor
    
    constructor UTItemPoint(Id: UTIdentifier; Location: UTVector; &Type: String; isReachable: Boolean; isReadyToPickup: Boolean);
    property Item: UTItem read get_Item;
    method get_Item: UTItem;
    property IsReadyToPickup: Boolean read get_IsReadyToPickup write set_IsReadyToPickup;
    method get_IsReadyToPickup: Boolean;
    method set_IsReadyToPickup(value: Boolean);
  end;


implementation

constructor UTItemPoint.UTItemPoint(Id: UTIdentifier; Location: UTVector; &Type: String; isReachable: Boolean; isReadyToPickup: Boolean);
begin
  this._isReadyToPickup := isReadyToPickup;
  this._item := new UTItem(Id.ToString(), &Type)
end;

method UTItemPoint.get_Item: UTItem;
begin
  exit this._item
end;

method UTItemPoint.get_IsReadyToPickup: Boolean;
begin
  exit this._isReadyToPickup
end;

method UTItemPoint.set_IsReadyToPickup(value: Boolean);
begin
  this._isReadyToPickup := value;
  OnPropertyChanged('IsReadyToPickup')
end;


end.
