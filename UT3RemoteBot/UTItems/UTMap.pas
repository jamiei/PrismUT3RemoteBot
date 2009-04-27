
// RemObjects CS to Pascal 0.1

namespace UT3Bots.UTItems;

interface
uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Text,
  UT3Bots.Communications;
type
  UTMap = public class
  private
    //Private Members
    
    var     _navList: List<UTNavPoint> := new List<UTNavPoint>();
    var     _itemList: List<UTItemPoint> := new List<UTItemPoint>();
    var     _theBot: UTBotSelfState;
  assembly
    method UpdateState(Message: Message);
    method GetLocationFromId(Id: String): UTVector;
    method GetLocationFromId(Id: UTIdentifier): UTVector;
  assembly or protected
    /// <summary>
    /// Returns the nearest UTNavPoint to your bot's current location
    /// </summary>
    
    method GetNearestNavPoint(): UTNavPoint;
    /// <summary>
    /// Returns the nearest UTNavPoint to your bot's current location, excluding the UTNavpoint specified. 
    /// Useful for ignoring the point your bot may already be stood on
    /// </summary>
    /// <param name="toExclude">The UTNavPoint to ignore during the search</param>
    
    method GetNearestNavPoint(toExclude: UTNavPoint): UTNavPoint;
    /// <summary>
    /// Returns the nearest UTNavPoint to the specified location
    /// </summary>
    /// <param name="location">The location you want to find the nearest nav point to</param>
    /// <returns>The closest UTNavPoint to that location</returns>
    
    method GetNearestNavPoint(location: UTVector): UTNavPoint;
    /// <summary>
    /// Returns the nearest UTNavPoint to the specified location, excluding the UTNavpoint specified. 
    /// Useful for ignoring the point your bot may already be stood on
    /// </summary>
    /// <param name="location">The location you want to find the nearest nav point to</param>
    /// <param name="toExclude">The UTNavPoint to ignore during the search</param>
    /// <returns>The closest UTNavPoint to that location</returns>
    
    method GetNearestNavPoint(location: UTVector; toExclude: UTNavPoint): UTNavPoint;
    //Set as new closest
    /// <summary>
    /// Returns the nearest UTItemPoint to your bot's current location
    /// </summary>
    /// <returns>The closest UTItemPoint to that location</returns>
    
    method GetNearestItemPoint(): UTItemPoint;
    /// <summary>
    /// Returns the nearest UTItemPoint to your bot's current location, excluding the UTItemPoint specified. 
    /// Useful for ignoring the point your bot may already be stood on
    /// </summary>
    /// <returns>The closest UTItemPoint to that location</returns>
    
    method GetNearestItemPoint(toExclude: UTItemPoint): UTItemPoint;
    /// <summary>
    /// Returns the nearest UTItemPoint to the specified location
    /// </summary>
    /// <param name="location">The location you want to find the nearest item point to</param>
    /// <returns>The closest UTItemPoint to that location</returns>
    
    method GetNearestItemPoint(location: UTVector): UTItemPoint;
    /// <summary>
    /// Returns the nearest UTItemPoint to the specified location, excluding the UTItemPoint specified. 
    /// Useful for ignoring the point your bot may already be stood on
    /// </summary>
    /// <param name="location">The location you want to find the nearest item point to</param>
    /// <param name="toExclude">The UTItemPoint to ignore during the search</param>
    /// <returns>The closest UTItemPoint to that location</returns>
    
    method GetNearestItemPoint(location: UTVector; toExclude: UTItemPoint): UTItemPoint;
    //Set as new closest
    /// <summary>
    /// Returns the nearest UTItemPoint of a certain type to your bot's current location
    /// </summary>
    /// <param name="type">The type to look for</param>
    /// <returns>The closest UTItemPoint of that type to your bot's location</returns>
    
    method GetNearestItem(&type: ItemType): UTItemPoint;
    /// <summary>
    /// Returns the nearest UTItemPoint of a certain type to your bot's current location, excluding the UTItemPoint specified.  
    /// Useful for ignoring the point your bot may already be stood on 
    /// </summary>
    /// <param name="type">The type to look for</param>
    /// <param name="toExclude">The UTItemPoint to ignore during the search</param>
    /// <returns>The closest UTItemPoint of that type to your bot's location</returns>
    
    method GetNearestItem(&type: ItemType; toExclude: UTItemPoint): UTItemPoint;
    /// <summary>
    /// Returns the nearest UTItemPoint of a certain type to the specified location
    /// </summary>
    /// <param name="type">The type to look for</param>
    /// <param name="location">The location you want to find the nearest item point to</param>
    /// <returns>The closest UTItemPoint of that type to that location</returns>
    
    method GetNearestItem(&type: ItemType; location: UTVector): UTItemPoint;
    /// <summary>
    /// Returns the nearest UTItemPoint of a certain type to the specified location, excluding the UTItemPoint specified.  
    /// Useful for ignoring the point your bot may already be stood on
    /// </summary>
    /// <param name="type">The type to look for</param>
    /// <param name="location">The location you want to find the nearest item point to</param>
    /// <param name="toExclude">The UTItemPoint to ignore during the search</param>
    /// <returns>The closest UTItemPoint of that type to that location</returns>
    
    method GetNearestItem(&type: ItemType; location: UTVector; toExclude: UTItemPoint): UTItemPoint;
    //Set as new closest
    /// <summary>
    /// Returns the nearest UTItemPoint of a certain type to your bot's current location
    /// </summary>
    /// <param name="type">The type to look for</param>
    /// <returns>The closest UTItemPoint of that type to your bot's location</returns>
    
    method GetNearestItem(&type: WeaponType): UTItemPoint;
    /// <summary>
    /// Returns the nearest UTItemPoint of a certain type to your bot's current location, excluding the UTItemPoint specified.  
    /// Useful for ignoring the point your bot may already be stood on 
    /// </summary>
    /// <param name="type">The type to look for</param>
    /// <param name="toExclude">The UTItemPoint to ignore during the search</param>
    /// <returns>The closest UTItemPoint of that type to your bot's location</returns>
    
    method GetNearestItem(&type: WeaponType; toExclude: UTItemPoint): UTItemPoint;
    /// <summary>
    /// Returns the nearest UTItemPoint of a certain type to the specified location
    /// </summary>
    /// <param name="type">The type to look for</param>
    /// <param name="location">The location you want to find the nearest item point to</param>
    /// <returns>The closest UTItemPoint of that type to that location</returns>
    
    method GetNearestItem(&type: WeaponType; location: UTVector): UTItemPoint;
    /// <summary>
    /// Returns the nearest UTItemPoint of a certain type to the specified location, excluding the UTItemPoint specified.  
    /// Useful for ignoring the point your bot may already be stood on
    /// </summary>
    /// <param name="type">The type to look for</param>
    /// <param name="location">The location you want to find the nearest item point to</param>
    /// <param name="toExclude">The UTItemPoint to ignore during the search</param>
    /// <returns>The closest UTItemPoint of that type to that location</returns>
    
    method GetNearestItem(&type: WeaponType; location: UTVector; toExclude: UTItemPoint): UTItemPoint;
    //Set as new closest
    /// <summary>
    /// Returns the nearest UTItemPoint of a certain type to your bot's current location
    /// </summary>
    /// <param name="type">The type to look for</param>
    /// <returns>The closest UTItemPoint of that type to your bot's location</returns>
    
    method GetNearestItem(&type: HealthType): UTItemPoint;
    /// <summary>
    /// Returns the nearest UTItemPoint of a certain type to your bot's current location, excluding the UTItemPoint specified.  
    /// Useful for ignoring the point your bot may already be stood on 
    /// </summary>
    /// <param name="type">The type to look for</param>
    /// <param name="toExclude">The UTItemPoint to ignore during the search</param>
    /// <returns>The closest UTItemPoint of that type to your bot's location</returns>
    
    method GetNearestItem(&type: HealthType; toExclude: UTItemPoint): UTItemPoint;
    /// <summary>
    /// Returns the nearest UTItemPoint of a certain type to the specified location
    /// </summary>
    /// <param name="type">The type to look for</param>
    /// <param name="location">The location you want to find the nearest item point to</param>
    /// <returns>The closest UTItemPoint of that type to that location</returns>
    
    method GetNearestItem(&type: HealthType; location: UTVector): UTItemPoint;
    /// <summary>
    /// Returns the nearest UTItemPoint of a certain type to the specified location, excluding the UTItemPoint specified.  
    /// Useful for ignoring the point your bot may already be stood on
    /// </summary>
    /// <param name="type">The type to look for</param>
    /// <param name="location">The location you want to find the nearest item point to</param>
    /// <param name="toExclude">The UTItemPoint to ignore during the search</param>
    /// <returns>The closest UTItemPoint of that type to that location</returns>
    
    method GetNearestItem(&type: HealthType; location: UTVector; toExclude: UTItemPoint): UTItemPoint;
    //Set as new closest
    /// <summary>
    /// Returns the nearest UTItemPoint of a certain type to your bot's current location
    /// </summary>
    /// <param name="type">The type to look for</param>
    /// <returns>The closest UTItemPoint of that type to your bot's location</returns>
    
    method GetNearestItem(&type: AmmoType): UTItemPoint;
    /// <summary>
    /// Returns the nearest UTItemPoint of a certain type to your bot's current location, excluding the UTItemPoint specified.  
    /// Useful for ignoring the point your bot may already be stood on 
    /// </summary>
    /// <param name="type">The type to look for</param>
    /// <param name="toExclude">The UTItemPoint to ignore during the search</param>
    /// <returns>The closest UTItemPoint of that type to your bot's location</returns>
    
    method GetNearestItem(&type: AmmoType; toExclude: UTItemPoint): UTItemPoint;
    /// <summary>
    /// Returns the nearest UTItemPoint of a certain type to the specified location
    /// </summary>
    /// <param name="type">The type to look for</param>
    /// <param name="location">The location you want to find the nearest item point to</param>
    /// <returns>The closest UTItemPoint of that type to that location</returns>
    
    method GetNearestItem(&type: AmmoType; location: UTVector): UTItemPoint;
    /// <summary>
    /// Returns the nearest UTItemPoint of a certain type to the specified location, excluding the UTItemPoint specified.  
    /// Useful for ignoring the point your bot may already be stood on
    /// </summary>
    /// <param name="type">The type to look for</param>
    /// <param name="location">The location you want to find the nearest item point to</param>
    /// <param name="toExclude">The UTItemPoint to ignore during the search</param>
    /// <returns>The closest UTItemPoint of that type to that location</returns>
    
    method GetNearestItem(&type: AmmoType; location: UTVector; toExclude: UTItemPoint): UTItemPoint;
    //Set as new closest
    /// <summary>
    /// Returns the nearest UTItemPoint of a certain type to your bot's current location
    /// </summary>
    /// <param name="type">The type to look for</param>
    /// <returns>The closest UTItemPoint of that type to your bot's location</returns>
    
    method GetNearestItem(&type: ArmorType): UTItemPoint;
    /// <summary>
    /// Returns the nearest UTItemPoint of a certain type to your bot's current location, excluding the UTItemPoint specified.  
    /// Useful for ignoring the point your bot may already be stood on 
    /// </summary>
    /// <param name="type">The type to look for</param>
    /// <param name="toExclude">The UTItemPoint to ignore during the search</param>
    /// <returns>The closest UTItemPoint of that type to your bot's location</returns>
    
    method GetNearestItem(&type: ArmorType; toExclude: UTItemPoint): UTItemPoint;
    /// <summary>
    /// Returns the nearest UTItemPoint of a certain type to the specified location
    /// </summary>
    /// <param name="type">The type to look for</param>
    /// <param name="location">The location you want to find the nearest item point to</param>
    /// <returns>The closest UTItemPoint of that type to that location</returns>
    
    method GetNearestItem(&type: ArmorType; location: UTVector): UTItemPoint;
    /// <summary>
    /// Returns the nearest UTItemPoint of a certain type to the specified location, excluding the UTItemPoint specified.  
    /// Useful for ignoring the point your bot may already be stood on
    /// </summary>
    /// <param name="type">The type to look for</param>
    /// <param name="location">The location you want to find the nearest item point to</param>
    /// <param name="toExclude">The UTItemPoint to ignore during the search</param>
    /// <returns>The closest UTItemPoint of that type to that location</returns>
    
    method GetNearestItem(&type: ArmorType; location: UTVector; toExclude: UTItemPoint): UTItemPoint;
  assembly
    //Constructor
    
    constructor UTMap(theBot: UTBotSelfState);
    property NavPoints: List<UTNavPoint> read get_NavPoints;
    method get_NavPoints: List<UTNavPoint>;
    property InvItems: List<UTItemPoint> read get_InvItems;
    method get_InvItems: List<UTItemPoint>;
  end;


