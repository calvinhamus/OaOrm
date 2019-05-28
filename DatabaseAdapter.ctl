#uses "rdb"

class DatabaseAdapter
{
  string dbConnectionString;// = "DSN=mydb;UID=sa;PWD=***;";
  string dbName;
  public DatabaseAdapter(string conString,string db)
  {
    dbConnectionString = conString;
    dbName = db;
  }
  void connect()
  {

  }
  //I hate I have to do this but am limited when doing time conversions
  public void query(string query)
  {
      rdbOpenExecuteClose(query);
  }
  public dyn_dyn_anytype selectQuery(string query)
  {
      return rdbOpenSelectClose(query);
  }
  public int count(string table, dyn_string where= "" )
  {
    dyn_dyn_anytype results = select("COUNT(*)",table,where);
    return results[1][1];
  }
  public dyn_dyn_anytype select(string fields = "*",string table, dyn_string where= "" , string order = "")
  {

     string w = parseWhere(where);
     string o = order == "" ? " " : " ORDER BY "+order+" ASC";

      string query = "SELECT "+fields+" FROM ["+dbName+"].[dbo]." + table + " "+ w +
                     o;
      //DebugN("Select Query : "+ query);
      return rdbOpenSelectClose(query);

  }
  public void insert(string table, string entity, bool ignoreKey= true)
  {
      string key = table +"Id";
      mapping m = getFields(entity,key,ignoreKey);
      string query = "INSERT INTO ["+dbName+"].[dbo]."+table+" ( "+m["fields"]+")"+
                     " VALUES ( "+m["values"]+")";

      rdbOpenExecuteClose(query);

  }
  public void update(string table,string data,dyn_string where = "")
  {
      string key = table +"Id";
      string s = getSetValue(data,key);
      string w = parseWhere(where);
      string query = "UPDATE ["+dbName+"].[dbo]."+table+" SET "+ s +" "+ w;

      rdbOpenExecuteClose(query);
  }
  public void deleteEntity(string table, string where = "")
  {
    string w = where == "" ? "" : "WHERE " + where;
    string query = "DELETE FROM ["+dbName+"].[dbo]." + table + " "+ w;
    DebugN("DELTE "+ query);
     rdbOpenExecuteClose(query);
  }
  string parseWhere(dyn_string where)
  {
      string w = "";
      if(where != "")
      {
        //DebugN("W1 "+ w);
          w = w + "WHERE ";
          for(int i = 1; i <= dynlen(where); i++)
          {

             if( i > 1){
               w = w +" AND " ;
             }
             w = w + " " + where[i] ;
           }
      }
     // DebugN("W2 "+ w);
    return w;
  }
    void rdbOpenExecuteClose(string query)
  {
    // Variables
    dbConnection db;

    // open execute and close
    rdbOpen(db, dbConnectionString);
    rdbExecute(db,query);
    rdbClose(db);

  }
  dyn_dyn_anytype rdbOpenSelectClose(string query)
  {

    // Variables
    dbConnection db;
    dyn_dyn_anytype result;

    // open query and close db
    rdbOpen(db, dbConnectionString);
    rdbSelect(db,query,result);
    rdbClose(db);

    return result;
  }
  mapping getFields(string data, string keyField, bool ignoreKey = true)
  {
    //["Step: StepId:257 | ActivityId:2 | StepOrder:14 | RecipeId:1 | StepDescription: | StepInstances: | r:RecipeId:0 | RecipeName: | FurnaceId:0"]
    //string s = (string) data;
    dyn_string split = strsplit(data,"|");
    string fields = "";
    string values = "";
    for(int i = 1; i <= dynlen(split);i++)
    {
        dyn_string fieldSplit = strsplit(split[i],":");
        if(ignoreKey && keyField == fieldSplit[1] || dynlen(fieldSplit) < 2)continue;

        fields = fields + " "+ fieldSplit[1] + ",";
        values = values + " '"+fieldSplit[2] + "',";
    }
    string sFields = substr(fields,1, strlen(fields)-2);
    string sValues = substr(values,1, strlen(values)-2);
    mapping map;
    map["fields"] = sFields;
    map["values"] = sValues;
    return map;
  }
  string getSetValue(string data, string keyField)
  {
    DebugN("DATA: "+ data);
        dyn_string split = strsplit(data,"|");
        string fields = "";
        string values = "";
        string s;
        for(int i = 1; i <= dynlen(split);i++)
        {
            dyn_string fieldSplit = strsplit(split[i],":");
            if(keyField == fieldSplit[1] || dynlen(fieldSplit) < 2)continue;
            string trimmed = strrtrim(fieldSplit[2]," ");
            //if( i > 1){
             // s = s +" , " ;
           // }
            s = s + " "+fieldSplit[1] + "  = '"+trimmed+"',";
        }
       // DebugN("Len "+ strlen(s));
        DebugN("STRING "+ s);
        string ss = substr(s,1, strlen(s)-2);
        return ss;

  }
};
