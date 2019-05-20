#uses "Models/Load"
#uses "Models/DbSafeLoad"
class SafeLoadMapper
{
  public DbSafeLoad createEntity(Load ri)
  {
    DbSafeLoad dbSafe;
    dbSafe.LoadRequestNumber = ri.LoadRequstNumber;
    dbSafe.FurnaceId = ri.FurnaceId;
    dbSafe.Process = ri.Process;
    dbSafe.SpecimenCount = ri.SpecimenCount;
    dbSafe.SpecimenCastNumber = ri.SpecimenCastNumber;
    dbSafe.RecipeId = ri.RecipeId;
    dbSafe.StartTime = (string)ri.StartTime;
    dbSafe.Notes = ri.Notes;
    dbSafe.Status = ri.Status;
    DebugN("TIMES "+ ri.StartTime + " " + dbSafe.StartTime);
    dbSafe.ThermoCouple1;
    dbSafe.ThermoCouple2;
    dbSafe.ThermoCouple3;
    dbSafe.ThermoCouple4;
    
    
    return dbSafe;
  }
  string formatMyTime(time t)
  {
    string formatString = "%m-%d-%Y %H:%M:%S";
    return formatTime(formatString, t);
  }
};
