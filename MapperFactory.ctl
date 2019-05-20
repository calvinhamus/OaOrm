class MapperFactory
{
  //although this isn't a true factory I could not think of a better name for it
  string mapperString;
  string _className;

  public MapperFactory(string className)
  {
     _className = className;
      mapperString = "#uses \"Models/"+className+"\"\n" +
                    " #uses \"Mappers/AbstractMapper\"\n"+
                    " class "+className+"Mapper :AbstractMapper \n"+
                    " { \n"+
                    "  public init(DatabaseAdapter adapter, string table) \n"+
                    "   { \n"+
                          " sAdapter = adapter; \n" +
                          " setEntityTable(table); \n"+
                    "  } \n"+
                      " public dyn_anytype createEntity(dyn_dyn_anytype entities) \n"
                      " { \n"
                        " dyn_anytype list; \n"+
                        " for(int i = 1; i <= dynlen(entities); i++) \n"+
                        " { \n"+
                        " "+className+" x =  "+className+"();\n";

  }
  public void addProperty(string propName, int y)
  {
      mapperString = mapperString + " x. "+propName+" = entities[i]["+y+"];\n";
  }
  public void addVirtual(string virtualModel)
  {
    mapperString = mapperString + " public "+virtualModel+"" ;
  }
  public void finishMapper()
  {
    mapperString = mapperString + " list[i] = x; \n"+
                   " } \n"+
                   " return list; \n"+
                   " } \n"+
                   createSingle() +
                   "\n }; \n";
  }
  public string getMapperString()
  {
    return mapperString;
  }
  private string createSingle()
  {
    " public "+_className+" single(string fields = \"*\", dyn_string where= \"\") \n"+
  " { \n"+
    " dyn_anytype result; \n" +
    " "+_className+" r; \n"+
    " result = find(fields, where); \n" +
    " r = result[1]; \n" +
    " return r; \n"+
  " } \n";
  }


};
/*
#uses "Models/Furnace"
#uses "Mappers/AbstractMapper"

class FurnaceMapper :AbstractMapper
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
      Furnace f =  Furnace();
      f.FurnaceId = entities[i][1];
      f.FurnaceName = entities[i][2];
      list[i] = f;
    }
     return list;
  }
  public Furnace single(string fields = "*", dyn_string where= "")
  {
    dyn_anytype result;
    Furnace r;
    result = find(fields, where);
    r = result[1];
    return r;
  }
};*/
