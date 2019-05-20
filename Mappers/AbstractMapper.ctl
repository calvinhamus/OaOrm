#uses "DatabaseAdapter"
#uses "Models/Recipe"
#uses "Models/Step"
#uses "Models/StepInstance"

class AbstractMapper
{
  protected DatabaseAdapter sAdapter;
  protected string sTable;
  protected mapping sEntityClass;

  public AbstractMapper(DatabaseAdapter adapter = "")
  {
    sAdapter = adapter;

  }
  public void setEntityTable(string table)
  {
      sTable = table;
  }
  public mapping setEntityClass(string table)
  {


  }
  public int count(dyn_string where= "")
  {
    return sAdapter.count(sTable,where);
  }
  public dyn_anytype find(string fields = "*", dyn_string where= "" , string order = "")
  {
    dyn_anytype m;
    dyn_dyn_anytype entities = sAdapter.select(fields,sTable,where);
   // DebugN("Entities "+entities);
    m = createEntity(entities);
    return m;
  }
  public void deleteEntity(int id, string col)
  {
    DebugN("table " +  sTable +"  "+ col + " " + id);
    sAdapter.deleteEntity(sTable,col + " = "+ id);
  }
  public void deleteGroup(string id, string col)
  {
     sAdapter.deleteEntity(sTable,col + " = '"+ id+"'");
  }
  public void insert(string entity,bool ignoreKey = true)
  {
      sAdapter.insert(sTable,entity,ignoreKey);
  }
  public void update(string entity,dyn_string where)
  {
      sAdapter.update(sTable,entity,where);
  }
  public dyn_anytype createEntity(dyn_dyn_anytype entities) {dyn_anytype d; return d;  }
  public void query(string query){ sAdapter.query(query);}
  public dyn_dyn_anytype selectQuery(string query){return sAdapter.selectQuery(query);}
};
