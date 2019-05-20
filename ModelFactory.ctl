
class ModelFactory
{
  //although this isn't a true factory I could not think of a better name for it
  string modelString;

  public ModelFactory(string className)
  {
      modelString = "class "+className+"\n"+
                    " { \n";
  }
  public void addProperty(string propName, string propDataType)
  {
      modelString = modelString + "public "+propDataType+" "+propName+";\n";
  }
  public void addVirtual(string virtualModel)
  {
    modelString = modelString + "public "+virtualModel+"" ;
  }
  public void finishModel()
  {
    modelString = modelString + " };";
  }
  public string getModelString()
  {
    return modelString;
  }


};
