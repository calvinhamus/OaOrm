#uses "Models/RecipeInstance"
#uses "Models/DbSafeRecipeInstance"
class SafeRecipeInstanceMapper
{
  public DbSafeRecipeInstance createEntity(RecipeInstance ri)
  {
    DbSafeRecipeInstance dbSafe;
    dbSafe.RecipeInstanceId = ri.RecipeInstanceId;
    dbSafe.RecipeId = ri.RecipeId;
    dbSafe.TotalDuration = ri.TotalDuration;
    dbSafe.InstanceName = ri.InstanceName;
    
    return dbSafe;
  }
};
