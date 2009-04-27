
// RemObjects CS to Pascal 0.1

namespace UT3Bots.UTItems;

interface
uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Text;
type
  UTNavPoint = public class(UTPoint)
    //Constructor
    
    constructor UTNavPoint(Id: UTIdentifier; Location: UTVector; IsReachable: Boolean);
  end;


implementation

constructor UTNavPoint.UTNavPoint(Id: UTIdentifier; Location: UTVector; IsReachable: Boolean);
begin
end;


end.