implementation

method UTMap.UpdateState(Message: Message);
begin
  if Message <> nil and Message.&Event = EventMessage.STATE then
  begin
    case Message.Infoof
case InfoMessage.NAV_INFO:begin
        var nav: UTNavPoint := new UTNavPoint(new UTIdentifier(Message.Arguments[0]), UTVector.Parse(Message.Arguments[1]), Boolean.Parse(Message.Arguments[2]));
        this._navList.&Add(nav);
        break;
      end;
case InfoMessage.PICKUP_INFO:begin
        var item: UTItemPoint := new UTItemPoint(new UTIdentifier(Message.Arguments[0]), UTVector.Parse(Message.Arguments[1]), Message.Arguments[2], Boolean.Parse(Message.Arguments[3]), Boolean.Parse(Message.Arguments[4]));
        this._itemList.&Add(item);
        break;
      end;
    end
  end
  else
  begin
  end
end;

method UTMap.GetLocationFromId(Id: String): UTVector;
begin
  var tempId: UTIdentifier := new UTIdentifier(Id);
  exit GetLocationFromId(tempId)
end;

method UTMap.GetLocationFromId(Id: UTIdentifier): UTVector;
begin
  for each n: UTNavPoint in this._navList do
  begin
    if n.Id = Id then
    begin
      exit n.Location
    end
    else
    begin
    end
  end;
  for each i: UTItemPoint in this._itemList do
  begin
    if i.Id = Id then
    begin
      exit i.Location
    end
    else
    begin
    end
  end;
  exit nil
