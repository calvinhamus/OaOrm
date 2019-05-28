#uses "Mappers/MissionMapper"
//Declare a DatabaseAdapter instance to work with
//Pass the ODBC connection string and the Database name to the adapter
DatabaseAdapter db = DatabaseAdapter("DSN=mydb;UID=sa;PWD=***;","SixtyKPressSCADA");

//Declare a Mapper, this mapper will correspond with the table you want to work with
MissionMapper mMapper;
//Simple function I'm calling from the panel on a button click
buttonClick()
{
  //Initialize the mapper with the DatabaseAdapter instance and the table to work with
  mMapper.init(db,"Mission");

  //These are functions to test everything
 // DebugN(GetAllThings());
 // DebugN(GetOneThing());
 // UpdateOneThing();

}
//This function will get all records in the table
public dyn_anytype GetAllThings()
{
  //Declare a dyn_anytype to hold our objects
  dyn_anytype things;
  //Assign the results to the variable we created.  These variables can then be cast to a concrete instance
  things = mMapper.find("*");

  return things;
}
//This function will get an individual row from the table in the database based on a where clause.
public Mission GetOneThing()
{
  //Create a Mission instance
  Mission m;
  //Create a where clause so the mapper can find the instance you are looking for
  dyn_string w;
  w[1] = "MissionId = '91'";
  //get an individual item from the database
  m = mMapper.single("*",w);
  return m;
}
//This function gets an individual thing from the table in the DB then makes a change to it and saves it back to the DB
public void UpdateOneThing()
{
  //Get the mission to work with
  Mission m = GetOneThing();
  //Change one property
  m.EquipmentFrom = "NewFrom";
  //Convert the object to a string so the adapter can process it
  string missionString = (string)m;
  //Create a where clause
  dyn_string w;
  w[1] = "MissionId = '91'";
  //Call the update function with the class and the where clause
  mMapper.update(m,w);
}
