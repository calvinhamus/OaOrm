#uses "Models/missions"
 #uses "Mappers/AbstractMapper"
 class missionsMapper :AbstractMapper 
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
 missions x =  missions();
 x. Id = entities[i][1];
 x. Status = entities[i][2];
 x. AcceptedBy = entities[i][3];
 x. EquipmentFrom = entities[i][4];
 x. EquipmentTo = entities[i][5];
 x. JobNumber = entities[i][6];
 x. Quantity = entities[i][7];
 x. TimeCreated = entities[i][8];
 x. TimeAccepted = entities[i][9];
 x. TimeCompleted = entities[i][10];
 x. TimeTargeted = entities[i][11];
 x. Complete = entities[i][12];
 x. Archive = entities[i][13];
 list[i] = x; 
 } 
 return list; 
 } 

 }; 
