namespace UT3Bots.UTItems;

interface

uses
  System.Collections.Generic,
  System.Linq,
  System.Text;

type
  UTIdentifier = public class
  private
     _id: String;
  public
    constructor;
    constructor (id: String);

    method ToString: String; override;
    method GetHashCode: integer; override;
    method Equals(obj: Object): boolean; override;
    class operator Equal(obj1, obj2: UTIdentifier): boolean;
    class operator NotEqual(obj1, obj2: UTIdentifier): boolean;
  end;
  
implementation

method UTIdentifier.ToString: String;
begin
  Result := _id;
end;

method UTIdentifier.GetHashCode: integer;
begin
  Result := _id.GetHashCode;
end;

method UTIdentifier.Equals(obj: Object): boolean;
begin
  Result := false;
  if (obj is UTIdentifier) then
    begin
      Result := (_id = ((obj as UTIdentifier)._id));
    end;
end;

class operator UTIdentifier.Equal(obj1, obj2: UTIdentifier): boolean;
begin
  if (System.Object.ReferenceEquals(obj1, obj2)) then exit True;

  if (((obj1 as Object) = nil) or ((obj1 as Object) = nil)) then Result := False;

  Result := (obj1._id = obj2._id);
end;

class operator UTIdentifier.NotEqual(obj1, obj2: UTIdentifier): boolean;
begin
  Result := (obj1 <> obj2);
end;

constructor UTIdentifier(id: String);
begin
  constructor;
  _id := id;
end;

constructor UTIdentifier;
begin
  
end;

end.