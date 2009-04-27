
// RemObjects CS to Pascal 0.1

namespace UT3Bots.UTItems;

interface
uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Text;
type
  UTPoint = public class(UTObject)
  protected
    var     _isReachable: Boolean;
  assembly
    //Constructor
    
    constructor UTPoint(Id: UTIdentifier; Location: UTVector; IsReachable: Boolean);
    /// <summary>
    /// True if the bot can run straight to this point, False if there is something in the way
    /// </summary>
    
    property IsReachable: Boolean read get_IsReachable;
    method get_IsReachable: Boolean;
  end;


implementation

constructor UTPoint.UTPoint(Id: UTIdentifier; Location: UTVector; IsReachable: Boolean);
begin
  this._isReachable := IsReachable
end;

method UTPoint.get_IsReachable: Boolean;
begin
  exit this._isReachable
end;


end.
