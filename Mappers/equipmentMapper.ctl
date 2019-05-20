#uses "Models/equipment"
 #uses "Mappers/AbstractMapper"
 class equipmentMapper :AbstractMapper 
 { 
  public init(DatabaseAdapter adapter, string table) 
   { 
 sAdapter = adapter; 
 setEntityTable(table); 
  } 
 public dyn_anytype createEntity(dyn_dyn_anytype entities) 
 { 
 dyn_anytype list; 
 for(int i = 1; i <= dynlen(entities); i++) 
 { 
 equipment x =  equipment();
 x. Id = entities[i][1];
 x. EquipmentName = entities[i][2];
 list[i] = x; 
 } 
 return list; 
 } 

 }; 
