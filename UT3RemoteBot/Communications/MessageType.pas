namespace UT3Bots.Communications;

interface

uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Text,
  System.Diagnostics,
  System.Reflection;

type
  StringValueAttribute = public class (Attribute)
    private
      _stringvalue: string;
    public
      property StringValue: string read _stringvalue write _stringvalue;
      constructor (value: String);
  end;


implementation

end.