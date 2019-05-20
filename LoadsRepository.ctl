#uses "Models/Part"
#uses "Models/DbSafePart"
#uses "Mappers/RecipeMapper"
#uses "Models/LoadPart"
#uses "Mappers/SafeLoadMapper"
#uses "Models/Load"
#uses "Models/DbSafeLoadPart"
#uses "Mappers/LoadPartMapper"
#uses "Mappers/PartMapper"
#uses "Mappers/LoadMapper"
#uses "Mappers/FurnaceMapper"
#uses "Mappers/ThermocoupleMapper"
#uses "DatabaseAdapter"
#uses "variables"

class LoadsRepository
{
    DatabaseAdapter db;
    PartMapper pMapper;
    LoadPartMapper lpMapper;
    LoadMapper lMapper;
    ThermocoupleMapper tMapper;
    SafeLoadMapper safeLoadMapper;
    FurnaceMapper fMapper;
    RecipeMapper rMapper;

    public LoadsRepository()
    {
      tMapper.init(db,"Thermocouple");
      fMapper.init(db,"Furnace");
      pMapper.init(db,"Part",tMapper);
      lpMapper.init(db,"LoadPart",pMapper);
      lMapper.init(db,"Load",lpMapper,fMapper);
    }
    public dyn_anytype GetAllThings()
    {
      dyn_anytype loads;
      loads = lMapper.find("*");
      return loads;
    }

};