end;

method UTMap.GetNearestNavPoint(): UTNavPoint;
begin
  exit GetNearestNavPoint(_theBot.Location, nil)
end;

method UTMap.GetNearestNavPoint(toExclude: UTNavPoint): UTNavPoint;
begin
  exit GetNearestNavPoint(_theBot.Location, toExclude)
end;

method UTMap.GetNearestNavPoint(location: UTVector): UTNavPoint;
begin
  exit GetNearestNavPoint(location, nil)
end;

method UTMap.GetNearestNavPoint(location: UTVector; toExclude: UTNavPoint): UTNavPoint;
begin
  var closest: UTNavPoint := nil;
  var closestDistance: Single := -1;
  for each n: UTNavPoint in this._navList do
  begin
    var myDistance: Single := n.Location.DistanceFrom(location);
    if n <> toExclude and (myDistance < closestDistance or closestDistance < 0) then
    begin
      closest := n;
      closestDistance := myDistance
    end
    else
    begin
    end
  end;
  exit closest
end;

method UTMap.GetNearestItemPoint(): UTItemPoint;
begin
  exit GetNearestItemPoint(_theBot.Location, nil)
end;

method UTMap.GetNearestItemPoint(toExclude: UTItemPoint): UTItemPoint;
begin
  exit GetNearestItemPoint(_theBot.Location, toExclude)
