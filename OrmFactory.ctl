#uses "MapperFactory"
#uses "ModelFactory"

class OrmFactory
{

 string dbConnectionString;// = "DSN=mydb;UID=sa;PWD=****;";
  public void Init(string odbc, string user, string pw)
  {
    dbConnectionString = "DSN="+odbc+";UID="+user+";PWD="+pw+";";
  }
  public void StartOrm(string dbName)
  {

    string tablesQuery = " SELECT TABLE_NAME" +
    " FROM INFORMATION_SCHEMA.TABLES"+
    " WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_CATALOG='"+dbName+"'";
    DebugN(tablesQuery);
    dyn_dyn_anytype tablesResult = rdbOpenSelectClose(tablesQuery);
   // DebugN(tablesResult);
    for(int i = 1; i <= dynlen(tablesResult); i++)
    {
        string table = tablesResult[i][1];
        getTableInfo(table);
    }
  }
  void getTableInfo(string table)
  {
    ModelFactory model = ModelFactory(table);
    MapperFactory mapper = MapperFactory(table);

    string columnsQuery = "SELECT COLUMN_NAME, DATA_TYPE"+
    " FROM INFORMATION_SCHEMA.COLUMNS"+
    " WHERE table_name = '"+table+"'";
    dyn_dyn_anytype columnsResult = rdbOpenSelectClose(columnsQuery);
   // DebugN(tablesResult);
    for(int i = 1; i <= dynlen(columnsResult); i++)
    {
        string columnName = columnsResult[i][1];
        string columnDataType = determineDataType(columnsResult[i][2]);
        model.addProperty(columnName,columnDataType);
        mapper.addProperty(columnName,i);
        //string line = "public "+columnDataType+" "+columnName+";\n";
    }
    model.finishModel();
    mapper.finishMapper();
    DebugN(model.getModelString());
    writeFile(model.getModelString(),"Models\\"+table);
    writeFile(mapper.getMapperString(),"Mappers\\"+table+"Mapper");
  }
  string determineDataType(string dbDataType)
  {
    switch(dbDataType)
    {
      case "int": return "int";
      case "nvarchar": return "string";
      case "datetime": return "string";
      case "bit": return "bool";
    }
  }
  void writeFile(string content,string fileName)
  {
     file f; // our file
     int err; // error code
     string fileString = "C:\\WinCC_OA_Proj\\OaOrm\\scripts\\libs\\"+fileName+".ctl";
     f = fopen(fileString, "wb+"); //Open a binary file for writing and reading

     err = ferror(f); //Output possible errors
     if ( err )
     {
       DebugN("Error no. ",err," occurred");
       return;
     }

     //string content = "This is my file \n";
     fputs(content, f);  //Write to the file

     fclose(f); //Close file
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
};
