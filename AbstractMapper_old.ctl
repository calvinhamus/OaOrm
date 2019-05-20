#uses "Models/Recipe"
#uses "Models/Step"
#uses "Models/StepInstance"

class AbstractMapper
{
  protected DatabaseAdapter sAdapter;
  protected string sTable;
  protected mapping sEntityClass;
  
  public AbstractMapper()
  {
   // sAdapter = adapter;  
  }
  public void setEntityTable(string table)
  {
      sTable = table;
  }
  public mapping setEntityClass(string table)
  {
    switch(table)
    {
      case "Recipe":  
        sEntityClass["Class"] = new Recipe();       
      break;
      case "Step":
        sEntityClass["Class"] = new Step();  
    }  
  }
  public dyn_anytype find(string fields = "*", dyn_string where= "" , string order = "")
  {
    dyn_anytype m;
    dyn_dyn_anytype entities = sAdapter.select(fields,sTable,where); 
   // DebugN("Entities "+entities); 
    m = createEntity(entities);
    return m;
  } 
  public dyn_anytype createEntity(dyn_dyn_anytype entities) {dyn_anytype d; return d;  }

};  



