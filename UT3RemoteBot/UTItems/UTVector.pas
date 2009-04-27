namespace UT3RemoteBot.UTItems;

interface

uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Text;

type
  UTVectors = public class
  private
    _x: Double;
    _y: Double;
    _z: Double;
  public
    constructor (x, y, z: Double);

    method get_X: Double;
    method set_X(value: Double);
    method get_Y: Double;
    method set_Y(value: Double);
    method get_Z: Double;
    method set_Z(value: Double);
    
    method DistanceFrom(a: UTVector): Double;
    method ToString: String; override;
    method GetHashCode: integer; override;
    method Equals(obj: Object): boolean; override;
    class operator Equal(obj1, obj2: UTVector): boolean;
    class operator NotEqual(obj1, obj2: UTVector): boolean;
    method Parse(toParse: String): UTVector;

    property X: Double read get_X write set_X;
    property Y: Double read get_Y write set_Y;
    property Z: Double read get_Z write set_Z;
  end;
  
implementation

{$REGION Property Get and Set'ers}
method UTVectors.get_X: Double;
begin
  Result := _x;
end;

method UTVectors.set_X(value: Double);
begin
  Self._x := value;
end;

method UTVectors.get_Y: Double;
begin
  Result := _y;
end;

method UTVectors.set_Y(value: Double);
begin
  Self._y := value;
end;

method UTVectors.get_Z: Double;
begin
  Result := _z;
end;

method UTVectors.set_Z(value: Double);
begin
  Self._z := value;
end;
{$ENDREGION}

constructor UTVectors(x, y, z: Double);
begin
  Self._x := x;
  Self._y := y;
  Self._z := z;
end;

/// <summary>
/// Works out the distance between this UTVector and another. 
/// (You should allow for a distance of about 300 if you are checking to see if you are at a specific location)
/// </summary>
/// <param name="a">The other UTVector to get the distance between</param>
/// <returns></returns>
method UTVectors.DistanceFrom(a: UTVector): Double;
var
  distance, xx, yy, zz: Double;
begin
  xx := Math.Pow((Self._x - a.X), 2);
  yy := Math.Pow((Self._y - a.Y), 2);
  zz := Math.Pow((Self._z - a.Z), 2);
  distance := (Math.Sqrt(xx + yy + zz));

  if (double.IsNaN(distance)) then distance := 0;

  Result := distance;
end;

method UTVectors.ToString: String;
begin
  Result := String.Format('{1:E}, {1:E}, {1:E}', [Self._x, Self._y, Self._z]);
end;

method UTVectors.GetHashCode: integer;
begin
  Result := base.GetHashCode;
end;

method UTVectors.Equals(obj: Object): boolean;
begin
  Result := False;
  if (obj is UTVector) then
    begin
      if ((Self._x = (obj as UTVector)._x) and (Self._y = (obj as UTVector)._y) and (Self._z = (obj as UTVector)._z)) then
        begin
          Result := True;
        end;
    end;
end;

class operator UTVectors.Equal(obj1, obj2: UTVector): boolean;
begin
  Result := False;

  if System.Object.ReferenceEquals(a, b) then Result := True;

  if (((obj1 as Object) = nil) or ((obj1 as Object) = nil)) then Result := False;

  if ((obj1._x = obj2._x) and (obj1._y = obj2._y) and (obj1._z = obj2._z)) then Result := True;
end;

class operator UTVectors.NotEqual(obj1, obj2: UTVector): boolean;
begin
  Result := (obj1 <> obj2);
end;

method UTVectors.Parse(toParse: String): UTVector;
begin
  // Convert UTVector.Parse when the UT3Bots.Communications.Message class is translated.
end;

end.