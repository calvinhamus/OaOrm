#uses "Models/StepInstance"
#uses "Models/DbSafeStepInstance"

class SafeStepInstanceMapper
{
   public DbSafeStepInstance createEntity(StepInstance si)
   {
         DbSafeStepInstance safeSi;
         safeSi.DefaultStepInstance = si.DefaultStepInstance;
         safeSi.Duration = si.Duration;
         safeSi.RampRate = si.RampRate;
         safeSi.RecipeInstanceId = si.RecipeInstanceId;
         safeSi.Setpoint = si.Setpoint;
         safeSi.StepId = si.StepId;
         safeSi.StepInstanceId = si.StepInstanceId;
         DebugN("Mapped "+  safeSi.RecipeInstanceId + " " + si.RecipeInstanceId);
         return safeSi;   
   }
  

};