end;

method UTMap.GetNearestItemPoint(location: UTVector): UTItemPoint;
begin
  exit GetNearestItemPoint(location, nil)
end;

method UTMap.GetNearestItemPoint(location: UTVector; toExclude: UTItemPoint): UTItemPoint;
begin
  var closest: UTItemPoint := nil;
  var closestDistance: Single := -1;
  for each i: UTItemPoint in this._itemList do
  begin
    var myDistance: Single := i.Location.DistanceFrom(location);
    if i <> toExclude and (myDistance < closestDistance or closestDistance < 0) then
    begin
      closest := i;
      closestDistance := myDistance
    end
    else
    begin
    end
  end;
  exit closest
end;

method UTMap.GetNearestItem(&type: ItemType): UTItemPoint;
begin
  exit GetNearestItem(&type, _theBot.Location, nil)
end;

method UTMap.GetNearestItem(&type: ItemType; toExclude: UTItemPoint): UTItemPoint;
begin
  exit GetNearestItem(&type, _theBot.Location, toExclude)
end;

method UTMap.GetNearestItem(&type: ItemType; location: UTVector): UTItemPoint;
begin
  exit GetNearestItem(&type, location, nil)
end;

method UTMap.GetNearestItem(&type: ItemType; location: UTVector; toExclude: UTItemPoint): UTItemPoint;
begin
  var closest: UTItemPoint := nil;
  var closestDistance: Single := -1;
  for each i: UTItemPoint in this._itemList do
  begin
    var myDistance: Single := i.Location.DistanceFrom(location);
    if i <> toExclude and (myDistance < closestDistance or closestDistance < 0) and i.Item.IsItem(&type) then
    begin
      closest := i;
      closestDistance := myDistance
    end
    else
    begin
    end
  end;
  exit closest
end;

method UTMap.GetNearestItem(&type: WeaponType): UTItemPoint;
begin
  exit GetNearestItem(&type, _theBot.Location, nil)
end;

method UTMap.GetNearestItem(&type: WeaponType; toExclude: UTItemPoint): UTItemPoint;
begin
  exit GetNearestItem(&type, _theBot.Location, toExclude)
end;

method UTMap.GetNearestItem(&type: WeaponType; location: UTVector): UTItemPoint;
begin
  exit GetNearestItem(&type, location, nil)
end;

method UTMap.GetNearestItem(&type: WeaponType; location: UTVector; toExclude: UTItemPoint): UTItemPoint;
begin
  var closest: UTItemPoint := nil;
  var closestDistance: Single := -1;
  for each i: UTItemPoint in this._itemList do
  begin
    var myDistance: Single := i.Location.DistanceFrom(location);
    if i <> toExclude and (myDistance < closestDistance or closestDistance < 0) and i.Item.IsItem(&type) then
    begin
      closest := i;
      closestDistance := myDistance
    end
    else
    begin
    end
  end;
  exit closest
end;

method UTMap.GetNearestItem(&type: HealthType): UTItemPoint;
begin
  exit GetNearestItem(&type, _theBot.Location, nil)
end;

method UTMap.GetNearestItem(&type: HealthType; toExclude: UTItemPoint): UTItemPoint;
begin
  exit GetNearestItem(&type, _theBot.Location, toExclude)
end;

method UTMap.GetNearestItem(&type: HealthType; location: UTVector): UTItemPoint;
begin
  exit GetNearestItem(&type, location, nil)
end;

method UTMap.GetNearestItem(&type: HealthType; location: UTVector; toExclude: UTItemPoint): UTItemPoint;
begin
  var closest: UTItemPoint := nil;
  var closestDistance: Single := -1;
  for each i: UTItemPoint in this._itemList do
  begin
    var myDistance: Single := i.Location.DistanceFrom(location);
    if i <> toExclude and (myDistance < closestDistance or closestDistance < 0) and i.Item.IsItem(&type) then
    begin
      closest := i;
      closestDistance := myDistance
    end
    else
    begin
    end
  end;
  exit closest
end;

method UTMap.GetNearestItem(&type: AmmoType): UTItemPoint;
begin
  exit GetNearestItem(&type, _theBot.Location, nil)
end;

method UTMap.GetNearestItem(&type: AmmoType; toExclude: UTItemPoint): UTItemPoint;
begin
  exit GetNearestItem(&type, _theBot.Location, toExclude)
end;

method UTMap.GetNearestItem(&type: AmmoType; location: UTVector): UTItemPoint;
begin
  exit GetNearestItem(&type, location, nil)
end;

method UTMap.GetNearestItem(&type: AmmoType; location: UTVector; toExclude: UTItemPoint): UTItemPoint;
begin
  var closest: UTItemPoint := nil;
  var closestDistance: Single := -1;
  for each i: UTItemPoint in this._itemList do
  begin
    var myDistance: Single := i.Location.DistanceFrom(location);
    if i <> toExclude and (myDistance < closestDistance or closestDistance < 0) and i.Item.IsItem(&type) then
    begin
      closest := i;
      closestDistance := myDistance
    end
    else
    begin
    end
  end;
  exit closest
end;

method UTMap.GetNearestItem(&type: ArmorType): UTItemPoint;
begin
  exit GetNearestItem(&type, _theBot.Location, nil)
end;

method UTMap.GetNearestItem(&type: ArmorType; toExclude: UTItemPoint): UTItemPoint;
begin
  exit GetNearestItem(&type, _theBot.Location, toExclude)
end;

method UTMap.GetNearestItem(&type: ArmorType; location: UTVector): UTItemPoint;
begin
  exit GetNearestItem(&type, location, nil)
end;

method UTMap.GetNearestItem(&type: ArmorType; location: UTVector; toExclude: UTItemPoint): UTItemPoint;
begin
  var closest: UTItemPoint := nil;
  var closestDistance: Single := -1;
  for each i: UTItemPoint in this._itemList do
  begin
    var myDistance: Single := i.Location.DistanceFrom(location);
    if i <> toExclude and (myDistance < closestDistance or closestDistance < 0) and i.Item.IsItem(&type) then
    begin
      closest := i;
      closestDistance := myDistance
    end
    else
    begin
    end
  end;
  exit closest
end;

constructor UTMap.UTMap(theBot: UTBotSelfState);
begin
  this._theBot := theBot
end;

method UTMap.get_NavPoints: List<UTNavPoint>;
begin
  exit this._navList
end;

method UTMap.get_InvItems: List<UTItemPoint>;
begin
  exit this._itemList
end;


end.
