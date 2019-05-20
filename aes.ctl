#uses "aec.ctl"
#uses "para.ctl"
#uses "dpGetCache.ctl"
#uses "distsync.ctl"
#uses "asModifyDisplay.ctl"

/**@name Variables*/
//@{
// switch for automatic long time test mode
bool g_longTest=false;

///////////////////////////////
//// from aes_peter.ctl - begin
global dyn_string AES_TYPEFILTER;  
global dyn_int    AES_TYPECONST;
/////////////////////////////
//// from aes_peter.ctl - end

bool isSmallPanel = false;
/**@name Global variables*/
//@{
/// General settings data structure

string Filter = "'{*}'";
// err constants
const int AES_CHKERR_ABORT  =1;
const int AES_CHKERR_GOON   =2;


// constant to suppress debug info - see aes_debug()
const int AES_DEBUG_LEVEL=5;

// (de)activates the protection mechanism
//const bool AES_PROTECTION_ON=false;
const bool AES_PROTECTION_ON=TRUE;

// support click, dbclick and rightclick even at stopped mode
const bool AES_FORCE_CLICK=true;

// default font constants
const string AES_DEF_FONT     ="-microsoft windows-Arial-normal-r-normal-*-*-120-100-100-*-*-iso8859-1";
const string AES_LINUXDEF_FONT="-*-*-*-*-*-*-*-*-*-*-*-*-*-*";

// debuginfo - on/off
const bool AESDEBUG=FALSE;

// min open lines in properties
const int AES_MIN_OPEN_LINES=1;
const int AES_DEFAULT_OPEN_LINES=100;

// alert row aescreen configuration
const string AES_ARSCREENCONFIG="aes_alertRow";

// constants for dpQuery handling
const int AES_DPQUERY_NOQUESTION    =0;
const int AES_DPQUERY_CANCELQUERY   =1;
const int AES_DPQUERY_CONTINUEQUERY =2;

// permission level constants
const int AES_PERMLEVEL_MENU        =1;   // guest
const int AES_PERMLEVEL_COLCLICK    =1;   // guest
const int AES_PERMLEVEL_COLDBLCLICK =1;   // guest
const int AES_PERMLEVEL_MENUPROP    =3;   // operator all 

// busy bar constants
const int AES_BUSY_STOP =0;
const int AES_BUSY_START=1;

// constants for copy mode - see aes_copyDp()
const int AES_CPM_ALL     =0;
const int AES_CPM_RESTORE =1;

// returncodes of aes_getRealIdent
const int AES_IDENT_OK        =0;
const int AES_IDENT_OK_NOTAVL =1;      // not available / ok => empty hotlink table
const int AES_IDENT_ERROR     =2;

// constants for language handling
const string AES_LANG_DE      ="de_AT.utf8";
const string AES_LANG_EN      ="en_US.utf8";
const string AES_LANG_RU      ="ru_RU.utf8";
const string AES_LANG_META    ="en_US.utf8";

// constants for getLastError treating
const int AES_ERR_REDUSWITCHED  =110;
const int AES_ERR_REDUCONNLOST  =111;
const int AES_ERR_REDUOPENDISC  =157;   // discarding system specific data ( only in open mode )
const int AES_ERR_DISCARDING    =114;
const int AES_ERR_DISTCONLOST   =144;
const int AES_ERR_MAXALERTREQ   =54;
const int AES_ERR_SYNTAXERROR   =81;  
const int AES_ERR_MAXALERTCONRT =143;

const int AES_ERR_MSGNOTSEND  =38;       // Spezialfall - bei dpConn auf rem sys das zur Zeit nicht conn:!!!

// constants for convertAlertTabEx2 return code
const int AES_CATE_OK           =0;
const int AES_CATE_PARAMERR     =-1;
const int AES_CATE_CFGMATRIXERR =1;


// dummysystemid for checkAll mode
const int AES_DUMMYSYSID      =9999;
const string AES_DUMMYSYSNAME ="CHECKALLSYS";

// constants for operation type - visible/available
const int AES_OPERTYPE_VIS=0;
const int AES_OPERTYPE_AVA=1;
    
// default filename for save operation
const string AES_DEFFILENAME="tableToFile.txt";

// alert row mode treating
const int AES_ARPROP_INCL=0;
const int AES_ARPROP_EXCL=1;
const int AES_ARPROP_ONLY=2;

// proportion limits
const int AES_TABLE_MAXPERCENT=90;
const int AES_TABLE_MINPERCENT=10;

// needed for resortTab()
const string AES_SEARCH_DIRECTION="_alert_hdl.._direction";

// group identifier
const string AES_GROUPIDF="group:::";
const string AES_PLANTMODELIDF="plantmodel:::";

// constants for default values
const int AES_DEFVAL_HISTDATAINTERVAL   =30;      //  [min]
const int AES_DEFVAL_QUERYHLBLOCKEDTIME =1000;    //  [msec]

// sum alert filter constants
const int AES_SUMALERTS_NO   =0;
const int AES_SUMALERTS_ONLY =1;
const int AES_SUMALERTS_BOTH =2;
const int AES_SUMALERTS_FILTERED =3;

// constants for init state
const int AES_INITSTATE_WAITING =0;
const int AES_INITSTATE_OK      =1;
const int AES_INITSTATE_FAILURE =2;

// constants for panel return confirmation
const int AES_CONF_OK=0;
const int AES_CONF_CANCEL=1;

// throw error constants
const int AES_TE_PRINTSAVENOTPOS=1;
const int AES_TE_RESTORECONFIG  =2;
const int AES_TE_SUMALERTNOAVL  =3;
const int AES_TE_CREATEIDFFAILED=4;
const int AES_TE_ACTIONONLYTOP  =5;
const int AES_TE_UNDEFFUNCTION  =6;
const int AES_TE_OLDVERSION     =7;


// special property constants-begin
//////////////////////////////////{

// state filter / mode current
const int AES_MODECUR_ALL       =0;
const int AES_MODECUR_UNACK     =1;
const int AES_MODECUR_PEND      =2;
const int AES_MODECUR_UNACKPEND =3;
const int AES_MODECUR_ACKPEND   =4;
const int AES_MODECUR_ACK       =5;
const int AES_MODECUR_NOTACKABLEPEND =6;
const int AES_MODECUR_NOTACKABLE =7;
const int AES_MODECUR_OLDESTUNACK =8;

// state filter / mode open/closed
const int AES_MODEOPCL_ALL=1;
const int AES_MODEOPCL_DIR=2;

// state filter
const int AES_ALERTDIR_CAME=1;
const int AES_ALERTDIR_WENT=2;

// filter / logicalcombine - only alerts
const int AES_LOGICCOMB_AND=1;
const int AES_LOGICCOMB_OR =2;

// special property constants-end
////////////////////////////////}


// default config names / protected !
const string AES_DEFPROT_SCREEN_DEFAULT ="aes_default";
const string AES_DEFPROT_SCREEN_ALERTS  ="aes_alerts";
const string AES_DEFPROT_SCREEN_EVENTS  ="aes_events";
const string AES_DEFPROT_SCREEN_COMMAND ="aes_command";
const string AES_DEFPROT_SCREEN_ALERTROW="aes_alertRow";

const string AES_DEFPROT_PROP_ALERTS    ="aes_propAlerts";
const string AES_DEFPROT_PROP_EVENTS    ="aes_propEvents";
const string AES_DEFPROT_PROP_COMMAND   ="aes_propCommand";
const string AES_DEFPROT_PROP_ALERTROW  ="aes_propAlertRow";



// permission constants
const int AES_PERM_OK=0;
const int AES_PERM_NOK=1;
const int AES_PERM_ALLOWAECONFIG=2;

// constants for alerthelp treating ( extensions )
const unsigned AESEXT_PNL=1;
const unsigned AESEXT_DOC=2;
const unsigned AESEXT_TXT=3;
const unsigned AESEXT_HTM=4;


// important message id's
const string AESMID_ALERTS  ="mid_alerts";
const string AESMID_EVENTS  ="mid_events";
const string AESMID_ALERTR  ="mid_alertr";
const string AESMID_TOP     ="mid_top";
const string AESMID_BOT     ="mid_bot";
const string AESMID_GENERAL ="mid_general";
const string AESMID_CURRENT ="mode_current";
const string AESMID_OPEN    ="mode_open";
const string AESMID_CLOSED  ="mode_closed";


// most used attribute names
const string AES_ORIVAL=":_original.._value";
const string AES_OFFVAL=":_offline.._value";
const string AES_ONLVAL=":_online.._value";

// constants for action dpe
const int AES_ACTION_INTERACT =0;     // default interactive mode
const int AES_ACTION_AUTORUN  =1;
const int AES_ACTION_PRINT    =2;
const int AES_ACTION_SAVE     =3;
const int AES_ACTION_READY    =4;

// constants for table operations
const int AES_TABLECMD_UPDATE=1;
const int AES_TABLECMD_APPEND=2;
const int AES_TABLECMD_DELETE=3;

// test - for reg_tab problems
global shape gs_tab_top;
global shape gs_tab_bot;


// define max. acount of table columns
const int AES_MAX_COLUMNS=60; 
int AES_MAX_SCREENWIDTH=968; //1018; // 969 laut config / 990 laut gedi

// test - reload
const int RELOAD_MEM=1;
const int RELOAD_DB=2;

// screen and properties operation constants
const int AES_OPER_NEW    =0;
const int AES_OPER_SAVE   =1;
const int AES_OPER_REMOVE =2;
const int AES_OPER_RENAME =3;

// types for opertaions
const int AES_OPERTYPE_SCREEN     =0;
const int AES_OPERTYPE_PROPERTIES =1;


// constatnts for registercard intialmatrixindexes
const int AESREG_NAME         =1;
const int AESREG_TABTYPE      =2;
const int AESREG_PANEL        =3;
const int AESREG_PROPDP       =4;

// constants for registertab dollar parameters
const string AESREGDOLLAR_TABTYPE   ="$TABTYPE";
const string AESREGDOLLAR_TABNAME   ="$TABNAME";
const string AESREGDOLLAR_PROPDP    ="$PROPDP";
const string AESREGDOLLAR_BALPROPDP ="$BALPROPDP";
const string AESREGDOLLAR_PROPDPTOP ="$PROPDPTOP";
const string AESREGDOLLAR_PROPDPBOT ="$PROPDPBOT";
const string AESREGDOLLAR_ALERTROW  ="$ALERTROW";
const string AESREGDOLLAR_COLTITLES ="$COLTITLES";
const string AESREGDOLLAR_COLNAMES  ="$COLNAMES";
const string AESREGDOLLAR_CONFIGPANEL="$CONFIGPANEL";

// constants for propertydialog bdollar parameters
const string AESREGDOLLAR_SCREENTYPE="$SCREENTYPE";
const string AESREGDOLLAR_CONFIGNAME="$CONFIGNAME";
const string AESREGDOLLAR_ACTION    ="$ACTION";
const string AESREGDOLLAR_FILENAME  ="$FILENAME";

// convert alert tab settings
const int AESET_SCREENTYPE      =1;
const int AESET_COMMENTFILTER   =2;
const int AESET_CURRENT_MODE    =3;
const int AESET_USEFONTPROP     =4;
const int AESET_ALERTSTATE      =5;
const int AESET_MULTILSUPPRES   =6;
const int AESET_SCREENFONT      =7;
const int AESET_PRINTOUTFONT    =8;
const int AESET_SHOWINTERNALS   =9;
const int AESET_BACKCOL         =10;
const int AESET_FORECOL         =11;
const int AESET_BLECOMMENT_POS  =12;
const int AESET_BLECOMMENT_NEG  =13;
// negative filter on DPEs
const int AESET_DPELIST_NEG     =14;
const int AESET_LAST            =15;


// constants for configuration matrix
const int CFG_ATTRINDEX   =1;
const int CFG_VALTYPE     =2;
const int CFG_FORMATSTR   =3; 
const int CFG_MILLISEC    =4;
const int CFG_FUNCTION    =5;
const int CFG_USEFORECOLOR=6;
const int CFG_USEBACKCOLOR=7;
const int CFG_SUBSTRPTR   =8;
const int CFG_LAST        =9;


// nicht in panelglobal weil von registerkarte aufgerufen wird
// + Verwendung in Properties
// keeps sorted columinformaitons per screenType ( ALERTS/EVENTS )

// neu vstn(panelglobal) + ddaRes jetzt panelglobal
//global dyn_anytype ddaRes;

// declaration for query callback function name
const string AESQUERY_WORKFUNC="aes_workCB";
const string AESCONTROL_WORKFUNC="aes_propControlCB";

// for use font prop treating
const string AES_ATTR_FONTSTYLE="_alert_hdl.._alert_font_style";
const string AES_ATTR_FORECOLOR="_alert_hdl.._alert_fore_color";
const string AES_ATTR_BACKCOLOR="_alert_hdl.._alert_color";       // historical !

// global constants
const int AESTYPE_GENERAL=0;    // dummytype if there's no alert or event
const int AESTYPE_ALERTS=1;
const int AESTYPE_EVENTS=2;
const int AESTYPE_ALERTR=3;     // alertRow - pruefe ob hier sinnvoll
const string _AESTYPE_ALERTS="Alerts";  // for use as dollar parameters
const string _AESTYPE_EVENTS="Events"; 
const string _AESTYPE_ALERTR="AlertRow"; 

const int AESTYPE_TOP=3;       // old - pruefen und loeschen
const int AESTYPE_BOTTOM=4;    // old - pruefen und loeschen


// variables for all kind of register/tab operations
const string AES_REGMAIN="reg_main";
const int AESTAB_TOP      =1;  // ersetzen die zu loeschenden typen von oben
const int AESTAB_BOT      =2;
const int AESTAB_GENERAL  =3;
const int AESTAB_ALERTROW =4;
const string _AESTAB_TOP      ="Top";
const string _AESTAB_BOT      ="Bot";
const string _AESTAB_GENERAL  ="General";
const string _AESTAB_ALERTROW ="AlertRow";

// additional constants for register needed - start at 0 !!!
const int AESREGTAB_TOP      =0;  // ersetzen die zu loeschenden typen von oben
const int AESREGTAB_BOT      =1;
const int AESREGTAB_GENERAL  =2;

// used tablenames
const string AES_TABLENAME_TOP    ="table_top";
const string AES_TABLENAME_BOT    ="table_bot";

// used panelnames in register-tab ( this.name )
const string AES_TABNAME_TOP    ="tab_top";
const string AES_TABNAME_BOT    ="tab_bot";
const string AES_TABNAME_GENERAL="tab_general";

const int AES_MODE_CURRENT  =0;
const int AES_MODE_OPEN     =1;
const int AES_MODE_CLOSED   =2;
const int AES_MODE_CLOSEDAPP=3;   // nur fuer alerts/closed mode notwendig - siehe alertsCBOld
const string _AES_MODE_CURRENT="Current";
const string _AES_MODE_OPEN   ="Open";
const string _AES_MODE_CLOSED ="Closed";

const int AES_SUBMODE_UPDATE=1;
const int AES_SUBMODE_APPEND=2;


// constants declaration for dpNames operations
// pruefen und loeschen
const string ASTERISK="*";
const string AESDPNAME_ALERTS="_as_";
const string AESDPNAME_EVENTS="_es_";

// constants for dp name generation
const int AES_DPTYPE_SCREEN         =1;
const int AES_DPTYPE_PROPERTIES     =2;
const string _AES_DPTYPE_SCREEN     ="_AEScreen";
const string _AES_DPTYPE_PROPERTIES ="_AESProperties";



// _add_values filter
const string ADD_VALUE_VALUE   = "Add_Value";           //DPE name for value to filter for
const string ADD_VALUE_COMBINE = "Add_Value_Combine";   //DPE name for logical combine for multimple criterions (AND or OR)
const string ADD_VALUE_COMPARE = "Add_Value_Compare";   //DPE name for Compare Operation (==, LIKE, ...)
const string ADD_VALUE_INDEX   = "Add_Value_Index";     //DPE name for which .._add_value_x to choose. A Number
const string ADD_VALUE_PREFIX  = "_add_value_";         //make the config add_value_x out of the prefix and the indedx
const string AES_ALERT_HDL     = "_alert_hdl";
const string AES_EMPTY_DETAIL  = "..";


// Popup menu constants
const int MENU_PB = 1;  // push button
const int MENU_CB = 2;  // cascade button
const int MENU_SP = 3;  // separator
const int MENU_SB = 4;  // subentry for cascade

/// catalogue
const string AES_CATALOGUE="aes"; //.cat

// attribute offset for _dpid_ and _time_ from callbackfunction
const int ATTR_OFFSET=2;

/**@name Statusobject variables*/
//@{
// STATE CONSTANTS BEGIN
// *********************
// *********************
const int AESTATE_SCREEN_TYPE        =1;
const int AESTATE_ATTRIBUTES         =2;
const int AESTATE_ACTQUERYIDS        =3;
const int AESTATE_QUERY_STATE        =4;
const int AES_QUERY_STARTED=1;
const int AES_QUERY_RUNNING=2;
const int AES_QUERY_PAUSED =3;
const int AES_QUERY_STOPPED=4;
const int AESTATE_CONFIG_NAME        =5;
const int AESTATE_SYSTEMS_2_CONNECT  =6;
const int AESTATE_CONNECTED_SYSTEMS  =7;
const int AESTATE_ACTIVE             =8;
const int AESTATE_MODE               =9;
// STATE CONSTANTS END
// *******************
// *******************
//@} Statusobject variables-end



// MODES fuer BUTTONS !!!!!
const int AES_RUNCMD_START        =1;
const int AES_RUNCMD_PAUSE        =2;
const int AES_RUNCMD_STOP         =3;
const int AES_RUNCMD_CHECK        =4;
const int AES_RUNCMD_STARTINTERVAL=5;

// run modes
const int AES_RUNMODE_STOPPED=0;
const int AES_RUNMODE_PAUSED =1;
const int AES_RUNMODE_RUNNING=2;
const int AES_RUNMODE_PROPEDIT=3;

// changed constants
const int AES_CHANGED_INIT        =0;
const int AES_CHANGED_ACTIVITY    =1;
const int AES_CHANGED_PROPORTION  =2;
const int AES_CHANGED_SCREENTYPE  =3;
const int AES_CHANGED_PROPCONFIG  =4;
const int AES_CHANGED_SCREENCONFIG=5;
const int AES_CHANGED_REGTAB      =6;
const int AES_CHANGED_RUNCMD      =7;
const int AES_CHANGED_AECONFIG    =8;
//new for acknowledge
const int AES_CHANGED_ACKSINGLE   =9;   // single alert acknowledge / column function - we need row info
const int AES_CHANGED_ACKALLVIS   =10;  // ack all visible alerts for specified object( from, to == empty )
const int AES_CHANGED_ACKALL      =11;  // ack all alerts of specified object - dpending on from(==0/first row) - to(should be the last row of the table)
const int AES_CHANGED_PRINTTABLE  =12;
const int AES_CHANGED_SAVETABLE   =13;
const int AES_CHANGED_PROPDIALOG  =14;
//@} Global Variables block-end



/**@name Menu constants declaration*/
//@{
global int AES_MNUA_ALERTS,
AES_MNUA_ACK,
AES_MNUA_ACKALLVISIBLE,
AES_MNUA_INSCOMMENT,
AES_MNUA_PROCPANEL,
// IM 105602
AES_MNUA_PROCPANEL_NEW_WINDOW,
AES_MNUA_PROCPANEL_MODULE,
AES_MNUA_TREND,
AES_MNUA_DETAILS,
AES_MNUA_SUMALERTDETAILS,
AES_MNUA_DISPHELPINFO,
AES_MNUA_PROPERTIES,
AES_MNUA_EXIT, 
AES_MNUA_CHANGEALERTCLASS;

//global int AES_MNUE_ALERTS,
global int AES_MNUE_EVENTS,
AES_MNUE_INSCOMMENT,
AES_MNUE_PROCPANEL,
AES_MNUE_TREND,
AES_MNUE_DETAILS;

global int g_iIndependentAcknowledge; // allow independent acknowledgement (as like the multiinstance alarms) by unsing config entry [general] independentAlertAck = 1
global bool g_bBlockAcknowledge;      // IM 116619

//**************************************************************
// only for performance test
//**************************************************************
global float g_startTime=0.0;
global float g_lastTime=0.0;
global int g_counterTime=0;

global bool lastSystem=false; // IM 63154

global int g_setAliasPermission;

// IM 106289, IM 109086, IM 110452
global dyn_dyn_anytype g_ddaSavedConfigMatrix, g_ddaTempConfigMatrix;

// 118465 - variables for handling of connected dist systems
dyn_string gds_valSystemSelections;
dyn_string gds_connectedSystems;
dyn_string gds_queryConnectedSystems;
dyn_anytype da_screenSettings;
bool b_remoteAllSingleQueries;

dyn_string gds_valDpList;
bool gb_showAllSystems;

// variable to check if a filter for the alert comment is set
bool gb_useBLEComment;

void doTimeStamp( const string text, bool init=false )
{
  return;
}
//**************************************************************
// only for performance test
//**************************************************************


//@} __end Menu constants declaration
void setIsSmallPanel(bool val)
{
  isSmallPanel = val;
  Filter = "'{*}'";
}

//@} Variables-end
//######################################
//######################################
//######################################
/**@name Functions*/
//@{


void aes_testReload( int mode )
{
  dyn_dyn_anytype dda;
  int n;

  
  if( mode == RELOAD_DB )
  {
    // read whole AES configuration from db into vst object
    aes_readConfigurationFromDB();
  }

  // build sorted column struct ddaRes[ALERTS]
  aes_buildColumnStruct( AESTYPE_ALERTS );
  // build sorted column struct ddaRes[EVENTS]
  aes_buildColumnStruct( AESTYPE_EVENTS );

//////////////////
// only testoutput
aes_getColumnObject( AESTYPE_ALERTS, dda );
aes_debug("ALERTS");
for(n=1; n <= dynlen(dda); n++ )
{
  aes_debug("dda["+n+"]="+dda[n] );
}
aes_getColumnObject( AESTYPE_EVENTS, dda );
aes_debug("EVENTS");
for(n=1; n <= dynlen(dda); n++ )
{
  aes_debug("dda["+n+"]="+dda[n] );
}
// only testoutput
//////////////////

  // init attributes and set table properties
  aes_initTable( AESTAB_TOP );
  aes_initTable( AESTAB_BOT );

}

/**
  Checks if there are additional alarm values on the given dp
  @param dpe The DP (e.g. Systemname:Bit1.:_alert_hdl.9)
  @author Thomas Biegelbauer
  @version 1.0
  @return # of additional alarm values
*/
int aes_checkForAddValues(string dpe, time alertTime, int count)
{
  // delete existing table entries
  tabAddValues.deleteAllLines();

  // Check if there are additional alarm values and show their tab accordingly
  if (dpExists(dpSubStr(dpe, DPSUB_SYS_DP_EL) + ":_alert_hdl.._active"))
  {
    dyn_time dtMeldZeit;
    dyn_int diZaehlo;
    dyn_dyn_string dsAddNamo;
    dyn_dyn_anytype dsAddVal;
    alertGetPeriod(alertTime,alertTime,dtMeldZeit,diZaehlo,dpSubStr(dpe, DPSUB_SYS_DP_EL_CONF_DET) + "._add_values",dsAddNamo,dsAddVal);
  
    if(dynlen(dsAddVal) == 0)
      return 0;
    else
    {
      dyn_string dsTemp;
      dyn_string ds_addValues;
      
      if (dynlen(dsAddVal[1]))
      {
        int i_lines;
      
        for(i_lines=1;i_lines<=dynlen(dsAddVal[1]);i_lines++)
        {
          if(dsAddVal[1][i_lines] != "")
          {
            // tfs 29358
            if ( getType(dsAddVal[1][i_lines]) == BOOL_VAR )
              setValue("tabAddValues", "appendLine", "#1", i_lines, "#2", (int)dsAddVal[1][i_lines]);
            else
              setValue("tabAddValues", "appendLine", "#1", i_lines, "#2", dsAddVal[1][i_lines]);
            
            dynAppend(ds_addValues,dsAddVal[1][i_lines]);
          }
        }
        return dynlen(ds_addValues);
      }
    }
  }
  return 0;
}


synchronized void aes_initTable( const string tableName, const int screenType, const dyn_string &visibleColumns )
{
  string oldColName;
  shape tableShape;
  dyn_dyn_anytype dda;
  string gridColor, sTmp;
  int n, l;
  bool colVis, dcw;
  bool useFontProp;
  langString font;

  string colName;
  int colWidth;

  mapping dcwMap;
  int fullWidth, fullDynWidth, dcwDiff, dcwLen, dcwFound=0;
  float dcwFact;

  g_bBlockAcknowledge = FALSE;   // IM 116619 reset on opening  
  int x,y;
  getValue("table_top", "size", x, y); 
  AES_MAX_SCREENWIDTH = x-1 ;     // wrong size 
 
  if (!g_alertRow)
     AES_MAX_SCREENWIDTH = AES_MAX_SCREENWIDTH - 22;   //  991 (NV, 990 NG) - 22 = 968, 22 = Scrollbar
  else
     AES_MAX_SCREENWIDTH = AES_MAX_SCREENWIDTH - 3;  



  //DebugN("INIT TABLE=" + tableName );


////// test fuer refresh
//dynClear( ddaRes );   /// global !!!
//aes_buildColumnStruct( AESTYPE_ALERTS );
//aes_buildColumnStruct( AESTYPE_EVENTS );

  langString ltHeader;

  // internal column counter - first column starts at position 0
  int ic=0;
  int mode, idx;
  int dcwAdd, dcwAddSum;
  dyn_string dsTmp;

  int lVisCol=dynlen( visibleColumns );


  tableShape=getShape( tableName );

  aes_getPropMode( g_propDp, mode );

  // im modus aktuell sollte eigentlich TABLE_SELECT_NOTHING
//  if( mode != AES_MODE_CURRENT )
  if( !g_alertRow )    // we want to select at any mode ??????
  {
    //tableShape.tableMode=TABLE_SELECT_BROWSE;
    //tableShape.selectByClick=TABLE_SELECT_LINE;
    tableShape.tableMode = TABLE_SELECT_MULTIPLE;
    tableShape.selectByClick=TABLE_SELECT_LINE;
  }
  else
  {
    tableShape.tableMode=TABLE_SELECT_NOTHING;
  }
  // setting global table properties e.g. grid color
  gridColor=aes_getTableSettingsValue(screenType, CB_GRIDCOL);
  tableShape.gridColor=gridColor;
  tableShape.foreCol=aes_getTableSettingsValue(screenType, CB_HFORECOL );

  string backCol=aes_getTableSettingsValue(screenType, CB_BACKCOL );
  if(strpos(backCol,"/") > 0)
    tableShape.alternatingRowColors(strsplit(backCol,"/"));
  else
    tableShape.backCol=aes_getTableSettingsValue(screenType, CB_BACKCOL );

  tableShape.blankNonExistingRows((bool)aes_getGeneralSettingsValue((tableName == AES_TABLENAME_TOP)?CB_TOPHIDE:CB_BOTHIDE));  
  
  //font - new with langString!!!
  font=aes_getTableSettingsValue( screenType, TE_SCREENFONT );

  //idx=getLangIdx( getActiveLang() ) + 1;
  idx=getActiveLang() + 1;

  dsTmp=font;
  if( dsTmp[idx] == "" || dsTmp[idx] == AES_LINUXDEF_FONT )
  {
    dsTmp[idx]=AES_DEF_FONT;
    font=dsTmp;
  }

  tableShape.font=font;

  // getting column object for choosen type
  aes_getColumnObject( screenType, dda );
  l=dynlen( dda );

  // set default column name ( #{n} ) to avoid multiple column names during set operation
  for( n=0; n < AES_MAX_COLUMNS; n++ )
  {
    tableShape.columnName(n, "#"+n);
  }
  // traverse all columns
  for( n=1; n < dynlen( dda ); n++ )
  {
    dcw     =dda[n][CHK_DYNCOLUMNWIDTH];
    colName =dda[n][TE_NAME];
    colWidth=dda[n][TE_SCREENWIDTH];
    colVis  =dda[n][CHK_VISIBLE];

    // find out dyn col width list
    if( ( colVis == true ) &&
        ( colWidth > 0 ) )
    {
      if( lVisCol > 0 )
      {
        if( dynContains( visibleColumns, colName ) > 0 )
        {
          if( dcw == true )
          {
            fullDynWidth += colWidth;
            dcwMap[colName]=colWidth;
          }
          fullWidth += colWidth;
        }
      }
      else
      {
        if( dcw == true )
        {
          fullDynWidth += colWidth;
          dcwMap[colName]=colWidth;
        }
        fullWidth += colWidth;
      }
    }
  }

  dcwLen=mappinglen( dcwMap );
  dcwDiff=AES_MAX_SCREENWIDTH - fullWidth + 1;

  if( fullDynWidth > 0 )
    dcwFact=(float)dcwDiff/(float)fullDynWidth;

  // set column properties e.g. header,width,name....
  
  bool bShapeVisibility = tableShape.visible();

  tableShape.visible = FALSE;

  for( n=1; n<=AES_MAX_COLUMNS; n++ )
  {
    tableShape.columnVisibility(n-1)=FALSE;
   
    if (n<=l)                                  // l = dynlen ( dda )
    {
      colVis = dda[n][CHK_VISIBLE];
      tableShape.columnVisibility(n-1)=colVis;  
    }
    else
    {
      for( n=ic; n < AES_MAX_COLUMNS; n++ )
      {
       	tableShape.columnName(n, "#"+n);
        tableShape.columnVisibility(n)=false;
      }
      break;   
    }

    dcw     =dda[n][CHK_DYNCOLUMNWIDTH];
    colName =dda[n][TE_NAME];
    colWidth=dda[n][TE_SCREENWIDTH];
    colVis  =dda[n][CHK_VISIBLE];

    if( colVis )
    {
      tableShape.columnEditable(ic)=false;  // to ensure onClick command !!!!
      tableShape.columnVisibility(ic)=true; // IM 63576

      // calculate dcw add
      // if we have a positiv dcwdiff and map has at least one item
      if( ( dcwDiff > 0 ) && ( dcwLen > 0 ) )
      {
        // try to find colname in dcw map
        if( mappingHasKey( dcwMap, colName ) == true )
        {
          dcwFound++;

          // if we are at last position
          if( dcwFound >= dcwLen )
          {
            dcwAdd=dcwDiff - dcwAddSum;
          }
          else
          {
            dcwAdd=(int)( dcwFact * (float)( colWidth ) );
            dcwAddSum += dcwAdd;
          }
        }
        else
        {
          dcwAdd=0;
        }
      }
      else
      {
        dcwAdd=0;
      }
      
      // if any visible columns ( properties ) were defined
      if( lVisCol > 0 )
      {
        if( dynContains( visibleColumns, colName ) > 0 )
        {
          // column visible, set configuration column with
          if( colWidth == 0 )
          {
            tableShape.columnWidth( ic, 0 );
          }
          else
          {
            tableShape.columnWidth( ic, ( colWidth + dcwAdd ) );
          }
        }
        else
        {
          // if column(name) is not within the visible list, set column with to zero
          tableShape.columnWidth( ic, 0 );
        }
      }
      else
      {
        // new - if no visible column is defined, nothing will be displayed
        tableShape.columnVisibility( ic )=false;
      }

      ltHeader=dda[n][LT_HEADERNAME];
      // with fallback !!!
      sTmp=aes_getStringFromLangString( ltHeader );
      
      tableShape.columnHeader( ic, sTmp );

      tableShape.columnName(ic, colName);

      // increment internal counter
      ic++;
    }
  }

  tableShape.visible = bShapeVisibility;

  // tableShape.visible=true;
}


void aes_createAttributes( int screenType, dyn_string &resAttributes )
{
  int n, maxColumn;
  dyn_dyn_anytype dda;
  dyn_string attrRes;
  bool useFontProp=false;
  aes_getColumnObject( screenType, dda );

  //dynClear( resAttributes );
  
  if( screenType == AESTYPE_EVENTS )
  {
    useFontProp=false;
  }
  else
  {
    // read useFontProperty parameter - special treating for bold/italic fonts
    useFontProp=aes_getTableSettingsValue( screenType, CHK_USEAFONTPROP );
  }

  maxColumn=dynlen(dda);

  // traversing all columns
  for(n=1; n <= maxColumn; n++ )
  {
    dyn_anytype column;
    dyn_string attributes;
    string attribute;
    string onClick;
    string func;
    int valueType;

    dyn_string attr2add;
    dyn_int diDummy;

    column=dda[n];

    valueType=column[RB_VALUETYPE];
    
    attributes=column[SL_ARGUMENTS];
    attribute=column[CB_ATTRIBUTE];

    onClick=column[CB_ONCLICK];
    func=column[CB_FUNCTION];

    // new - for dynamic handling
    onClick =aes_getPureFunctionName( onClick );
    func =aes_getPureFunctionName( func );


    diDummy=(dyn_int)aes_getAttrIndexList( onClick, valueType, func, attribute, attributes, screenType, attr2add, true );

    if( dynlen(attr2add) > 0 )
    {
      dynAppend( attrRes, attr2add );
    }
    dynClear( attr2add );
  }

  // to ensure proper work of the following functions 
  dynUnique( attrRes );

  aes_addCBAttributes( screenType, attrRes );

  aes_addMandatoryAttributes( screenType, useFontProp, attrRes );

  dynClear( resAttributes );
  resAttributes=attrRes;
}


void aes_readConfigurationFromDB()
{
   // reading values from db into structure - vst
  aec_objectIterator( FIRST_GENERAL, LAST_GENERAL, AESTYPE_GENERAL, OM_GET_DB );
  aec_objectIterator( FIRST_TABLE,   LAST_TABLE,   AESTYPE_ALERTS,  OM_GET_DB );
 
  if (!g_alertRow)
  aec_objectIterator( FIRST_TABLE,   LAST_TABLE,   AESTYPE_EVENTS,  OM_GET_DB );
  // columns
  aec_objectIterator( FIRST_COLUMN, LAST_COLUMN, AESTYPE_ALERTS, OM_GET_DB );

  if (!g_alertRow)
  aec_objectIterator( FIRST_COLUMN, LAST_COLUMN, AESTYPE_EVENTS, OM_GET_DB );
}


void aes_initGlobalShapes()
{
  gs_tab_top=getShape("table_top");

  gs_tab_bot=getShape("table_bot");
}


void aes_reloadConfig( const int mode )
{
  dynClear( ddaRes );


//////////////////////////
//////////////////////////
//////////////////////////
// ACHTUNG - columnname stimmt nicht mehr ( #1,#2 etc. ) - loesung in initTable
// mit idx setzen => ueber "columnToName", idx to get oldColumnName
  
  // loeschen
  aes_testReload( mode );
}


/**@name Table callbackfunctions*/
//@{

void aes_doColumnDblClick( const string &propDp, int row, string column, anytype value, mapping mTableRow )
{
  const int d=0;
  int screenType;
  int colIdx;
  string funcName, dpid;
  string propDpName;         
  int res;
  unsigned runMode;
  bool ackable, ackOldest;   
  unsigned propMode;         
  int tabType = AESTAB_BOT;  
  aes_getRunMode( propDp, runMode );
  if( runMode != AES_RUNMODE_RUNNING )
  {
    if( !AES_FORCE_CLICK )
      return;
  }

  // no click functions available for user guest
  if( !getUserPermission( AES_PERMLEVEL_COLDBLCLICK ) )
    return;

  if( row < 0 )
    return;

  res=aes_getDpidFromTable( row, dpid, mTableRow );

  if( res != 0 )
  {
    return;
  }

  aes_getScreenType( propDp, screenType );
  funcName=aes_getOnDblClickFuncName( screenType );

  // necessary for dynamic changes
  funcName=aes_getPureFunctionName( funcName );

  aes_debug("columnDblClick dp="+propDp+" value="+value+" func="+funcName, d );

  if( funcName == AECSF_DISPLAYAHELP )
  {
    // help info anzeigen / extension parsen pnl,doc,txt,html => linux ?????
    aes_displayAlertHelp( dpid );
  }
  else if( funcName == AECSF_DISPLAYPANEL )
  {
    // alert_hdl.._panel anzeigen / mit parameter !!!
    aes_displayAlertHdlPanel( dpid, row );
  }
  else if( funcName == AECSF_DISPLAYDETAIL )
  {
    aes_displayDetails( screenType, row, propDp, mTableRow );
  }

  else if( funcName == AECSF_DOACKNOWLEDGE )  
  {
    // get the panelglobal propDpNames ( for top/bot ) because we have no scope to g_propDp there
    aes_getTBPropDpName( tabType, propDpName );
    aes_getScreenType( propDpName, screenType );
  
    if (mappingHasKey(mTableRow, _ACKABLE_))
    ackable   = mTableRow[_ACKABLE_];
    else  // e.g. in EventScreen
      ackable = false;
  
    if (mappingHasKey(mTableRow, _ACK_OLD_))
      ackOldest = mTableRow[_ACK_OLD_];
    else  // e.g. in EventScreen
      ackOldest = false;
    
    //aes_debug("columnClick tabType="+tabType+" value="+value+" func="+funcName, 1 );

    if( propMode == AES_MODE_CLOSED && ( funcName == AECSF_DOACKNOWLEDGE ) && ackable )
    {
      aec_warningDialog( AEC_WARNINGID_ACKNOTPOSSIBLE );
      return;
    }
  
    res=aes_getDpidFromTable( row, dpid, mTableRow );
    if( res != 0 )
    {
      return;
    }
    
    if( runMode != AES_RUNMODE_RUNNING )
    {
      aec_warningDialog( AEC_WARNINGID_ACKNOTPOSINSTOP );
      return;
    }
    
    if (ackable && !ackOldest && g_iIndependentAcknowledge!=1)
    {
      bool bOneRowPerDpe;
      dpGetCache(propDpName + ".Alerts.FilterState.OneRowPerAlert"+AES_ONLVAL, bOneRowPerDpe);
      if( bOneRowPerDpe ) //oneRowPerDPE-Filter
      {
        
// look for partner alarm
// ack partner alarm      
        string sDpe = dpSubStr(mTableRow[_DPID_], DPSUB_SYS_DP_EL);
        string sSys = dpSubStr(mTableRow[_DPID_], DPSUB_SYS);
        time t = mTableRow[_TIME_];
        string sTime = t;
        int iCnt = mTableRow[_COUNT_];

        string sSelect = "SELECT ALERT '_alert_hdl.._partner','_alert_hdl.._partn_idx', '_alert_hdl.._oldest_ack' " +
                         " FROM '"+sDpe+"' "+
                         " WHERE '_alert_hdl.._partner' == \""+sTime+"\" AND '_alert_hdl.._partn_idx' == "+iCnt +" AND '_alert_hdl.._oldest_ack' == 1"+
                         (sSys+":" != getSystemName()+":"?" REMOTE '"+sSys+"'":"");
        dyn_dyn_anytype dda;
        dpQuery( sSelect, dda );

        if (dynlen(dda)==2 && dynlen(dda[2])>=2) //ackable parnter alarm found
        {
          dyn_float df;
          dyn_string ds;
          ChildPanelOnCentralModalReturn("vision/MessageInfo", "question",
                             makeDynString("$1:" + getCatStr("aes", "ackCameWithWentAlarm"),
                                           "$2:" + getCatStr("sc", "yes"),
                                           "$3:" + getCatStr("sc", "no")), df, ds);

          if ( !dynlen(df) || !df[1] ) // User said no, he does not want to ack CAME and WENT alarm
            return;          
          
          atime atPartner = dda[2][2];
        
          mapping mRow;
          mRow[_DPID_]=getAIdentifier(atPartner);
          mRow[_ACKABLE_]=TRUE;
          mRow[_TIME_]=(time)atPartner;
          mRow[_COUNT_]=getACount(atPartner);

        //change format of mapping because ack supports multiple rows
          mapping mTableMultipleRows;
          mTableMultipleRows[row] = mRow;
          mTableMultipleRows[row+1] = mTableRow;
          aes_changedAcknowledgeWithRowData( AES_CHANGED_ACKSINGLE, tabType, mTableMultipleRows );
          return;
        }
      }
    }

    // call single acknowledge with row information
    if( ackable && (ackOldest || g_iIndependentAcknowledge==1))
    {
      mapping mTableMultipleRows;
      //change format of mapping because ack supports multiple rows
      mTableMultipleRows[row] = mTableRow;
      aes_changedAcknowledgeWithRowData( AES_CHANGED_ACKSINGLE, tabType, mTableMultipleRows );
    }
    else if( ackable && !ackOldest )
    {
      aec_warningDialog( AEC_WARNINGID_NOTTHEOLDESTALERT );
    }
  }

  else
  {
    aes_debug( __FUNCTION__+"() / Unknown function name="+funcName+" !" );
  }

}


int aes_getDpidFromTable( const int row, string &dpid, mapping mTableRow )
{
  const int d=0;

  string fullName;
  dpid="";

  if( row < 0 )
    return 0;

  fullName = mTableRow[_DPID_];
  if( fullName == "" )
    return 0;

  // remove possible attribute/range
  dpid=dpSubStr( fullName, DPSUB_SYS_DP_EL );  
  aes_debug( __FUNCTION__+"() / row="+row+" full="+fullName+" substr="+dpid , d );

  if( dpid == "" )
    return -1;
  else
    return 0;

}


void aes_displayAlertHdlPanel( const string &dpid, const int row=0, const string module="" )
{
  string panel, path;
  dyn_string panelParams;
  
  // getting alert panel information
  dpGet(  dpid + ":_alert_hdl.._panel", panel,
          dpid + ":_alert_hdl.._panel_param", panelParams );

  panel=strltrim( strrtrim( panel ) );
  if( panel == "" )
  {
    // emmpty helpstring - nothing to do
    return;
  }

  // check for panelpath
  path=getPath( PANELS_REL_PATH, panel ); 

  if( path == "" )
  {
    // dialog - no valid panel path
    return;
  }
  else
  {
    // IM 105602
    if ( module == "_newWindow_" )
    {
      // user wants to open a new window
      ChildPanelOnCentralModal( panel, "", panelParams );
    }
    else
    {
      if ( isModuleOpen( module ) )
      {
        // open the panel inside the pt module
        RootPanelOnModule( panel, "", module, panelParams );
      }
      else
      {
        // pt closed, fallback: open panel in new child panel
        ChildPanelOnCentralModal( panel, "", panelParams );
      }
    }
  }
}


void aes_displayAlertHelp( const string &dpid, const int row=0 )
{
  int extType;
  //langString helpAttr;
  string helpAttr;
  string path;

  // getting help information
  dpGet( dpid + ":_alert_hdl.._help", helpAttr );
  
  helpAttr=strltrim( strrtrim( helpAttr ) );
  if( helpAttr == "" )
  {
    // emmpty helpstring - nothing to do
    return;
  }

  // check for panelpath
  path=getPath( PANELS_REL_PATH, (string)helpAttr ); 

  if( path == "" )
  {
    // should open a txt, doc, html file with explorer or netscape
    std_help( (string)helpAttr );
  }
  else
  {
    // we have to open the helpAttr object as panel
    ChildPanelOnCentralModal( (string)helpAttr, "", makeDynString("") );
  }

}


int aes_getHelpExtension( const string &helpAttr, int &extType )
{
  dyn_string extList, dsSplit;
  string ext;
  int pos;
  
  // globale initialisierung !!!
  extList[AESEXT_PNL]="pnl";
  extList[AESEXT_DOC]="doc";
  extList[AESEXT_TXT]="txt";
  extList[AESEXT_HTM]="html";

  dsSplit=strSplit( helpAttr, "." );
  l=dynlen( dsSplit );

  if( l > 0 )
  {
    // the extionsion should be the last element
    ext=dsSplit[l];
  }
  else
  {
    return 0;
  }

  pos=dynContains( extList, ext );

  if( pos > 0 )
  {
    extType=pos;
    return 0;
  }
  else
    return -1; 
}


anytype aes_getColumnObjectValue( const int screenType, const int column, const int objIdx )
{
  anytype aVal;
  dyn_dyn_anytype ddaCol;
  
  aes_getColumnObject( screenType, ddaCol );
  
  aVal=ddaCol[column][objIdx];
  return aVal;
}


int aes_getColumnIndex4Name( const int screenType, const string &colName )
{
  int n, l;
  dyn_dyn_anytype ddaCol;
  bool found=false;
  string name;
  
  aes_getColumnObject( screenType, ddaCol );
  
  l=dynlen(ddaCol);
  for( n=1; n <= l; n++ )
  {
    name=ddaCol[n][TE_NAME];
    if( name == colName )
    {
      found=true;
      break;
    }
  }

  if( found )
    return n;
  else
    return 0;

}


string aes_getOnClickFuncName( const int screenType, const int column )
{
  string funcName=AECSF_NONE;
  funcName=aes_getColumnObjectValue( screenType, column, CB_ONCLICK );

  return funcName;
}


string aes_getOnDblClickFuncName( const int screenType )
{
  string funcName;

  funcName=aes_getTableSettingsValue( screenType, CB_DBLCLICK );
  return funcName;
}


void aes_getTBPropDpName( const int tabType, string &propDpName )
{
  // uses the panelglobal propdpnames
  if( tabType == AESTAB_TOP )
    propDpName=g_propDpNameTop;
  else
    propDpName=g_propDpNameBot;

}


void aes_doColumnClick( int tabType, int row, string column, string value, mapping mTableRow )
{
  int screenType;
  int colIdx;
  string funcName;
  string propDpName;
  string dpid;
  bool ackable, ackOldest;

  int res=0;
  unsigned propMode, runMode;

  // no click functions available for user guest
  if( !getUserPermission( AES_PERMLEVEL_COLCLICK ) )
    return;
  if(globalExists("g_cfgUsrDepAlarms") && (g_cfgUsrDepAlarms == 1) && (value == UDA_noAck_Token))//column == acknowledge but user is not allowed ( ack == ' < > ')
    return;

  // illegal line selected
  if( row < 0 )
    return;

  // get the panelglobal propDpNames ( for top/bot ) because we have no scope to g_propDp there
  aes_getTBPropDpName( tabType, propDpName );
  aes_getScreenType( propDpName, screenType );
  
  
  
  aes_getPropMode( propDpName, propMode );
  colIdx=aes_getColumnIndex4Name( screenType, column );
  funcName=aes_getOnClickFuncName( screenType, colIdx );

  aes_getRunMode( propDpName, runMode );
  if( runMode != AES_RUNMODE_RUNNING )
  {
    if( !AES_FORCE_CLICK )
      return;
  }

  // necessary for dynamic changes
  funcName=aes_getPureFunctionName( funcName );

  if (mappingHasKey(mTableRow, _ACKABLE_))
    ackable   = mTableRow[_ACKABLE_];
  else  // e.g. in EventScreen
    ackable = false;
  
  if (mappingHasKey(mTableRow, _ACK_OLD_))
    ackOldest = mTableRow[_ACK_OLD_];
  else  // e.g. in EventScreen
    ackOldest = false;
    
  //aes_debug("columnClick tabType="+tabType+" value="+value+" func="+funcName, 1 );

  if( propMode == AES_MODE_CLOSED && ( funcName == AECSF_DOACKNOWLEDGE ) && ackable )
  {
    aec_warningDialog( AEC_WARNINGID_ACKNOTPOSSIBLE );
    return;
  }
  
  res=aes_getDpidFromTable( row, dpid, mTableRow );
  if( res != 0 )
  {
    return;
  }

//  if( funcName == AECSF_ACKNOWLEDGE )
  if( funcName == AECSF_DOACKNOWLEDGE )
  {
    if( runMode != AES_RUNMODE_RUNNING )
    {
      aec_warningDialog( AEC_WARNINGID_ACKNOTPOSINSTOP );
      return;
    }
    
    if (ackable && !ackOldest && g_iIndependentAcknowledge!=1)
    {
      bool bOneRowPerDpe;
      dpGetCache(propDpName + ".Alerts.FilterState.OneRowPerAlert"+AES_ONLVAL, bOneRowPerDpe);
      if( bOneRowPerDpe ) //oneRowPerDPE-Filter
      {
        
// look for partner alarm
// ack partner alarm      
        string sDpe = dpSubStr(mTableRow[_DPID_], DPSUB_DP_EL);
        string sSys = dpSubStr(mTableRow[_DPID_], DPSUB_SYS);
        time t = mTableRow[_TIME_];
        string sTime = t;
        int iCnt = mTableRow[_COUNT_];

        string sSelect = "SELECT ALERT '_alert_hdl.._partner','_alert_hdl.._partn_idx','_alert_hdl.._oldest_ack' " +
                         "FROM '"+sDpe+"'" + 
                         (sSys != getSystemName() ? " REMOTE '"+sSys+"'":"") + 
                         " WHERE '_alert_hdl.._partner' = \""+sTime+"\" AND '_alert_hdl.._partn_idx' = "+iCnt+" AND '_alert_hdl.._oldest_ack' = 1";
        dyn_dyn_anytype dda;
        dpQuery( sSelect, dda );

        if (dynlen(dda)==2 && dynlen(dda[2])>=2) //ackable parnter alarm found
        {
          dyn_float df;
          dyn_string ds;
          ChildPanelOnCentralModalReturn("vision/MessageInfo", "question",
                             makeDynString("$1:" + getCatStr("aes", "ackCameWithWentAlarm"),
                                           "$2:" + getCatStr("sc", "yes"),
                                           "$3:" + getCatStr("sc", "no")), df, ds);

          if ( !dynlen(df) || !df[1] ) // User said no, he does not want to ack CAME and WENT alarm
            return;          
          
          atime atPartner = dda[2][2];
        
          mapping mRow;
          mRow[_DPID_]=getAIdentifier(atPartner);
          mRow[_ACKABLE_]=TRUE;
          mRow[_TIME_]=(time)atPartner;
          mRow[_COUNT_]=getACount(atPartner);

        //change format of mapping because ack supports multiple rows
          mapping mTableMultipleRows;
          mTableMultipleRows[row] = mRow;
          mTableMultipleRows[row+1] = mTableRow;
          aes_changedAcknowledgeWithRowData( AES_CHANGED_ACKSINGLE, tabType, mTableMultipleRows );
          return;
        }
      }
    }

    // call single acknowledge with row information
    if( ackable && (ackOldest || g_iIndependentAcknowledge==1))
    {
      if (g_bBlockAcknowledge)  // IM 116619
        return;
      else
        startThread("aes_blockAcknowledeThread");
      mapping mTableMultipleRows;
      //change format of mapping because ack supports multiple rows
      mTableMultipleRows[row] = mTableRow;
      aes_changedAcknowledgeWithRowData( AES_CHANGED_ACKSINGLE, tabType, mTableMultipleRows );
    }
    else if( ackable && !ackOldest )
    {
      aec_warningDialog( AEC_WARNINGID_NOTTHEOLDESTALERT );
    }
  }
  else if( funcName == AECSF_INSERTCOMMENT )
  {
    if( runMode != AES_RUNMODE_RUNNING )
    {
      aec_warningDialog( AEC_WARNINGID_INSCOMNOTPOSINSTOP );
      return;
    }
    aes_insertComment( row, mTableRow );
  }
  else if( funcName == AECSF_DISPLAYPANEL )
  {
    // IM 105602
    mapping mTableMultipleRows;
    mTableMultipleRows[row] = mTableRow;

    bool askUser;
    dpGet("_AESConfig.generalSettings.AESGlobalSettings.askDisplayProcessPanel:_online.._value", askUser);
    
    if (askUser)
    {
      // display menu
      aes_displayMenu( screenType, row, column, value, propDpName, "", tabType, false, mTableMultipleRows );
    }
    else
    {
      // open alert panel in new window
      aes_displayAlertHdlPanel( dpid, row, "_newWindow_" );
    }
  }
  else if( funcName == AECSF_DISPLAYDETAIL )
  {
    aes_displayDetails( screenType, row, propDpName, mTableRow );
  }
  else if( funcName == AECSF_USERDEFFUNC )
  {
    aes_userDefFunc( screenType, tabType, row, colIdx, value, mTableRow );
  }
  else
  {
    aes_debug( __FUNCTION__+"() / Unknown function name="+funcName+" !" );
  }

}
//@} Table callbackfunctions-end


void aes_userDefFunc( int screenType, int tabType, int row, int colIdx, string value, mapping mTableRow )
{
//  DebugN("USERDEFFUNC screenType="+screenType+" tabType="+tabType+" row="+row+" column="+colIdx+" value="+ value );
  invokedAESUserFunc( this.name, screenType, tabType, row, colIdx, value, mTableRow );
}


anytype aes_getTableSettingsValue( int screenType, int objIdx )
{

  int offset,min,max;
  dyn_anytype da;
  anytype value;

  if( screenType == AESTYPE_ALERTS )
  {
    offset=0;
  }
  else
  {
    offset=EOFF;
  }

  aec_getObjectFromVST( objIdx+offset, da ); 
  value=da[OIX_VALUE];

  return value;
}


anytype aes_getGeneralSettingsValue( int objIdx )
{
  dyn_anytype da;
  anytype value;

  if( objIdx > aes_getVstLen() )
  {
    return (int)0;
    aes_debug("aes_getGeneralSettingsValue - objIdx="+objIdx+" not found!", 5 );
  }

  aec_getObjectFromVST( objIdx, da ); 
  value=da[OIX_VALUE];

  return value;

}


int aes_getVstLen()
{
  int len;

  if( g_initFromAES )
  {
    len=dynlen( vstn );
  }
  else
  {
    len=dynlen( vst );
  }

  return len;

}


int aes_getDefaultPropertyName( int type, string &propName )
{
  // reading default property name from _AESConfig DP
  propName="";

  if( propName == "" )
  {
    return 0;
  }
  else
  {
    return 1;
  }

  return 0;

}

////////// Top/Bot/General 
/////////////////////begin
//*****************
// lang independend
string aes_getTBStr( int tabType )
{
  if( tabType == AESTAB_TOP)
    return _AESTAB_TOP;
  else if( tabType == AESTAB_BOT)
    return _AESTAB_BOT;
  else if( tabType == AESTAB_GENERAL)
    return _AESTAB_GENERAL;
  else if( tabType == AESTAB_ALERTROW)
    return _AESTAB_ALERTROW;

  return "";
}

int aes_getTBNum( string tabType )
{
  if( tabType == _AESTAB_TOP )
    return AESTAB_TOP;
  else if( tabType == _AESTAB_BOT )
    return AESTAB_BOT;
  else if( tabType == _AESTAB_GENERAL )
    return AESTAB_GENERAL;
  else if( tabType == _AESTAB_ALERTROW )
    return AESTAB_ALERTROW;

  return 0;
}

//***************
// lang dependend
string aes_getTBStrLang( int tabType )
{
  string top,bot,general,alertr;
  top=aes_getCatStr( AESMID_TOP );
  bot=aes_getCatStr( AESMID_BOT );
  general=aes_getCatStr( AESMID_GENERAL );
  alertr=aes_getCatStr( AESMID_ALERTR );

  if( tabType == AESTAB_TOP)
    return top;
  else if( tabType == AESTAB_BOT)
    return bot;
  else if( tabType == AESTAB_GENERAL)
    return general;
  else if( tabType == AESTAB_ALERTROW)
    return alertr;

  return "";
}

int aes_getTBNumLang( string tabType )
{
  string top,bot,general,alertr;
  top=aes_getCatStr( AESMID_TOP );
  bot=aes_getCatStr( AESMID_BOT );
  general=aes_getCatStr( AESMID_GENERAL );
  alertr=aes_getCatStr( AESMID_ALERTR );

  if( tabType == top )
    return AESTAB_TOP;
  else if( tabType == bot )
    return AESTAB_BOT;
  else if( tabType == general )
    return AESTAB_GENERAL;
  else if( tabType == alertr )
    return AESTAB_ALERTROW;

  return 0;
}
//////// Top/Bot/General 
/////////////////////end




////////// Alerts/Events/Alertrow
////////////////////////////begin
//*****************
// lang independend
string aes_getAEStr( int screenType )
{
  if( screenType == AESTYPE_ALERTS)
    return _AESTYPE_ALERTS;
  else if ( screenType == AESTYPE_EVENTS)
    return _AESTYPE_EVENTS;
  else if ( screenType == AESTYPE_ALERTR)
    return _AESTYPE_ALERTROW;

  return "";
}


int aes_getAENum( string screenType )
{
  if( screenType == _AESTYPE_ALERTS)
    return AESTYPE_ALERTS;
  else if ( screenType == _AESTYPE_EVENTS)
    return AESTYPE_EVENTS;
  else if ( screenType == _AESTYPE_ALERTR)
    return AESTYPE_ALERTROW;

  return 0;
}

//***************
// lang dependend
string aes_getModeStrLang( int mode )
{
  const int d=0;

  string open, current, closed, tmp, ret;

  if( mode == AES_MODE_CURRENT )
    ret=aes_getCatStr( AESMID_CURRENT );
  else if ( mode == AES_MODE_OPEN )
    ret=closed=aes_getCatStr( AESMID_OPEN );
  else if ( mode == AES_MODE_CLOSED )
    ret=current=aes_getCatStr( AESMID_CLOSED );
  else if ( mode == AES_MODE_CLOSEDAPP )
    ret=current=aes_getCatStr( AESMID_CLOSED );   // the same string as closed
  else
  {
    tmp="Unknown mode " + mode + " !";
    ret="";
  }

  aes_debug( __FUNCTION__ + "() / mode(type)=" + mode + " text=" + ret, d );

  return ret;
}


string aes_getAEStrLang( int screenType )
{
  string alerts, events, alertr;
  alerts=aes_getCatStr( AESMID_ALERTS );
  events=aes_getCatStr( AESMID_EVENTS );
  alertr=aes_getCatStr( AESMID_ALERTR );

  if( screenType == AESTYPE_ALERTS)
    return alerts;
  else if ( screenType == AESTYPE_EVENTS)
    return events;
  else if ( screenType == AESTYPE_ALERTR)
    return alertr;

  return "";
}


int aes_getAENumLang( string screenType )
{
  string alerts, events, alertr;
  alerts=aes_getCatStr( AESMID_ALERTS );
  events=aes_getCatStr( AESMID_EVENTS );
  alertr=aes_getCatStr( AESMID_ALERTR );

  if( screenType == alerts )
    return AESTYPE_ALERTS;
  else if ( screenType == events )
    return AESTYPE_EVENTS;
  else if ( screenType == alertr )
    return AESTYPE_ALERTROW;

  return 0;
}
////////// Alerts/Events/Alertrow
//////////////////////////////end



string aes_getRunModeStrLang( unsigned runMode )
{
  string stopped, running;

  stopped=aes_getCatStr( "mid_stopped" );
  running=aes_getCatStr( "mid_runing" );

  if( runMode == AES_RUNMODE_STOPPED )
    return stopped;
  else if ( runMode == AES_RUNMODE_RUNNING )
    return running;

  return "";
}


void aes_doPropertyChild( const string &propDp, const string &balPropDp, const string &configName, const unsigned tabType, dyn_string &newConfigList, unsigned &newSelPos, int &retState, bool alertRow=false, bool configPanel=false )
{
  const int d=0;
  unsigned screenType;
  string tabTypeStr, screenTypeStr;

  dyn_string ds;
  dyn_float df;
  int oldRunMode;

  string propName, header;
  string panelName="vision/aes/AES_properties.pnl";

  dyn_dyn_anytype dda;
  int count, i, j;
  bool vis;
  int width;
  dyn_string colNames, colTitles;
  dyn_string tcolNames, tcolTitles;
  
  aes_getScreenType( propDp, screenType ); 

  aes_getVisibleColumnList( screenType, colNames, colTitles, true, configPanel );

//aes_debug( __FUNCTION__+"() >>>>>>>>>>>>>>>>>>>>>>> colNames=" + colNames, 10 );
//aes_debug( __FUNCTION__+"() >>>>>>>>>>>>>>>>>>>>>>> colTitles=" + colTitles, 10 );

  propName=aes_getCatStr( "title_properties" );
  dyn_int dWith;

  if( alertRow )
  {
    if( g_alertRow )
    {
      alertRow=true;
      header=propName + " / " + aes_getCatStr( "mid_alertr" );
    }

		dpGetCache( "_AESConfigRow.tables.alertTable.columns.name:_online.._value", colNames,
		       "_AESConfigRow.tables.alertTable.columns.nameHeader:_online.._value", colTitles,
		       "_AESConfigRow.tables.alertTable.columns.widthScreen:_online.._value",dWith);

  }
  else
  {
    aes_getScreenType( propDp, screenType );

    tabTypeStr=aes_getTBStrLang( tabType );
    screenTypeStr=aes_getAEStrLang( screenType );

    header=propName + " / " + tabTypeStr + " / " + screenTypeStr;

    if ( screenType == AESTYPE_EVENTS)
     dpGetCache( "_AESConfig.tables.eventTable.columns.name:_online.._value", colNames,
       "_AESConfig.tables.eventTable.columns.nameHeader:_online.._value", colTitles,
       "_AESConfig.tables.eventTable.columns.widthScreen:_online.._value",dWith);
    else
	    dpGetCache( "_AESConfig.tables.alertTable.columns.name:_online.._value", colNames,
	       "_AESConfig.tables.alertTable.columns.nameHeader:_online.._value", colTitles,
	       "_AESConfig.tables.alertTable.columns.widthScreen:_online.._value",dWith);
  }


	 for ( int i= dynlen(dWith);i>0;  i--)
	 {
	    if ( dWith[i] == 0)
	    {
	       dynRemove(colNames, i); 
	       dynRemove(colTitles, i); 
	    }
	 }

  // get old runmode 
  aes_getRunMode( propDp, oldRunMode );
  
  // runmode muss vor dem dialog ( der ggf properties setzt ) auf unlgeich running gesetzt werden damit hotlink in properties nicht automatisch ausgefuehrt wird
  dpSetCache( propDp + ".Settings.RunMode" + AES_ORIVAL, AES_RUNMODE_PROPEDIT );

//  ChildPanelOnModalReturn( panelName, tabTypeStr + " / " + screenTypeStr + " / " + configName,
  ChildPanelOnModalReturn( panelName, header,
    makeDynString(
      AESREGDOLLAR_CONFIGNAME + ":" + configName,  // we can ask the screenType from the runtimeDP
      AESREGDOLLAR_PROPDP     + ":" + propDp,
      AESREGDOLLAR_BALPROPDP  + ":" + balPropDp,
      AESREGDOLLAR_ALERTROW   + ":" + alertRow,
      AESREGDOLLAR_COLTITLES  + ":" + aec_ds2s( colTitles, AEC_SEP ),
      AESREGDOLLAR_COLNAMES   + ":" + aec_ds2s( colNames, AEC_SEP ),
      AESREGDOLLAR_CONFIGPANEL+ ":" + configPanel ),
      1, 1, df, ds );

  aes_debug(__FUNCTION__+"panelName="+panelName, d );
  aes_debug(__FUNCTION__+"tabTypeStr="+tabTypeStr, d );
  aes_debug(__FUNCTION__+"screenTypeStr="+screenTypeStr, d );
  aes_debug(__FUNCTION__+"configName="+configName, d );
  aes_debug(__FUNCTION__+"propDp="+propDp, d );
  aes_debug(__FUNCTION__+"balPropDp="+balPropDp, d );

  // in ds wird liste der aktuellen configs geliefert
  // df - erstes element enthaelt index der selektierten property

  newConfigList=ds;
  newSelPos=(dynlen(df)>0)?df[1]:0;//ansonsten kommt ein Laufzeitfehler --> index out of range
  retState=(dynlen(df)>1)?df[2]:0;

  // set runmode before properties

  dpSetCache( propDp + ".Settings.RunMode" + AES_ORIVAL, oldRunMode );

}


/**
  Main initialisation routine. 
  @param none
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/
void aes_initPanel()
{

  // consider aec settings

  // panel global variables
  topType=AESTYPE_ALERTS;
  botType=AESTYPE_EVENTS;

}


void aes_buildColumnStruct( int screenType )
{
  dyn_dyn_anytype gcv;

  int colIdx=1, maxColumn=0, objIdx=1;
  int offset=0;

  dyn_anytype daTmp, daSec;

  dyn_int    dSort;


  if( screenType == AESTYPE_EVENTS )
  {
    offset=EOFF;
  }  

  // determine max columns
  //daTmp=vst[ FIRST_COLUMN + offset ];
  aec_getObjectFromVST( FIRST_COLUMN+offset, daTmp );

  aes_debug( "daTmp=" + daTmp );

  daSec=daTmp[OIX_VALUE];
  maxColumn=dynlen( daSec );
  aes_debug( "maxCol="+maxColumn );


  // transform values
  for( colIdx=1; colIdx <= maxColumn; colIdx++ )
  {
    for( objIdx=FIRST_COLUMN; objIdx < LAST_COLUMN; objIdx++ )
    {
      anytype aVal, aValSave, aTemp;
     
      // accessing global aec object vst
      //dyn_anytype daObj=vst[objIdx];     - old vst pruefen ???
      dyn_anytype daObj;
      aec_getObjectFromVST( objIdx+offset, daObj );
      aTemp=daObj[ OIX_VALUE ];

      if( objIdx == SL_ARGUMENTS )
      {
        // in this special case, aVal is a dyn_(string) type
        aVal=aec_s2ds( aTemp[ colIdx ] );
      }
      else
      {
        aVal=aTemp[ colIdx ];
      }

      // saving explicit position information for sort
      if( objIdx == TE_POS )
      {
        dynAppend( dSort, aVal );
      }
      
      // colIdx(x) = Spaltenindex 1 - max 30
      // objIdx(y) = Zeilenindex ( e.g. TE_NAME, TE_WIDTH, SL_PARAMETERS...)
      gcv[colIdx][objIdx]=aVal;

    }
  }

  // sort columns and append data to global ddaRes object ( per screenType )
  aes_sortColumns( screenType, gcv, dSort );
}


int aes_getTableShape( int tabType, shape &tableShape )
{
  if( tabType == AESTAB_TOP )
  {
    tableShape=gs_tab_top;
  }
  else if( tabType == AESTAB_BOT )
  {
    tableShape=gs_tab_bot;
  }
  else
  {
    aes_debug( __FUNCTION__+"() / Unknown tabType="+tabType+" !" );
    return -1;
  }

  return 0;
}


void aes_getColumnObject( int screenType, dyn_dyn_anytype &dda )
{
  dyn_string dsCols;
  
  if( screenType == AESTYPE_ALERTS || screenType == AESTYPE_EVENTS )
  {
    dda=ddaRes[screenType];
    //Reihenfolge in der Sichtbarkeit bestimmt auch die Reihenfolge der Spalten im AS
    dyn_anytype daColumns = getDynAnytype(dda,TE_NAME);
    
    if(this.name == "table_top")
      dsCols = g_visibleColumnsTop;
    else if(this.name == "table_bot")
      dsCols = g_visibleColumnsBot;
    
    for(int i=1; i <= dynlen(dsCols); i++)
    {
      int iPos = dynContains(daColumns,dsCols[i]);
      if(iPos > 0)
      {
        dyn_anytype da = dda[iPos];
        dynRemove(daColumns,iPos);
        dynInsertAt(daColumns,dda[iPos][TE_NAME],i);
        dynRemove(dda,iPos);
        dynInsertAt(dda,da,i);
      }
    }
  }
  else
  {
    aes_debug("aes_getColumnObject() / Screentype="+screenType+" not found !" );
  }
}


void aes_appendColumnObject( int screenType, dyn_dyn_anytype &dda )
{
  if( screenType == AESTYPE_ALERTS || screenType == AESTYPE_EVENTS )
  {
    ddaRes[screenType]=dda;
  }
  else
  {
    aes_debug("aes_appendColumnObject() / Screentype="+screenType+" not found !" );
  }

  //aes_debug( __FUNCTION__+"() / ==========> ddaRes(" + screenType + ")=" + dynlen( ddaRes[screenType] ), 10 );

}


/**
  This function returns attributes ( dyn_string ) for a given "onClick" function name. 
  @param funcName Function name
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/
int aes_getAttributes4OnClickFunc( string funcName, dyn_string &attrib )
{
  const string al="_alert_hdl..";
  const string of="_offline..";
  dyn_string ds;

  // new - for dynamic handling
  funcName=aes_getPureFunctionName( funcName );


//  if ( funcName == AECSF_ACKNOWLEDGE )
  if ( funcName == AECSF_DOACKNOWLEDGE )
    attrib=makeDynString( al+"_ack_state", al+"_ackable", al+"_oldest_ack", al+"_ack_oblig" );
  
  else if ( funcName == AECSF_INSERTCOMMENT )
    attrib=makeDynString( al+"_comment" );

  else if ( funcName == AECSF_DISPLAYPANEL )
    attrib=makeDynString( al+"_panel" );

  else if ( funcName == AECSF_DISPLAYDETAIL )
  {
    //attrib=makeDynString( );
  }
  else if ( funcName == AECSF_USERDEFFUNC )
  {
    // exception - special treating / only at this onClick function we need the
    // defined VT_DPA attribute
  }
  else
  {
    aes_debug(__FUNCTION__+"() / Unknown funcname=" + funcName );
    return -1;
  }

  return 0;
}


string aes_getPureFunctionName( string funcName )
{
  dyn_string ds;
  string res;
  //int argCount;


  ds=strsplit( funcName, "(" );
  if( dynlen(ds) > 1 )
  {
    res=ds[1];
    //argCount=(int)ds[2];
  }
  else
  {
    res=funcName;
  }

  // remove blanks
  res=strrtrim( strltrim( res ) );

  return res;
}


/**
  This function returns attributes ( dyn_string ) for a given function name. 
  @param funcName Function name
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/
int aes_getAttributes4FuncName( string funcName, dyn_string &attrib, int screenType, int funcType=AEC_FT_ALL )
{
  funcName=aes_getPureFunctionName( funcName );

  // zur Zeit noch FT_ALL damit sicher gefunden wird
  //attrib=aec_getFuncArgs( funcName, screenType, AEC_FT_SPEC );
  attrib=aec_getFuncArgs( funcName, screenType, funcType, true, g_alertRow );

  return 0;
}


/**
  OLD - SEE getAttributes4FuncName This function will return the attribute index for a given function name. 
  @param funcName Function name
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/
int aec_getAttrIdx4FuncName( const string &funcName )
{

  if ( funcName == AECSF_DPGETACOUNT)
    return 2;
  /*
  if( funcName == AECSF_DPGETIDF)
    return 1;
  else if ( funcName == AECSF_DPGETTIME)
    return 2;
  */
  else if ( funcName == AECSF_DPGETACOUNT)
    return 2;
  else if ( funcName == AECSF_DPGETDESC)
    return 1;
  else if ( funcName == AECSF_DPGETCOMMENT)
    return 1;
  else if ( funcName == AECSF_DPGETALIAS)
    return 1;
  else
  {
    aes_debug("aec_getAttrIdx4FuncName() / Unknown funcname=" + funcName );
    return -1;
  }
}


/**
  This function will only append the aVal value if it's preceeded by an "_" ( attribute ). 
  @param uniqAttr Reference to the append dyn_string
  @param  aVal Value to add
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/
void aes_dynAppendUniqAttr( dyn_string &uniqAttr, anytype aVal )
{
  string work=aVal;

  // suppress all elements preceded by an "_"
  if( substr( work, 0, 1 ) == "_" )
  {
    dynAppend( uniqAttr, aVal );
  }
}


void aes_addMandatoryAttributes( const int screenType, const bool useFontProp, dyn_string &uniqAttr )
{
  // do not add attributes at events
  if( screenType != AESTYPE_EVENTS )
  {
    // treat fontstyle
    if( useFontProp )
    {
      if( dynContains( uniqAttr, AES_ATTR_FONTSTYLE ) <= 0 )
        dynAppend( uniqAttr, AES_ATTR_FONTSTYLE );
    }

    // append fore/back color attributes in any case
    if( dynContains( uniqAttr, AES_ATTR_FORECOLOR ) <= 0 )
      dynAppend( uniqAttr, AES_ATTR_FORECOLOR );

    if( dynContains( uniqAttr, AES_ATTR_BACKCOLOR ) <= 0 )
      dynAppend( uniqAttr, AES_ATTR_BACKCOLOR );
  }

}


void aes_addCBAttributes( const int screenType, dyn_string &uniqAttr )
{
  dyn_string save;
  int pos=0;

  save=uniqAttr;

  dynClear( uniqAttr );

  // if dpid or time already exists - delete them to put them on
  // first and second position ( callback specific )
  // we are searching only for one position, because we did the dynUnique command before
  pos=dynContains( save, _DPID_ );
  if( pos > 0 )
    dynRemove( save, pos );

  pos=dynContains( save, _TIME_ );
  if( pos > 0 )
    dynRemove( save, pos );

  if( screenType == AESTYPE_EVENTS )
  {
    uniqAttr[1]=_DPID_;
  }
  else
  {
    // insert dpid and time at first position
    uniqAttr[1]=_DPID_;
    uniqAttr[2]=_TIME_;
    
    dynAppend(uniqAttr, "_alert_hdl.._last");
  }

  dynAppend( uniqAttr, save );
}


void aes_enableProportion( bool flag )
{

  setMultiValue( "te_proportionTop", "enabled", flag,
                 "te_proportionBot", "enabled", flag,
                 "cab_proportion", "enabled", flag );

}


void aes_setTableEnableState( int tabType, bool state )
{
  if( tabType == AESTAB_TOP )
  {

    aes_setTopFullSize( g_top, g_bottom );
  
    // enable split button / activate register tab
    setMultiValue(
      "bt_topFull",  "visible", false,
      "bt_botFull",  "visible", false,
      "sl_gauge",    "visible", false,
      "bt_topSplit", "visible", true,
      AES_REGMAIN,   "namedActiveRegister", AES_TABNAME_TOP );
      
    reg_main.registerVisible(AESREGTAB_BOT)=false;

  }
  if( tabType == AESTAB_BOT )
  {
  }

}


void aes_setTableProperties()
{
  int colCount=dynlen( ddaRes );
  aes_debug("colCount="+colCount );

  // set general table settings
  /////////////////////////////
  aes_debug("backcol=" + aes_getStringValue( CB_BACKCOL ) );
  aes_debug("gridcol=" + aes_getStringValue( CB_GRIDCOL ) );
  aes_debug("hforecol=" + aes_getStringValue( CB_HFORECOL ) );
  aes_debug("hbackcol=" + aes_getStringValue( CB_HBACKCOL ) );
  aes_debug("dblclick=" + aes_getStringValue( CB_DBLCLICK ) );

  // traverse all columns
  ///////////////////////
  for( int n=1; n <= colCount; n++ )
  {
    // set column headername
    tab_top.columnHeader( n-1, ddaRes[n][LT_HEADERNAME] );
  }
}


bool aes_getBoolValue( int objIdx )
{
  dyn_anytype da=aes_getDAValue( objIdx );
  return da[OIX_VALUE];
}


int aes_getIntValue( int objIdx )
{
  dyn_anytype da=aes_getDAValue( objIdx );
  return da[OIX_VALUE];
}


float aes_getFloatValue( int objIdx )
{
  dyn_anytype da=aes_getDAValue( objIdx );
  return da[OIX_VALUE];
}


string aes_getStringValue( int objIdx )
{
  dyn_anytype da=aes_getDAValue( objIdx );
  return da[OIX_VALUE];
}


dyn_anytype aes_getDAValue( int objIdx )
{
  //dyn_anytype da=vst[objIdx];
  dyn_anytype da;
  aec_getObjectFromVST( objIdx, da );
  return da;
}


void aes_debug( const string message, int force=0 )
{
  if( AESDEBUG || ( force > AES_DEBUG_LEVEL ) )
  {
    DebugN( message );
  }
}


void aes_message( const int id, const anytype param, const int mode=1, const string funcName="unkown" )
{
  const int d=0;

  string msg=funcName + "(" + id + ") / ";
  string text;
  dyn_string msgTexts, msgKeys;
  int msgCount;

  aes_debug( __FUNCTION__+"() id=" + id + " mode=" + mode, d );

  // getting all defined message texts for specified id from catalogue
  msgCount=aes_getMessageTexts( id, msgTexts );

  switch( id )
  {
    /* template
    case :
      text=msgTexts[1] + param[1];
      break;
    */
    case AESMSG_GENERAL_ERROR:
      text=msgTexts[1];
      break;

    case AESMSG_DPDELETE_FAILED:
      text=msgTexts[1] + param[1];
      break;

    case AESMSG_DPCONNECT_FAILED:
      text=msgTexts[1] + param[1];
      break;

    case AESMSG_DPCREATE_FAILED:
      text=msgTexts[1] + (string)param[1];
      break;

    case AESMSG_UNKOWN_VT:
      text=msgTexts[1] + param[1] + msgTexts[2] + " !";
      break;

    default:
      ///////// throwError !!!!!!
      aes_debug( __FUNCTION__ + "() / Unknown message id=" + id + " !", d );
      return;
  }

  msg=msg+text;

  aes_debug( msg, true );
}


int aes_getMessageTexts( int id, dyn_string &dsText )
{
  dyn_string ds;

  int n, count=0;

  count=aec_getMessageKeys( id, ds );
  if( count > 0 )
  {
    for( n=1; n <= count; n++ )
    {
      dynAppend( dsText, aes_getCatStr( ds[n] ) );
    }
  }
  else
  {
    aes_debug( __FUNCTION__ + "() / No keys found for id=" + id + " !" );
    return -1;
  }

  return count;
}


string aes_getCatStr( const string msgKey )
{
  dyn_errClass err;

  
  string res;
  string catalogue=AES_CATALOGUE;
  int lang=getActiveLang();

  res=getCatStr( catalogue, msgKey, lang );
  err=getLastError();
  
  if( dynlen( err ) > 0 )
    res="???" + msgKey + "???";

  return res;
}


dyn_int aes_getAttrIndexList( string onClick, int valueType, string func, string attribute, dyn_string attributes, int screenType, dyn_string &workAttr, bool forQuery=false )
{
  int pos,l,n;
  dyn_int diRes;

  dyn_string uniqAttr;

  string searchAttr;
  string fu="empty";

  uniqAttr=g_attrList;

  // if a onClick function is defined, we dont care about the other attributes
  if( forQuery )
  {
    if( onClick != AECSF_NONE && 
        onClick != AECSF_USERDEFFUNC )  // exception - we need the defined attribute ( VT_DPA )
    {
      fu=onClick;
      aes_getAttributes4OnClickFunc( onClick, workAttr );
      aes_debug("  workAttr="+workAttr );
    }
  }
  

  if( valueType == VT_DPA )
  {
    if( attribute != "" )
      dynAppend(workAttr, attribute );
  }
  else if ( valueType == VT_FUNCTION )
  {
    // we get func attributes from attribut config / types must fit to configured function types
    fu=func;
    
    // old state
    //if( dynlen( attributes ) > 0 )
    //  dynAppend(workAttr, attributes );
    
    // attribute aus column config diag werden nicht mehr verwendet
    // => nur mehr aus func parametr. da in column config nur mehr function sel. werden k.
    aes_getAttributes4FuncName( func, workAttr, screenType, AEC_FT_EXT );

  }
  else if ( valueType == VT_SPECIAL )
  {
    fu=func;
    aes_getAttributes4FuncName( func, workAttr, screenType, AEC_FT_SPEC );
  }
  else if ( valueType == VT_SUBSTR )
  {
    // set function explicitly - exception/even for dynamic handling
    func=AECSF_DPSUBSTR;
    workAttr=makeDynString( _DPID_ );  // exception because function doesnt exists in config
    
    //aes_debug("  workAttr="+workAttr );
  }
  else
  {
    aes_debug( __FUNCTION__+"() / Unexpected valuetype="+valueType+" !" );
  }


  if( forQuery )
  {
    return diRes;    // only dummy in this mode ( forQuery ) - we need only the workAttr !
  }

  //////////////////////////////////////////
  //////////////////////////////////////////
  // find indexes
  l=dynlen(workAttr);

  if( l > 0 )
  {
    for( n=1; n <= l; n++ )
    {
      pos=0;
      searchAttr=workAttr[n];
      pos=dynContains(uniqAttr, searchAttr );
      if( pos <= 0 )
      {
        aes_debug(__FUNCTION__+"() / No index for attribute="+workAttr[n]+" found !" );
      }
      else
      {
        dynAppend( diRes, pos );
      }
    }
  }

  //aes_debug(__FUNCTION__+"() / Function="+fu+" attrIdx="+diRes );

  return diRes;
}


string aes_getAttributeString( const dyn_string &uniqAttr, int screenType, int valueType, int valTypeAlertSummary )
{
  int l, n;
  string res="";
  string komma="";
  string attr;
  string search, replace;

aes_debug(">>>>>>>>>>>>>>>>> uniqAttr="+uniqAttr);

  l=dynlen( uniqAttr );

  for( n=1; n <= l; n++ )
  {
    attr=uniqAttr[n];

    if( attr != "" && 
        attr != _DPID_ && 
        attr != _TIME_ )
    {  
      res=res + komma + "'" + attr + "'";
      komma=","; 
    }
  }
aes_debug(">>>>>>>>>>>>>>>>> res="+res, 1 );


  if( screenType == AESTYPE_EVENTS )
  {
    search="offline";
    if( valueType == AES_MODE_OPEN )
    {
      replace="online";
    }
    else
    {
      replace="offline";
    }
  }
  else
  {
    search="original";
    // ALERTS
    if( valueType == AES_MODE_CURRENT || valueType == AES_MODE_OPEN )
    {
      replace="online";
    }
    else
    {
      replace="offline";
    }
 
    if( valTypeAlertSummary == AES_SUMALERTS_FILTERED )
    {
       res = res + ",'_alert_hdl.._filtered','_alert_hdl.._force_filtered'"; 
    }
  }


  strreplace( res, search, replace );

  
  return res;
}


/**
  This function sorts the configuration matrix by the column position.
  The column values will be added to global configuration object ddaRes. 
  @param ddaIn Unsorted input configuration object. 
  @param diPos Temporary help object for the sorting operation. 
  @return nothing
  @author Martin Pallesch
  @version 1.0
*/
void aes_sortColumns( int screenType, const dyn_dyn_anytype &ddaIn, const dyn_int &diPos )
{
  dyn_dyn_anytype dda;
  dyn_int diSort;
  int i, n, l;
  dyn_anytype daColumn;

  // make a copy
  diSort=diPos;
  // sort with table position
  dynSortAsc( diSort );

  l=dynlen( diSort );
 
  // traverse columns
  for( i=1; i <= l; i++ )
  {
    for( n=1; n <= l; n++ )
    {
      daColumn=ddaIn[n];
      if( daColumn[ TE_POS ] == diSort[ i ] )
      {
        dynAppend( dda[i], daColumn );
        break;
      }
    }
  }

  aes_appendColumnObject( screenType, dda );
}


int aes_getLastError( dyn_errClass err )
{
  int code;
  if( dynlen( err ) )
  {
    code=getErrorCode( err[1] );


    // exception for dist system not connectable at start time !!!
    if( code == AES_ERR_MSGNOTSEND )
    {
      return 0;
    }
    
    errorDialog(err);
    return code;
  }
  else
  {
    return 0;
  }
}


int aes_getInfoFromIdentifier( string identifier, int &tabType, int &mode, int &systemId, bool &fromProp )
{
  dyn_string ds;
  const string sep="_";
  string moduleName="";
  int l,n;
  string tsep;
  int c=1, alertRow;
  
  ds=strsplit( identifier, sep );

  tabType=ds[c++];
  mode=ds[c++];
  systemId=ds[c++];
  alertRow=ds[c++];
  fromProp=ds[c++];

  //if a possible seperator character exists in the module name
  l=dynlen(ds);
  tsep=sep;

  for( n=c; n <= l; n++ )
  {
    if( n == l )
      tsep="";

    moduleName=moduleName + ds[n] + tsep;
  }

  return 0;
}


string aes_createIdentifier( const int tabType, const int mode, int sysId=0, bool fromProp=false )
{
  const string U="_";
  string id;
  string timeStr;
  string moduleName;
  int alertRow;

  if( g_alertRow )
    alertRow=1;
  else
    alertRow=0;

  moduleName=myModuleName();

  id=tabType + U + mode + U + sysId + U +  alertRow + U + fromProp + U + moduleName;  // faster than sprintf(setLocale!!!)

  return id;
}


void aes_debugConfigMatrix( dyn_dyn_anytype &configMatrix )
{
  const int d=4;

  string output;
  string attr;
  string colName, column;
  dyn_int attrIdx;

  string uniqAttr;
  //int screenType;

  int n,l;
  string queryAttr;
  dyn_string dsAttr;


  aes_debug("", d);
  //aes_debug("Config Matrix : "+aes_getTBStr(tabType)+"/"+aes_getAEStr(screenType), 1);
  aes_debug("Config Matrix : ", d);
  aes_debug("===============", d);
  aes_debug("", d);

  dsAttr=g_attrList;

  l=dynlen(dsAttr);
  for(n=1;n<=l;n++)
  {
    if( n == l )
    {
      queryAttr=queryAttr + dsAttr[n]+"("+n+")";
    }
    else
    {
      queryAttr=queryAttr + dsAttr[n]+"("+n+") | ";
    }
  }

  aes_debug( "Query attributes="+queryAttr, d );
  aes_debug("", d);

  l=dynlen(configMatrix);

  if( l <= 0 )
  {
    aes_debug(__FUNCTION__+"() / Empty config matrix !", 1 );
    return;
  }

  // traverse config matrix per column
  for( n=1; n<=l; n++ )
  {
    output="";
    attr="";
    attrIdx=configMatrix[n][CFG_ATTRINDEX];

    attr=aes_debugAttributes( attrIdx );
    aes_getTableColumnName( n, colName );

    column=colName+"("+n+")";

    sprintf( output,"Column=%18s | attributes=%60s | valuetype=%1d | formatstr=%8s | milli=%1d | func=%20s | usefc=%1d | usebc=%1d | substr=%3d",
    column,
    attr,
    configMatrix[n][CFG_VALTYPE],
    configMatrix[n][CFG_FORMATSTR],
    configMatrix[n][CFG_MILLISEC],
    configMatrix[n][CFG_FUNCTION],
    configMatrix[n][CFG_USEFORECOLOR],
    configMatrix[n][CFG_USEBACKCOLOR],
    configMatrix[n][CFG_SUBSTRPTR]
    );

    aes_debug( output, d );
  }
    
  aes_debug("", d);
}


string aes_debugAttributes( const dyn_int &attr )
{
  const string ddot="..";
  
  int n, l, idx;
  string ret="", res="";
  dyn_string uniqAttr;
  string attrStr;
  dyn_string pureAttrs;


  uniqAttr=g_attrList;

  l=dynlen(attr);
  if( l <= 0 )
    return "";

  for(n=1; n <= l; n++ )
  {
    res="";
    idx=attr[n];
    attrStr=uniqAttr[idx];

    if( strpos( attrStr, ddot ) > 0 )
    {
      pureAttrs=strsplit( attrStr, ddot ); 
      attrStr=pureAttrs[3];      // e.g. _value
    }

    res=attrStr+"("+idx+")";
    if( n == l )
    {
      ret=ret + res; 
    }
    else
    {
      ret=ret + res +","; 
    }
  }
  return ret;
}


void aes_debugSettings( dyn_anytype &settings )
{
  const int d=10;
  int screenType;
  int c=1;

  aes_debug("Settings :",d);
  aes_debug("==========",d);
  aes_debug("",d);

  aes_debug("("+c+") ScreenType     ="+settings[AESET_SCREENTYPE],d);c++;
  aes_debug("("+c+") Comment filter ="+settings[AESET_COMMENTFILTER],d);c++;
  aes_debug("("+c+") Current mode   ="+settings[AESET_CURRENT_MODE],d);c++;
  aes_debug("("+c+") Use font prop. ="+settings[AESET_USEFONTPROP],d);c++;
  aes_debug("("+c+") Alert state    ="+settings[AESET_ALERTSTATE],d);c++;
  aes_debug("("+c+") Multilinesupp. ="+settings[AESET_MULTILSUPPRES],d);c++;
  aes_debug("("+c+") Screenfont     ="+settings[AESET_SCREENFONT],d);c++;
  aes_debug("("+c+") Printoutfont   ="+settings[AESET_PRINTOUTFONT],d);c++;
  aes_debug("("+c+") Show internals ="+settings[AESET_SHOWINTERNALS],d);c++;
  aes_debug("("+c+") BackCol        ="+settings[AESET_BACKCOL],d);c++;

}


dyn_string aes_correctTimeSort( dyn_string dsSort )
{
  // special treating for timestr column - we replace it with the time column for proper time sort
  dyn_string dsResult;
  int pos=dynContains( dsSort, _TIME_STR_ );

  //DebugN(__FUNCTION__+"() / before sortList="+dsSort );

  if( pos > 0 )
  {
    //DebugN(" changing...." );
    dsSort[pos]=_TIME_;
    dsResult=dsSort;
  }
  else
  {
    dsResult=dsSort;
  }

  //DebugN(__FUNCTION__+"() / after sortList=" + dsResult );

  return dsResult;
}


int aes_getRealIdent( dyn_errClass &err, dyn_dyn_anytype &tab, string &ident )
{
  int sysId;
  string sAnswerSystem="";

/*
DebugN(__FUNCTION__+" tab=" + dynlen(tab) );
DebugN(__FUNCTION__+" tab=" + tab );
DebugN(__FUNCTION__+" err=" + dynlen(err) );
DebugN(__FUNCTION__+" err=" + err);
*/

  if( g_checkAll )
  {
    if ( dynlen( tab )  == 1 && dynlen(tab[1])>=1 )
    {
      string  sTmpHlp = (string)tab[1][1]; 
      sAnswerSystem = substr(sTmpHlp, 0, strpos(sTmpHlp, ":"));
      sysId = getSystemId(sAnswerSystem);
    }        
    if (dynlen( tab ) < 1 || (dynlen(tab)==1 && sAnswerSystem==""))
    {
      // get sysid from errClass
      if( dynlen( err ) <= 0 )
      {
        // ok - no hl data, no sys info
        return AES_IDENT_OK_NOTAVL;
      }
      else
      {
        string errName=getErrorDpName( err[1] );
        sysId=getSystemId( errName );

        if( sysId == -1 )
          return AES_IDENT_ERROR;
      }
    }
    else if (sAnswerSystem=="")
    {
      // get sysid from HL data
      sysId=aes_getSysIdFromHL( tab[2][1] );
    }

    ident=aes_createIdentifier( g_tabType, g_valType, sysId );
  }

  return AES_IDENT_OK;
}


bool aes_discardingTreating( dyn_errClass err, string ident, bool fromDpQuery=false )
{
  time tCurr;
  string pre, app;
  bool vis;

  aes_getPreApp4TabType( g_tabType, pre, app );

  if ( g_discarded )
  {
    if ( ( (tCurr = getCurrentTime()) - g_discardStart) > MINCB_TIME )
    {
      string screenType, dpProp;
      dyn_string state;

      g_discarded = false;
      if ( g_discardThread >= 0 )
      {
        stopThread(g_discardThread);

        // set default back color // and text ?
        setValue( pre + "te_system", "backCol", "" );

        aes_doRestart( g_propDp, true );
      }
    }
    else
    {
      g_discardStart = tCurr;
    }

    return false;
  }

  if( dynlen( err ) > 0 )
  {
    if ( getErrorCode(err[1]) == AES_ERR_DISCARDING )  // values discarded
    {
      if ( ! g_discarded )
      {
      
        getValue( pre + "te_system", "visible", vis );

        if( !vis )
          setValue( pre + "te_system", "visible", true );

        /// + text avalanche
        setValue( pre + "te_system", "backCol", "vorwKamGingUnq",
                                     "text", aes_getCatStr( "mid_avalanche" ) );
        g_discarded = true;
        g_discardStart = getCurrentTime();
        g_discardThread = startThread("aes_discardTimeOut", vis );

        // $$$ eigentlich nur Daten des betroffenen Systems loeschen !!!!- pruefen 
        this.deleteAllLines();
      }

      return false;
    }
    else
    {
      int tabType, mode, connectId, fromProp;
      aes_getInfoFromIdentifier( ident, tabType, mode, connectId, fromProp );
      aes_checkQueryError( err, connectId, 1, fromDpQuery );
      return false;
    }
  }

  return true;
}


int aes_countConnectedSystems( dyn_string conn, dyn_string closedConn )
{
  dyn_int systems; 
  int tabType, mode, systemId, mySystemId, i, l;
  bool fromProp;
  
  dynAppend( conn, closedConn );

  l=dynlen( conn );

  for( i=1; i <= l; i++ )
  {
    aes_getInfoFromIdentifier( conn[i], tabType, mode, systemId, fromProp );
    if( systemId != AES_DUMMYSYSID )
      dynAppend( systems, systemId );
  }

  dynUnique( systems );

  return dynlen( systems );
}


void aes_appendIdentifier( string idf )
{
  DebugFTN("aesDist",__LINE__,__FUNCTION__,idf);
  dynUnique(g_counterConnectId);
  if( dynContains( g_counterConnectId, idf ) <= 0 )
  {
    dynAppend( g_counterConnectId, idf );
  }
  DebugFTN("aesDist",__LINE__,__FUNCTION__,g_counterConnectId);
}


void aes_createDistInfo()
{
  int sysToConnect, connectedSys;
  dyn_string systems, params, ds, ds1;
  dyn_string ds_systemsDistConn, ds_systemsAESConn;
  string s_ownSystem;
  dyn_uint du;
  string pre, app, backCol;
  string checkAll, val;
  int i, tabType, mode, sysId;
  int ic=1, closedSys;
  bool fromProp;
  
  closedSys=dynlen( g_closedIdf );

  // get the list of connected dist systems
  // the own system name needs to be added
  getSystemNamesConnected(ds_systemsDistConn, du);
  s_ownSystem = getSystemName();
  dynAppend(ds_systemsDistConn,s_ownSystem);

  DebugFTN("aesDist",__LINE__,__FUNCTION__,g_checkAll,g_systemSelections,gds_queryConnectedSystems,ds_systemsDistConn);

  if( g_checkAll )
  {
    systems = gds_queryConnectedSystems;
    sysToConnect=dynlen(systems);
  }
  else
  {
    systems=g_systemSelections;
    sysToConnect=dynlen( systems );
  }

  // check if all systems listed in gds_queryConnectedSystems are connected
  for(i=1;i<=dynlen(gds_queryConnectedSystems);i++)
  {
    // the systems list ds_systemsDistConn contains a ":" at the end, therefore it has to added to the system name in gds_queryConnectedSystems
    if(dynContains(ds_systemsDistConn,gds_queryConnectedSystems[i]+":"))
    {
      dynAppend(ds_systemsAESConn,gds_queryConnectedSystems[i]);
      connectedSys++;
    }
  }
  
  DebugFTN("aesDist",__LINE__,__FUNCTION__,systems,ds_systemsAESConn);

  aes_getPreApp4TabType( g_tabType, pre, app );

  val=connectedSys + " ( " + ( (g_checkAll)?"*":"" ) + sysToConnect + " )";

  if ( connectedSys == sysToConnect)  // IM 63154
    lastSystem = TRUE;

  params[ic++]=(string)g_tabType;
  params[ic++]=(string)g_screenType;
  params[ic++]=(string)g_checkAll;
  params[ic++]=(string)dynlen(systems);
  dynAppend( params, systems );

  for(i=1;i<=dynlen(ds_systemsAESConn);i++)
  {
    sysId = getSystemId(ds_systemsAESConn[i] + ":");

    if( sysId != AES_DUMMYSYSID )
    {
      dynAppend( params, (string)sysId );
    }
  }

  ds[1]=aec_ds2s( params, AEC_SEP );


  dynClear( params );

  for(i=1;i<=dynlen(g_closedIdf);i++)
  {
    aes_getInfoFromIdentifier( g_closedIdf[i], tabType, mode, sysId, fromProp ); 
    if( sysId != AES_DUMMYSYSID )
    {
      dynAppend( params, (string)sysId );
    }
  }

  // systems from closed mode ! ( dpQuery ok )

  ds1=aec_ds2s( params, AEC_SEP );


  if( connectedSys != sysToConnect )
  {
    backCol="STD_value_not_ok";
  }
  else
  {
    backCol="_3DFace";
  }

  setMultiValue( pre + "te_system", "text", val,
                 pre + "te_system", "backCol", backCol );

  //               pre + "te_hidden", "text", aec_ds2s( params, AEC_SEP ) );

  aes_dpSetDistInfo( g_propDp, makeDynString(ds, ds1 ) );
}


void aes_initBusy()
{
  const int d=5;

  string dpPath=g_propDpName + ".Settings.BusyTrigger" + AES_ORIVAL;

   while (!dpExists(g_propDpName))
   {
      delay(0,100);
   }

  dpSetCache( g_propDpName + ".Settings.RunMode" + AES_ORIVAL, AES_RUNMODE_STOPPED); // clear cached value IM 107044 

  if( dpConnect( "aes_busyWork", true, dpPath ) != 0 )
  {
    // dialog
    aes_debug( __FUNCTION__+"() / dpConnect failed !", d );
  }
}


void aes_busyWork( string dummy, int val )
{

///////////// siehe te_busy 
  string pre,app;


  if( val != g_oldVal )
  {
    aes_getPreApp4TabType( g_tabType, pre, app );
    if( val == AES_BUSY_START )
    {
      std_startBusy();
      setValue( pre + "te_rows", "visible", false );
    }
    else
    {
      std_stopBusy();    
      setValue( pre + "te_rows", "visible", true );
    }
    g_oldVal=val;
  }
}


void aes_initDistInfo()
{
  const int d=5;

  string dpPath, dpName=$2;

  dpPath=dpName + ".Settings.DistInfo" + AES_ORIVAL;

//*
  if( dpConnect( "aes_distWork", true, dpPath ) != 0 )
  {
    // dialog
    aes_debug( __FUNCTION__+"() / dpConnect failed !", d );
  }
//*/

  // dummycall
  //aes_distWork( "dummy", makeDynString( $1 ) );

}


void aes_distWork( string dp, dyn_string dsVal )
{

  string tb="tb_distInfo";
  int l, i, n;

  dyn_string systems, states;
  dyn_int ids, conIds;

  dyn_dyn_string ddsSys, ddsId;

  bool checkAll;
  string sys, state, tt, dpPath;
  int id, tabType, screenType;
  dyn_int diFont;
  string backCol;
  
  dyn_string params, closedParams;
  string dpName=$2;
  int ic=1;
  dyn_int diWidth;
  string object="tb_distInfo";

//DebugN("params=" + params );
  tabType=$3;

  if( dsVal[1] == "" )
  {
    checkAll=false;
  }

  if( checkAll )
  {
    tt=aes_getCatStr( "mid_checkAllOn" );
  }
  else
  {
    tt=aes_getCatStr( "mid_checkAllOff" );
  }
    
  setValue( "fr_checkAll", "text", aes_getTBStrLang( tabType ) + " / " + tt );

  setValue( object,
            "deleteAllLines",
            "tableMode", TABLE_SELECT_BROWSE,
            "selectByClick", TABLE_SELECT_LINE );

  diWidth=makeDynInt( 40, 165, 0 );

  // set column values
  for( i=0; i <= 2; i++ )
  {
    //setValue( object, "columnToName", i, oldCol ); 
    //setValue( object, "exchangeColumnName", oldCol, "#"+i ); 

    setValue( object, "columnHeader", i, aes_getCatStr( "mid_distHeader" + i ),
                      "columnWidth", i, diWidth[i+1],
                      "columnVisibility", i, true,
                      "columnEditable", i, false ); 
  }

  if( dsVal[1] == "" )
    return;

  params=aec_s2ds( dsVal[1], AEC_SEP );


  // try to find closed sys
  if( dsVal[2] != "" )
    closedParams=aec_s2ds( dsVal[2], AEC_SEP );

  tabType=(int)params[ic++];
  screenType=(int)params[ic++];
  checkAll=(bool)params[ic++];
  l=(int)params[ic] + ic;

  if( checkAll )
  {
    tt=aes_getCatStr( "mid_checkAllOn" );
  }
  else
  {
    tt=aes_getCatStr( "mid_checkAllOff" );
  }
    
  setValue( "fr_checkAll", "text", aes_getTBStrLang( tabType ) + " / " + tt );

  ic++;
  for( i=ic; i <= l; i++ )
  {
    dynAppend( systems, params[i] );
  }

  n=i;
  l=dynlen( params );
  for( i=n; i <= l; i++ )
  {
    dynAppend( conIds, (int)params[i] );
  }

  // create table row info
  l=dynlen( systems );
  for( n=1; n <= l; n++ )
  {
    sys=systems[n];
    
    if (strpos(sys, ":")<1)
      sys+=":";

    id=getSystemId( sys );
    dynAppend( ids, id );

    if( ( dynContains( conIds, id ) > 0 ) ||
        ( dynContains( closedParams, id ) > 0 ) )  // check whether sysid is within closed id's
    {
      backCol="STD_device_on";    // green
      state=" XXX ";
      dynAppend( diFont, 1 );
    }
    else
    {
      backCol="STD_value_not_ok"; // red
      state=" --- ";
      dynAppend( diFont, 0 );
    }
    
    // new
    ddsSys[n]=makeDynString( sys, "", "" );
    ddsId[n]=makeDynString( id, backCol, "" );

    dynAppend( states, state );

  }


  setValue( object, "appendLines", dynlen(systems),
            "#1", ddsId,
            "#2", ddsSys,
            "#3", states,
            0, diFont );


}


void aes_startBusy( int tabType )
{
  aes_busy( tabType, AES_BUSY_START );
  lastSystem = FALSE;
}


void aes_stopBusy( int tabType )
{
  aes_busy( tabType, AES_BUSY_STOP );
}


void aes_busy( int tabType, int mode )
{
  
  string pre, app;
  aes_getPreApp4TabType( tabType, pre, app );

  aes_dpSetBusy( g_propDp, mode );

}


int aes_getSysIdFromHL( string fullDpe )
{
  return getSystemId( dpSubStr( fullDpe, DPSUB_SYS ) );
}


string aes_extractTableCommand( string command )
{
  dyn_string ds,ds2;
  string res;
  const string _SK="\"";

  ds=strsplit( command, "{" );
  res=ds[2];
  
  strreplace( res, '"', "'" );
   
  ds2=strsplit( res, "}" );

DebugN("command=" + command );
DebugN("ds=" + ds );
DebugN("res=" + res );
DebugN(" ds2="+ds2 );

  return ds2[1];
}


/**
  Main properties callback function. 
  @param tab Table with callback attribute/row matrix
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/
aes_workCB(string ident, dyn_dyn_anytype tab, bool fromDpQuery=false )
{
  dyn_errClass err = getLastError();
  string sAnswerSystem="";
      
  if (dynlen(tab) == 1) //no data
  {  // get system from header
    string  sTmpHlp = (string)tab[1][1]; 
    sAnswerSystem = substr(sTmpHlp, 0, strpos(sTmpHlp, ":")+1);
  }
  const int d=5;

  int             i, dummy, count, oldcount, pos, iPos, connectId;
  bool            stopped;
  string          dpProp, sortString;
  dyn_string      sortList;
  dyn_bool        sortAsc; //true...up, false...down
  dyn_dyn_anytype xtab, xtab2;
  dyn_int         diFontAttr;

  int ret, res, firstRow, lastRow;
  int tabType, mode, screenType, systemId;

  double ts, te, td;
  int tc=0;
  bool retVal=true;
  bool fromProp=false;
  bool bLinesDeleted = FALSE;
  
  int nCount;

  int iLineCount, iNewLineCount;
  
  int i_currentLineCount,i_currentFirstRow,i_currentLastRow;
  int i_lineToShow;
  
  getValue("", "lineCount", iLineCount); 
  if ( isDbgFlag("NFR_UDA") && isFunctionDefined("nfrUda_aesCbStart") )
    nfrUda_aesCbStart(ident, iLineCount);
  
  // find out the real ident
  //////////////////////////
  ret=aes_getRealIdent( err, tab, ident );

  if( ret == AES_IDENT_ERROR )
  {
    aes_throwError( AES_TE_CREATEIDFFAILED );
    return;
  }
  else if ( ret == AES_IDENT_OK_NOTAVL )
  {
    // leave with no error - sysinfo not available in empty hl table
    return;
  }

  aes_getInfoFromIdentifier( ident, tabType, mode, systemId, fromProp );

  if (sAnswerSystem!="")  
  {
    systemId = getSystemId(sAnswerSystem);

  }

  // we didn't accept any errors in closed mode ( will possible exec. a queryconnect )
  if( mode == AES_MODE_CLOSED && dynlen( err ) > 0 )
  {
    aes_removeFromSystemsList(getSystemName(systemId));
    return;
  }




  // discarding treating
  //////////////////////
  if( ! aes_discardingTreating( err, ident, fromDpQuery ) )
  {
    aes_removeFromSystemsList(getSystemName(systemId));
    return;
  }

  doTimeStamp("RECEIVING DATA" );

  screenType=g_screenType;
  
  string sRdbComprLevel;
  if(screenType == AESTYPE_EVENTS && useRDBArchive())
  {  //get compression level
    if (dynlen(tab)>0 && dynlen(tab[1])>1)
    {
      dyn_string dsTmp = strsplit((string)tab[1][2], '.');
      if (dynlen(dsTmp)>1)
        sRdbComprLevel = dsTmp[2];
    }
  }

  
  // starting thread aes_appendIdent4SysId was removed, calling the function is not necessary anymore
    
  if( dynlen(tab) <= 1 )
  {
    if( g_firstHL && lastSystem) // IM 63154
    {
      g_firstHL=false;
      aes_stopBusy( g_tabType );
    }
    aes_removeFromSystemsList(getSystemName(systemId));
    return;
  }

  //aes_debugData( tab );

  // check max table lines

  //IM 111393 Remove internal alerts////////////////
  if ( !g_showInternalsA && !g_alertRow )
  {
    for ( int i = dynlen(tab); i > 2; i-- )
    {
      if ( dpTypeName(tab[i][1])[0] == "_" )
        dynRemove(tab, i);
    }
  }
  else if ( !g_showInternalsAR && g_alertRow )
  {
    for ( int i = dynlen(tab); i > 2; i-- )
    {
      if ( dpTypeName(tab[i][1])[0] == "_" )
        dynRemove(tab, i);
    }
  }
  //////////////////////////////////////////////////

  if( ! aes_checkMaxLinesToDisplay( (dynlen(tab)-1), screenType, ident ) )
  {
    aes_removeFromSystemsList(getSystemName(systemId));
    return;
  }

  if ( mode == AES_MODE_CURRENT )
  {
    oldcount = -1;
  }

  ts=getCurrentTime();

  doTimeStamp("BEFORE CONVERTALERTTAB" );
 
  //DebugTN(__FUNCTION__,__LINE__,"call convertAlertTabEx2",dynlen(tab)); 

  res=convertAlertTabEx2( tab, g_configSettings, g_configMatrix, xtab, xtab2, diFontAttr );

  //DebugTN(__FUNCTION__,__LINE__,"result of convertAlertTabEx2",dynlen(xtab[1]),dynlen(xtab[2])); 

  //new feature 'userdepending alarm display' IM #117931
  if(isFunctionDefined("aes_editAlertsBeforeDisplay") &&(screenType != AESTYPE_EVENTS))
    aes_editAlertsBeforeDisplay(g_configMatrix, xtab);
  
  if( res == AES_CATE_PARAMERR )
  {
    aec_warningDialog( AEC_WARNINGID_CONVATABPARAM );
    aes_stopBusy( g_tabType );
    aes_displayStatus();
    aes_removeFromSystemsList(getSystemName(systemId));
    return;
  }
  else if( res == AES_CATE_CFGMATRIXERR )
  {
    aec_warningDialog( AEC_WARNINGID_CONVATABMATRIX );
    aes_stopBusy( g_tabType );
    aes_displayStatus();
    aes_removeFromSystemsList(getSystemName(systemId));
    return;
  }

   // set the variable to detect if a scrolling the table is made because of an automatic refresh
  if(tabType == AESTAB_TOP)
  {
    gb_automaticScrollTop = 1; 
  }
  else if (tabType == AESTAB_BOT)
  {
    gb_automaticScrollBot = 1; 
  }

  synchronized(g_bTableLineSynchronisation)
  {
    this.updatesEnabled = false;
    getValue("", "lineRangeVisible", firstRow, lastRow);    
    
    if (isRefresh()  && screenType != AESTYPE_EVENTS  && !stopped)          // only AES & Alertrow  IM 67933 
    {
      aes_deleteSystemTableRows  (getSystemName(systemId)); 
    }
    doTimeStamp("AFTER CONVERTALERTTAB" );

    // check if a jumping timeout is defined
    if(g_uJumpingTimeout != 0)
    {
      int i_sort;
      bool b_sort;

      if (dynlen(sortList)==0) //e.g. on delete
      {
        aes_getSortList( g_propDp, sortList, sortAsc );
      }

      i_sort = dynContains(sortList, "__V_time");
      if (i_sort<1)
        i_sort = dynContains(sortList, "timeStr");

      if(i_sort<1)
        b_sort=true;
      else
        b_sort = sortAsc[i_sort];

      // read the currently visible line range and the number of lines
      getMultiValue("", "lineRangeVisible",i_currentFirstRow,i_currentLastRow,
                    "", "lineCount",i_currentLineCount);
      
      // check if the newest line is visible
      if((i_currentLineCount-1) == i_currentLastRow && b_sort == 1)
      {
        i_lineToShow = -1;
      }
      else if(i_currentFirstRow == 0 && b_sort == 0)
      {
        i_lineToShow = 0;
      }
      else
      {
        i_lineToShow = i_currentFirstRow;
      }
    }

    aes_debug( __FUNCTION__+"() - after convertAlertTab xtablen=" + dynlen(xtab) + " xtab2len=" + dynlen(xtab2), d );
    if ( (dynlen(xtab2) != 0) && (dynlen(xtab2[1]) != 0) )
    {
      bLinesDeleted = TRUE;
      if ( mode == AES_MODE_CURRENT )
      {
        aes_debug( __FUNCTION__+"() - DELETE cmd=" + g_tableCmdDelete );

        if( screenType == AESTYPE_EVENTS )
        {
          this.deleteLines( 2, _DPID_, xtab2[g_dpidIdx],
                               _TIME_, xtab2[g_timeIdx] );
        }
        else
        {
          this.deleteLines( 3, _DPID_, xtab2[g_dpidIdx],
                               _TIME_, xtab2[g_timeIdx],
                               _COUNT_, xtab2[g_countIdx] );
        }
      }
    }

    nCount = 0;
    if (dynlen(xtab) != 0)
    {
      nCount=dynlen( xtab[1] );
    }


    if ( nCount != 0 )
    {
      if (mode == AES_MODE_CLOSEDAPP || (mode == AES_MODE_CLOSED && screenType == AESTYPE_EVENTS ))
      {
        int tempnCount = nCount; 
        dyn_string tempg_colNames=g_colNames; 

        // show RDB Compression Level at DPE Name / Description if there is one
        if(sRdbComprLevel!="")
        {
          int iColOfElement = dynContains(g_colNames,"elementName");
          if (iColOfElement>0)
          {
            for (int rowIndex = dynlen(xtab[iColOfElement]); rowIndex>0; rowIndex--)
            {
              xtab[iColOfElement][rowIndex]=xtab[iColOfElement][rowIndex]+" ("+sRdbComprLevel+")";
            }
          }
        }

        aes_debug( __FUNCTION__+"() - APPEND cmd=" + g_tableCmdAppend, d );

        if( g_useFontProp )
        {
          this.appendLines( nCount, g_colNames, xtab, 0, diFontAttr );
        }
        else
        {
          this.appendLines( nCount, g_colNames, xtab );
        }
      }
      else
      {
        // treating for current and open mode
        aes_debug( __FUNCTION__+"() - UPDATE cmd=" + g_tableCmdUpdate, d );
      
        if( screenType == AESTYPE_EVENTS )
        {
          // new IM ***** => no update at events nevessary / better performance with append
          // disadvantage / no sort possible
          if( g_useFontProp )
          {
            this.appendLines( nCount, g_colNames, xtab, 0, diFontAttr );
          }
          else
          {
            this.appendLines( nCount, g_colNames, xtab );
          }
        }
        else
        {
          if( g_useFontProp )
          {
            this.updateLines( 3, _DPID_, xtab[g_dpidIdx],
                                 _TIME_, xtab[g_timeIdx],
                                 _COUNT_, xtab[g_countIdx],
                                 g_colNames, xtab, 0, diFontAttr );
          }
          else
          {
            this.updateLines( 3, _DPID_, xtab[g_dpidIdx],
                                 _TIME_, xtab[g_timeIdx],
                                 _COUNT_, xtab[g_countIdx],
                                 g_colNames, xtab );
          }
          aes_getSortList( g_propDp, sortList, sortAsc );
          sortList=aes_correctTimeSort( sortList );       
          if( dynlen(sortList) == 0 )
          {
            if( screenType == AESTYPE_EVENTS )
            {
              setValue("", "sortDyn", sortAsc, makeDynString( _TIME_ ) );
            }
            else
            {
              setValue("", "sortDyn", sortAsc, makeDynString( _TIME_, _COUNT_ ) );
            }
          }
          else
          {
            setValue("", "sortDyn", sortAsc, sortList );
          }
        }
      }
    }

    doTimeStamp("AFTER DISPLAY DATA" );

    if ( (( mode == AES_MODE_OPEN ) && (! stopped)) || ((g_maxLines != 1 ) && ident == aes_createIdentifier( g_tabType, AES_MODE_CLOSEDAPP, systemId, true ))   )
    {
      getValue( "", "lineCount", count );

      if ( count > g_maxLines )
      {
        // pruefe  - da count bei events eigentlich nicht existiert
        if( screenType == AESTYPE_EVENTS )
        {
          setValue("", "sortDyn", makeDynString( _TIME_ ) );
        }
        else
        {
          setValue("", "sortDyn", makeDynString( _TIME_, _COUNT_ ) );
        }

        setValue("", "deleteLinesN", 0, count - g_maxLines,
                     "sortUndo", 0);
      }
    }

  
    if( mode == AES_MODE_CLOSEDAPP || screenType == AESTYPE_EVENTS)   // nur bei alerts/closed - if fuer events nicht notwendig
    {
      aes_getSortList( g_propDp, sortList, sortAsc );
    
      if( dynlen(sortList) == 0 )
      {
        if( screenType == AESTYPE_EVENTS )
        {
          setValue("", "sortDyn", sortAsc, makeDynString( _TIME_ ) );
        }
        else
        {
          setValue("", "sortDyn", sortAsc, makeDynString( _TIME_, _COUNT_ ) );
        }
      }
      else
      {
        sortList=aes_correctTimeSort( sortList );
        setValue( "", "sortDyn", sortAsc, sortList );  
      }
    }
  

    if( g_firstHL && lastSystem) // IM 63154
    {
      g_firstHL=false;
      aes_stopBusy( g_tabType );
    }

    getValue("", "lineCount", iNewLineCount); 

    this.updatesEnabled = true;

    if ( iNewLineCount != iLineCount || bLinesDeleted )                       // new information !!
    {
      int i_sort;
      bool b_sort;

      if (dynlen(sortList)==0) //e.g. on delete
      {
        aes_getSortList( g_propDp, sortList, sortAsc );
      }

      i_sort = dynContains(sortList, "__V_time");
      if (i_sort<1)
        i_sort = dynContains(sortList, "timeStr");

      if(i_sort<1)
        b_sort=true;
      else
        b_sort = sortAsc[i_sort];

      if(g_uJumpingTimeout != 0)
      {
        getValue("", "lineCount",i_currentLineCount);    

        // check if the current line count is smaller than the line which shall be shown
        if(i_currentLineCount < i_lineToShow)
          i_lineToShow = -1;
          
        if(i_lineToShow == -1) //if previously showing the last line, move to show whichever is the last line now
        {
          if ( b_sort == 1 )
            this.lineVisible = -1;
          else
            this.lineVisible = 0;
        }
        else
        {
          int i_currentThreadId;
          // check if a jumping timeout thread is running

          if(tabType == AESTAB_TOP)
             i_currentThreadId = g_iLineHoldThreadTop;
          else
             i_currentThreadId = g_iLineHoldThreadBot;

          // jumping timeout thread is running - do not scroll
          if(i_currentThreadId > 0)
          {
            this.lineVisible = i_lineToShow;

            // set the global variable to define that automatic scrolling is necessary after the timeout
            if(tabType == AESTAB_TOP)
              gb_automaticScrollTimeoutTop = 1;
            else
              gb_automaticScrollTimeoutBot = 1;
          }
          else
          {
            if ( b_sort == 1 )
            {
              this.lineVisible = -1;
            }
            else
              this.lineVisible = 0;
            
            if(tabType == AESTAB_TOP)
              gb_automaticScrollTop = 0;
            else
              gb_automaticScrollBot = 0;
          }
        }
      }
      else
      {
        if ( b_sort == 1 )
          this.lineVisible = -1;
        else
          this.lineVisible = 0;
      }
    }
  } // end syncronized
 
  aes_removeFromSystemsList(getSystemName(systemId));
  aes_updateLineCount();
  
  if ( isDbgFlag("NFR_UDA") && isFunctionDefined("nfrUda_aesCbDone") )
    nfrUda_aesCbDone(ident, iNewLineCount);
}


int aes_getARLineVis( int lines, int line=-1 )
{
  int lineVis;

  if( g_arHeight > 1 )
  {
    if( lines > g_arHeight )
    {
      if( line == -1 )
      {
        // no explicit focus line set
        lineVis=(lines-g_arHeight)+1;
      }
      else
      {
        //if( line > g_arHeight )
        //  lineVis=(line-g_arHeight)+1;
        //else
          lineVis=line;
      }
    }
    else
    {
      // select first line
      lineVis=1;
    }
  }
  else
  {
    if( line == -1 )
      lineVis=lines;
    else
      lineVis=line;
  }

  // correct zero base
  lineVis--;

  return lineVis;
}


void aes_debugData( dyn_dyn_anytype &tab )
{

  int i,l, si, sl;
  dyn_anytype tda;
  const int d=5;

  aes_debugConfigMatrix( g_configMatrix );
  aes_debugSettings( g_configSettings );

  aes_debug("", d);
  aes_debug( "Data :", d );
  aes_debug( "======", d );
  aes_debug("", d);

  l=dynlen(tab);
  for(i=1; i<=l;i++)
  {
    tda=tab[i];
    sl=dynlen(tda);

    if(d)
    Debug( "data["+i+"]=", d );
    
    for( si=1; si <= sl; si++ )
    {
      if(d)
      Debug( "("+si+")"+tda[si]+" | ", d ); 
    }

    // do linefeed
    if(d)
      DebugN("");
  }

}


void aes_updateLineCount( const int alertCount=0 )
{
  int count, lineVis;
  string pre, app, tmp;
  int iTopLine, iBottomLine;

  count=this.lineCount;

  aes_getPreApp4TabType( g_tabType, pre, app );

  if( alertCount <= 0 )
  {
    tmp=count;
  }
  else
  {
    tmp=count + " / " + alertCount;
  }

  if( g_alertRow )
  {

    getValue("", "lineRangeVisible", iTopLine, iBottomLine);

    setValue( "as_lineCount", "text", count );

    if( count > 0 )
    {
      setValue(  "ar_currentLine", "text", iTopLine+1 );
    }
    else
      setValue(  "ar_currentLine", "text", 0 );

  }
  else
  {

		{ // IM 68537
		  string sSearch = "__V_ackable";
	  	int iUnaccAlerts;
		 
		  int pos = dynContains(g_colNames, sSearch); 
		  if (pos > 0)
		  {
        pos = this.nameToColumn(sSearch);
			  if (pos > 0)
			  {
	        dyn_int daAckContent;
			    daAckContent = this.getColumnN(pos);
			    iUnaccAlerts = dynCount(daAckContent, 1);     
        }
		  }
			if (iUnaccAlerts > 0)
		  {
		    tmp=tmp + " - " + iUnaccAlerts;
		  }
		}

    setValue( pre + "te_rows", "text", tmp );
  }

}


void aes_arVisible( bool up=true )
{
  int lines, line, lineVis;
  string tabName="table_top";

  int beg, end;

  getValue( tabName, "lineCount", lines,
                     "lineVisible", line );

  if( line == -1 )
  {
    line=lines;  // -1 means last line   // correct 0 Base
  }
  else
    line++; // correct 0 Base


  if( up )
  {
    if( line > 1 && ( lines > g_arHeight ) )
    {
      line--;
    }
  }
  else
  {
    if( line < ( lines - g_arHeight + 1 ) )
    {
      line++;
    }
  }

  lineVis=aes_getARLineVis( lines, line );


  if( lines > 0 )
  {
    setMultiValue(  tabName, 
                   "lineVisible", lineVis,
                    "ar_currentLine", "text", lineVis+1 );   // "current line" -indicator is 1 based
  }

}


as_initOld( const int screenType )
{
  string dpProp, dpASProp;
  int ret;
  
  dyn_int diTypeSelections;
  int i;
  
  dyn_string dsSystemNames;
  dyn_uint   duSystemIds;
  int        iCheckSystemNames;

  unsigned userId=getUserId();

  /*--- in tabelle init
  addGlobal("g_asDisplayLines", INT_VAR);        g_asDisplayLines = 0;
  addGlobal("g_asDisplayDpes", INT_VAR);         g_asDisplayDpes = 0;
  addGlobal("g_asDisplayHours", INT_VAR);        g_asDisplayHours = 0;
  */

  // As long as we do not have constants, we have to create global vars ...
  // AS_OPEN_RANGE_SEC is the number of seconds which are used for
  // splitting historical queries into pieces of this length


  // arbeitsvariablen in tabelle - g_typeFilter, g_typeConst;
  
  addGlobal("AS_HIST_RANGE_SEC", INT_VAR); AS_HIST_RANGE_SEC = 3600*24;
  addGlobal("E_AS_FUNCTION", INT_VAR); E_AS_FUNCTION = 0;
  addGlobal("E_AS_DP_VAL",   INT_VAR); E_AS_DP_VAL = 1;
  addGlobal("AS_TYPEFILTER", DYN_STRING_VAR);
  addGlobal("AS_TYPECONST", DYN_INT_VAR);
  
  AS_TYPEFILTER = makeDynString( "bit",
                                 "bit32",
                                 "unsigned integer",
                                 "integer",
                                 "float",
                                 "bit64",
                                 "ulong",
                                 "long");
  
  AS_TYPECONST  = makeDynInt( DPEL_BOOL,
                              DPEL_BIT32,                              
                              DPEL_UINT,
                              DPEL_INT,
                              DPEL_FLOAT,
                              DPEL_BIT64,
                              DPEL_ULONG,
                              DPEL_LONG);

  // ist schon in tabelle
  g_timeLastUpdate = 0;

  dpASProp = g_propDp;
  
  {    // nur weil if oben auskommentiert ist
    // Read names of all systems
    iCheckSystemNames = getSystemNames( dsSystemNames, duSystemIds );
    dyn_errClass err = getLastError();
    
    if( iCheckSystemNames == -1 )
    {
      std_error("AS", ERR_SYSTEM, PRIO_SEVERE,
                 E_AS_FUNCTION, "as_getPropsFilterTypes(): dpGet( ... FilterSystems ...)");
      return;
    }
    
    if ( dynlen(err) )
    {
      errorDialog(err);
      return;
    }
    
    
    // Default Values Filter Types
    for( i = 1; i <= dynlen( AS_TYPEFILTER ); i++ )
      dynAppend( diTypeSelections, 0 );
    
    if ( dpSetCache(dpASProp + ".Alerts.FilterState.State:_original.._value", 0,
               dpASProp + ".Both.Timerange.Type:_original.._value", 0,
               dpASProp + ".Both.Timerange.MaxLines:_original.._value", 100,
               dpASProp + ".Settings.User:_original.._value", userId,
               dpASProp + ".Alerts.FilterTypes.Selections:_original.._value", diTypeSelections,
               dpASProp + ".Alerts.FilterTypes.AlertSummary:_original.._value", AES_SUMALERTS_NO,
               dpASProp + ".Both.Systems.Selections:_original.._value", dsSystemNames
              ) == -1 )
    {
      std_error("AS", ERR_SYSTEM, PRIO_SEVERE,
                E_AS_FUNCTION, "main(): dpSet(... default values ...)");
      return;
    }
  }
  
  // check if there is the correct number of typeselections
  g_busyThread = -1;
  g_connectId = "";
  dynClear ( g_counterConnectId );
  
  dpGetCache(  "_Config.ShowInternalDPs.Alerts:_online.._value", g_showInternalsA,
          "_Config.ShowInternalDPs.AlertRow:_online.._value", g_showInternalsAR,
          "_Config.ShowInternalDPs.Events:_online.._value", g_showInternalsE,
          "_Config.MaxLines:_online.._value", g_maxClosedLines);


}


bool aes_doDpQuery(
  const int screenType,
  int valueType,
  time valBegin,
  time valEnd,
  dyn_string dsAttr,
  string from,
  string where,
  dyn_string valSystemSelections,
  bool valCheckAll,
  bool valHistoricalData,
  bool valCameWentSort,
  unsigned action,
  int valTypeAlertSummary 
)
{
  const int d=0;

  dyn_dyn_anytype tab, tabAll;
  time            t;
  unsigned        lines;
  //string          fileName, dpProp = as_getPropDP(true);
  string          fileName, dpProp;
  string          st1, st2, select, remoteSelect;
  string          pre, app;

/////// neu
  bool bOnlyOwnSystem; 
  int iSystemId, iCountSystems, iNumberSystemSelections;


  bool valChrono=(!valCameWentSort);

  string attrList;
  string identifier;

  float histDataCount=g_historicalDataInterval;
  bool queryFlag=false;
  int resultRow=0;
  string closedIdf, whereString;
  dyn_errClass err;
  
  bool b_notAllSystemsConnected;
  dyn_string ds_systemsToQuery;

  // prepared for dp use ( instead of panelglobal variable p_action )
  dpProp=g_propDp;
  
  aes_getPreApp4TabType( g_tabType, pre, app );

  g_connectId = "closedMode";

  // build attribute select statement from attributes dyn_string
  attrList=aes_getAttributeString( dsAttr, g_screenType, valueType , valTypeAlertSummary );

  // check if open mode + timerange or closed mode is selected
  // open mode
  if(valueType == 1)
  {
    st1 = valBegin;       // convert time to string
    st2 = "now";   // convert time to string
  }
  // closed mode
  else
  {
    st1 = valBegin;   // convert time to string
    st2 = valEnd;     // convert time to string
  }

  // loop selected systems

  aes_debug(__FUNCTION__+"() / HISTDATA TREATING start=" + st1 + " end=" + st2, d );

  //checkAllSystems treating
  if( valCheckAll )
  {
    dyn_uint diDummy;
    // we try to get data from all systems currently available
    // even for historical data
    
    dynClear( valSystemSelections );
    if( getSystemNames( valSystemSelections, diDummy ) == -1 )
    {
      // dialog
      aes_debug(__FUNCTION__+"() / No systems found ( for open mode history ) !", d );
      return false;
    }
  }

//  g_dsSystems = valSystemSelections;
//  iNumberSystemSelections=dynlen( valSystemSelections );

  aes_debug(__FUNCTION__+"() / checkall=" + valCheckAll + " systems=" + valSystemSelections + " len=" +iNumberSystemSelections, d );

  if(valCheckAll == 0)
    DebugFTN("aesDist",__LINE__,__FUNCTION__,"selected systems",valSystemSelections);
  else
    DebugFTN("aesDist",__LINE__,__FUNCTION__,"check all systems",valCheckAll,valSystemSelections);

  DebugFTN("aesDist",__LINE__,__FUNCTION__,"connected systems",gds_connectedSystems);
  
  // 118465 - check if all selected systems are connected
  ds_systemsToQuery = valSystemSelections;
  
  // IM 120435, TFS 3619
  if ( dynlen(ds_systemsToQuery) > 0 )
    for ( int i = 1; i <= dynlen(ds_systemsToQuery); i++ )
      strreplace(ds_systemsToQuery[i], ":", ""); 
  
  dynClear(valSystemSelections);
  
  for(iCountSystems=1;iCountSystems<=dynlen(ds_systemsToQuery);iCountSystems++)
  {
    if(!dynContains(gds_connectedSystems,ds_systemsToQuery[iCountSystems]))
    {
      DebugFTN("aesDist",__LINE__,__FUNCTION__,"system not connected",ds_systemsToQuery[iCountSystems]);
      b_notAllSystemsConnected = 1;
    }
    else
    {
      DebugFTN("aesDist",__LINE__,__FUNCTION__,"system is connected",ds_systemsToQuery[iCountSystems]);
      dynAppend(valSystemSelections,ds_systemsToQuery[iCountSystems]);
    }
  }

  DebugFTN("aesDist",__LINE__,__FUNCTION__,"systems to query",valSystemSelections);
  
  // show a warning dialog for the user
  if(b_notAllSystemsConnected == 1 && valCheckAll == 0)
  {
    dyn_float df_return;
    dyn_string ds_return;
    
    DebugFTN("aesDist",__LINE__,__FUNCTION__,"not all selected systems are connected");
    ChildPanelOnCentralModalReturn("vision/MessageWarning2",getCatStr("sc","Attention"),makeDynString(getCatStr("aes","warning_distConn"),getCatStr("general","yes"),getCatStr("sc","no")),df_return,ds_return);
    
    if(df_return[1] == 0)
    {
      DebugFTN("aesDist",__LINE__,__FUNCTION__,"cancelled by the user");
      return false;
    }
  }

  g_dsSystems = valSystemSelections;
  iNumberSystemSelections=dynlen(valSystemSelections);
  
  //check for rdb compression
  dyn_string dsFrom, dsAttrList;  
  if(screenType == AESTYPE_EVENTS && useRDBArchive())
  {
    aes_getRdbComprDpes(from, attrList, dsFrom, dsAttrList);
  }
  else
  {
    dsFrom[1] = from;
    dsAttrList[1] = attrList;
  }
  for( iCountSystems = 1; iCountSystems <= iNumberSystemSelections; iCountSystems++ )
  {
    if( iCountSystems == iNumberSystemSelections )
    {
      lastSystem=true;
    }

    aes_checkSystems( bOnlyOwnSystem );
    for (int i=1; i<=dynlen(dsFrom); i++)
    {  
      string remote, s_fromSys;
      int i_retFromSys;       
      int iQuerySuccess;

      if( bOnlyOwnSystem )
      {
        string s_fromToCheck;

        remote = valSystemSelections[iCountSystems];
        iSystemId = getSystemId(  valSystemSelections[iCountSystems] + ":" );
        remoteSelect="";

        // 118465 - call a FROM statement only with DPEs for the own system
        s_fromToCheck = dsFrom[i];
        DebugFTN("aesDist",__LINE__,__FUNCTION__,"check FROM statement",remote,s_fromToCheck);
        aes_createFromSys(s_fromToCheck,remote,s_fromSys,i_retFromSys);
        if(i_retFromSys == -1)
        {
          DebugFTN("aesDist",__LINE__,__FUNCTION__,"no matching DPEs in FROM statement",remote,i_retFromSys);
        }
        else
        {
          DebugFTN("aesDist",__LINE__,__FUNCTION__,"do historical dpQuery",i_retFromSys,remote,s_fromSys);
        }
      }
      else
      {
        string idf;
        string s_fromToCheck;

        remote = valSystemSelections[iCountSystems];
        iSystemId = getSystemId( remote + ":" );

        // 118465 - call a FROM statement only with DPEs for the own system
        s_fromToCheck = dsFrom[i];
        DebugFTN("aesDist",__LINE__,__FUNCTION__,"check FROM statement",remote,s_fromToCheck);
        aes_createFromSys(s_fromToCheck,remote,s_fromSys,i_retFromSys);
        if(i_retFromSys == -1)
        {
          DebugFTN("aesDist",__LINE__,__FUNCTION__,"no matching DPEs in FROM statement",remote,i_retFromSys);
        }
        else
        {
          DebugFTN("aesDist",__LINE__,__FUNCTION__,"do historical dpQuery",i_retFromSys,remote,s_fromSys);
        }
      
        //  sinnhaftigkeit ????? if there is asked a wrong system stop query. Message was still shown

        idf=aes_createIdentifier( g_tabType, g_valType, iSystemId );
        aes_debug(__FUNCTION__+"() / IN SYSTEM LOOP g_counterConnectId=" + g_counterConnectId + " iSystemId=" + iSystemId + " idf=" + idf );
      
        if( strpos( remote, ":" ) <= -1)
          remote += ":";
      
        remote = "'" + remote + "'";

        remoteSelect=" REMOTE " + remote;
      }

      //select = "SELECT ALERT " + dsAttrList[i] + " FROM " + dsFrom[i] + " REMOTE " + remote + " WHERE " + where;

      string sFilterLang = "";

      if( where != "" )
      {
        if ( strpos(where, " FILTERLANG ") != -1 )
        {
          strreplace(where, " FILTERLANG ", "~");
          whereString=" WHERE " + strsplit(where, "~")[1];
          sFilterLang = " FILTERLANG " + strsplit(where, "~")[2];
        }
        else
          whereString=" WHERE " + where;
      }
      else
        whereString=" ";

      if( screenType == AESTYPE_EVENTS )
      {
        select =  "SELECT " + dsAttrList[i] + " FROM " + s_fromSys + remoteSelect + whereString +
                 " TIMERANGE(\"" + st1 + "\",\"" + st2 + "\",1,0) "+sFilterLang;
      }
      else
      {
        select = "SELECT ALERT " + dsAttrList[i] + " FROM " + s_fromSys + remoteSelect + whereString +
                 " TIMERANGE(\"" + st1 + "\",\"" + st2 + "\",1,0) "+sFilterLang;
      }

      //mt: additional filters
      if(isFunctionDefined("HOOK_aes_modifyQuery"))
        HOOK_aes_modifyQuery(select, dpProp);
      
      // 118465 - only if the FROM statement is okay we start the query
      if(i_retFromSys != -1)
      {
        DebugFTN("aesDist",__LINE__,__FUNCTION__,"start dpQuery command",remote,select);
        iQuerySuccess = dpQuery( select, tab );
        err = getLastError();
        DebugFTN("aesDist",__LINE__,__FUNCTION__,"number of results for dpQuery command",dynlen(tab),select);
      }
      else
      {
        // set iQuerySuccess for further handling of errors if the query was not started
        DebugFTN("aesDist",__LINE__,__FUNCTION__,"dpQuery command not started",remote,select);
        iQuerySuccess = -1;
      }
      
      //IM 111393 Remove internal alerts////////////////
      if ( !g_showInternalsA && !g_alertRow )
      {
        for ( int i = dynlen(tab); i > 2; i-- )
        {
          if ( dpTypeName(tab[i][1])[0] == "_" )
            dynRemove(tab, i);
        }
      }
      else if ( !g_showInternalsAR && g_alertRow )
      {
        for ( int i = dynlen(tab); i > 2; i-- )
        {
          if ( dpTypeName(tab[i][1])[0] == "_" )
            dynRemove(tab, i);
        }
      }
      //////////////////////////////////////////////////
  
      bool bError = false; // IM 91326
      if( iQuerySuccess == -1 )
      {
        if( lastSystem )
          aes_stopBusy( g_tabType );

        aes_checkQueryError( err, iSystemId, 2 );
        continue;
      }
      else if (dynlen(err) != 0)
      {
        bError = true;  // IM 91326
      }

      //aes_debug( __FUNCTION__+"() / dpQUery len=" + dynlen( tab ) + " ====================================>" );

      // count result rows ( excluding the header )
      if( dynlen(tab) > 0 )
        resultRow+=(dynlen(tab)-1);

      if( dynlen( err ) > 0 )
      {
        if( lastSystem )
          aes_stopBusy( g_tabType );

        aes_checkQueryError( err, iSystemId, 2 );
        continue;
    }

    if( dynlen(tab) > 0 )
      lines += (dynlen( tab ) - 1);   // sum of all lines - 1 header line per query
    
    //  g_asDisplayLines:
    //    == 0 ... No question yet
    //    == 1 ... Cancel query
    //    == 2 ... Continue query[/displaying]

    //  Questions:
    //    lines > g_maxClosedLines -> Ende (Always checken)

    //    lines > g_asMaxLinesToDisplay (check only, if g_asDisplayLines == 0)
    //              -> Query not yet ready: "Question: Continue query?" (may come once)
    //                 ( sc.cat - toomuchalert3 (replace text by 'g_asMaxLinesToDisplay')
    //              -> Query ready (End time reached): "Question: Display?"
    //                 ( sc.cat - toomuchalert2 (replace text by 'g_asMaxLinesToDisplay',
    //                                           text by 'lines')


    //check closed lines limit!!!
    //***************************
    //***************************
    if(valueType == AES_MODE_CLOSED)
    {
      if( !aes_checkMaxClosedLines( lines, screenType ) )
      {
        return false;
        // fehler - aktion !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        //**************************************************
        //**************************************************
      }
    }

    //check maxLines limit
    //*****************!!!
    //*****************!!!
    if(valueType == AES_MODE_CLOSED)    //Hier in der Funktion kann es nur der Modus 'Open+HistData' und 'Closed' sein
    {                                   //Fuer 'Current', 'Open' und 'Open+Hist' erfolgt die Pruefung auf die max. Zeilenanzahl ueber 'aes_workCB'
      if( !aes_checkMaxLinesToDisplayProp( lines, screenType ) )
      {
        return false;
      }
    }


      // if theres no error here - we suppose the system connection is ok and append conKey to closedConnList
      if (!bError) // IM 91326, only append if System is available
        aes_appendClosedIdent4SysId( iSystemId );

      // we don't care about the dummy systeminformation - it's not necessarry here
      // but we have to care about the screenType
      // at events - valType(mode) has to be "closedMode"
      // at alerts - valType(mode) has to be "closedModeAppend" !!!!
      if( screenType == AESTYPE_EVENTS )
      {
        identifier=aes_createIdentifier( g_tabType, AES_MODE_CLOSED, iSystemId, true );      // nur dummy, muss in workCB abgefangen werden damit connectliste nicht erweitert wird
      }
      else
      {
        identifier=aes_createIdentifier( g_tabType, AES_MODE_CLOSEDAPP, iSystemId, true );
      }

      // even events will be handeled here / valChrono was set to true as default
      if ( valChrono && (action != AES_ACTION_SAVE ) )
      {
        // check the number of lines and which filters are used 
        if(valueType == AES_MODE_OPEN)
        {
          //DebugTN(__LINE__,__FUNCTION__,"mode AES_MODE_OPEN");
          
          // check if no filter for a dp description or an alert comment is used
          if(!g_configSettings[AESET_COMMENTFILTER] && gb_useBLEComment == 0)
          {
            int i_count;
            
            //DebugTN(__LINE__,__FUNCTION__,"no AESET_COMMENTFILTER or gb_useBLEComment");
            
            i_count = dynlen(tab)-1;
            //DebugTN(__LINE__,__FUNCTION__,"check lines",i_count,g_maxLines);

            // check if the number of lines is higher than the display limit
            if(i_count >= g_maxLines)
            {
              dyn_dyn_anytype dda_tabRes;
              dyn_anytype da_header;
              int i_lines;
  
              da_header = tab[1];
              dynRemove(tab,1);
            
              // sort the query result according to time and DPE
              //DebugTN(__LINE__,__FUNCTION__,"query result",tab);
              dynDynSort(tab,2,TRUE);
        
              for(i_lines=i_count-g_maxLines+1;i_lines<=dynlen(tab);i_lines++)
              {
                //DebugTN(__LINE__,__FUNCTION__,i_lines,tab[i_lines]);
                dynAppend(dda_tabRes,tab[i_lines]);
              }
              
              tab = dda_tabRes;
              // add the header information
              dynInsertAt(tab,da_header,1);
              //DebugTN(__LINE__,__FUNCTION__,"dynlen tab",dynlen(tab));
            }
          }
        }

        DebugFTN("aesDist",__LINE__,__FUNCTION__,"call aes_workCB",dynlen(tab),identifier);
        aes_workCB( identifier, tab, true );
      }
      else
      {
        if ( dynlen(tabAll) > 0 ) dynRemove(tab, 1);  // delete header-line
        dynAppend(tabAll, tab);
      }
    }//for each from and attriute list of RDB compression

    // if at least one query was successfull
    queryFlag=true;

  } // End loop systems

  
  // resort the result to "left" after "entered" alert
  // if valChrono wasn't set, we will add all datas ( tabAll ) here / alerts data we have to resort
  if ( ! valChrono && (action != AES_ACTION_SAVE ) )
  {
      // implement screenType depending part

      // ACHTUNG - daten werden vor add sortiert / pruefe resortTab fuer dynamischen Aufbau
      // sortierung partnerweise - nur bei alerts
      aes_debug( __FUNCTION__+"() / CALL WORK ident=" + identifier + " ==> !valchrono/action !Save ", d );
      aes_workCB( identifier, aes_resortTab(screenType, tabAll), true );    // uses the last defined identifier
  }


  if ( action == AES_ACTION_PRINT )
  {
    if( valueType != AES_MODE_CLOSED && ( !g_longTest ) )
    {
      aes_throwError( AES_TE_PRINTSAVENOTPOS );
    }
    else
    {
      if( screenType == AESTYPE_EVENTS )
      {
        aes_es_printTable( dpProp, this.name, false );
      }
      else
      {
        aes_as_printTable( dpProp, this.name, false );
      }
    }
    
  }
  else if ( action == AES_ACTION_SAVE && ( !g_longTest ) )
  {
    dyn_dyn_anytype ret, xtab2;
    dyn_int diFontAttr;
    dyn_dyn_anytype xtab;

    if( valueType != AES_MODE_CLOSED )
    {
      aes_throwError( AES_TE_PRINTSAVENOTPOS );
    }
    else
    {
      xtab = valChrono ? tabAll : aes_resortTab(screenType, tabAll);

      if( screenType == AESTYPE_EVENTS )
      {
        convertAlertTabEx2( xtab, g_configSettings, g_configMatrix, ret, xtab2, diFontAttr );
        aes_saveTable( p_fileName, ret);
      }
      else
      {
        convertAlertTabEx2( xtab, g_configSettings, g_configMatrix, ret, xtab2, diFontAttr );
        // for automatic run
        aes_saveTable( p_fileName, ret);
      }
    }
  }

  // if we are in closed mode and no datas were found / we have to stop the busy bar
  if( resultRow <= 0 && ( valueType == AES_MODE_CLOSED ) && lastSystem)  // IM 63154
  {
    aes_stopBusy( g_tabType );
  }

  if( queryFlag )
    return true;
  else
    return false;
}


bool aes_checkMaxClosedLines( int lines, int screenType )
{
  string sTemp;

  if ( lines >= g_maxClosedLines)  // too much lines -> show warning -> cancelled
  {

    if( screenType == AESTYPE_EVENTS )
      sTemp = getCatStr("sc","toomuchEventsCancel");
    else
      sTemp = getCatStr("sc","toomuchAlertsCancel");

    strreplace(sTemp, "\uA7", lines);
    strreplace(sTemp, "\uB0", g_maxClosedLines);
    aes_stopBusy( g_tabType );
  
    ChildPanelOnCentralModal("vision/MessageWarning", "", makeDynString(sTemp));
//            setValue("cancel", "enabled", false);

    setValue("", "deleteAllLines");
    setValue("", "visible",true);

    aes_doStop( g_propDp );
    return false;
  }

  return true;
}


void aes_checkSystems( bool &bOnlyOwnSystem )
{
  int        errorFlag;
  dyn_string names;
  dyn_uint   ids;

 
  // Getting all systems
  errorFlag = getSystemNames( names, ids );
  dyn_errClass err = getLastError();
  
  if( errorFlag == - 1 )
  {
    aes_stopBusy( g_tabType );
    std_error("AS", ERR_SYSTEM, PRIO_SEVERE,
      E_AS_FUNCTION, "checkSystems(): getSystemNames(...)");
      return;
  }
  
  if ( dynlen(err) )
  {
    aes_stopBusy( g_tabType );
    errorDialog(err);
    return;
  }
  
  // If there is only one system available it must be this system
  if( dynlen( names ) == 1 )
    bOnlyOwnSystem = true;
  else
    bOnlyOwnSystem = false;
}


void aes_dbt( int count, double ts, double te )
{
  string tmp;
  double td=te-ts;
  sprintf( tmp, "%0.10f", td );
  aes_debug( "TimeDiff(New/"+count+")="+tmp, 3 );
}


void aes_deleteSystemTableRows( string sysName )
{
  const int d=0;

  //aes_debug(__FUNCTION__+"() / DELETING datas for system=" + sysName, d );

  this.deleteLines( 1, _SYSNAME_, makeDynString( sysName ) );
}


synchronized aes_removeFromSystemsList(string sSystemName)
{
  int position;
  
  sSystemName = strrtrim(sSystemName, ":");
  position = dynContains(g_dsSystems, sSystemName);
  if(position)
    dynRemove(g_dsSystems, position);  
  
  if(dynlen(g_dsSystems) == 0)
    aes_stopBusy( g_tabType );
}


aes_dpQueryConnectThread(
  int valType,
  string valSystemName,
  bool valCheckAllSystems,
  bool wantsAnswer,
  int iSystemId,
  string command,
  int i_retFromSys
)
{
  string identifier;
  int ret;
  dyn_errClass err;
  bool b_systemConnected;
  
  DebugFTN("aesDist",__LINE__,__FUNCTION__,valSystemName,command,i_retFromSys);
  
  identifier=aes_createIdentifier( g_tabType, valType, iSystemId );

  //Currently the query connect waits for the first answer before code execution continues.
  //This leads to a slow AES startup time when querying many distributed systems.
  //Maybe the queries could be setup and executed in threads to allow each system to process in parallel.

  // check if the system is connected
  if(dynContains(gds_connectedSystems,valSystemName) > 0)
  {
    DebugFTN("aesDist",__LINE__,__FUNCTION__,"system is connected",valSystemName);
    b_systemConnected = 1;
  }
  else
  {
    b_systemConnected = 0;
  }
  
  // if FROM statement matches the own system the query will be started
  if(i_retFromSys != -1 && b_systemConnected == 1)
  {
    DebugFTN("aesDist",__LINE__,__FUNCTION__,"call dpQueryConnectSingle",valSystemName,identifier,command);
    ret = dpQueryConnectSingle( AESQUERY_WORKFUNC, wantsAnswer, identifier, command, g_queryBlockedTime );
    err = getLastError();
  }
  if( ret == -1 || i_retFromSys == -1 || b_systemConnected == 0)
  {
    aes_removeFromSystemsList(valSystemName);
    aes_stopBusy( g_tabType );

    // throw an error if the FROM statement does not match the own system   
    if(i_retFromSys == -1)
    {
      dyn_errClass deC_error;
      
      deC_error = makeError("_errors",PRIO_INFO,ERR_PARAM,54,getCatStr("aes","warning_fromQueryDist") + " '" + valSystemName + "'");
      throwError(deC_error);
    }

    if(ret == -1)
      std_error("AS", ERR_SYSTEM, PRIO_SEVERE,E_AS_FUNCTION, "propertiesCB(): dpQueryConnectSingle(...)");

    if( aes_checkQueryError( err, iSystemId, 3 ) == AES_CHKERR_ABORT )
    {
      this.deleteAllLines;
      aes_doStop( g_propDp );
      g_mQueryReplies[iSystemId] = false;
      return;
    }

    if( !valCheckAllSystems )
    {
      iSystemId = 0;
      g_mQueryReplies[iSystemId] = false;
      return;
    }
  }
  
  if( dynlen( err ) > 0 )
  {
    aes_removeFromSystemsList(valSystemName);
    if( aes_checkQueryError( err, iSystemId, 3 ) == AES_CHKERR_ABORT )
    {
      dyn_string dsIdf;
      //setValue("", "deleteAllLines");

      // we have to explicitly disconnect because we suppose that the event keeps the query
      // disconnect in cmdStop wan't be successfull because identifierlist is empty
      dsIdf=makeDynString( identifier );
      aes_queryDisconnect( dsIdf );

      aes_doStop( g_propDp );
      g_mQueryReplies[iSystemId] = false;
      return;
    }
      
    if( !valCheckAllSystems )
    {
      g_mQueryReplies[iSystemId] = false;
      return; 
    }
  }

  g_mQueryReplies[iSystemId] = true;

  //IM 98673 checks if showAllSystems is selected
  // add all system to list of identifiers
  if(valCheckAllSystems)
  {
    string s_ownSystem;
    
    s_ownSystem = getSystemName();
    strreplace(s_ownSystem,":","");

    // add the query identifier
    DebugFTN("aesDist",__LINE__,__FUNCTION__,"add identifier",identifier);
    aes_appendIdentifier( identifier );

    // add all systems to the list of connected systems
    DebugFTN("aesDist",__LINE__,__FUNCTION__,"add connected systems",gds_connectedSystems);
    gds_queryConnectedSystems = gds_connectedSystems;
  }
  else
  {
    // IM 118465 if the query was successful we add the system name to the list of connected systems
    if(!dynContains(gds_queryConnectedSystems,valSystemName))
    {
      DebugFTN("aesDist",__LINE__,__FUNCTION__,"add connected system",valSystemName);
      dynAppend(gds_queryConnectedSystems,valSystemName);
      DebugFTN("aesDist",__LINE__,__FUNCTION__,"connected systems",gds_queryConnectedSystems);

      DebugFTN("aesDist",__LINE__,__FUNCTION__,"add identifier",identifier);
      aes_appendIdentifier( identifier );
      aes_createDistInfo();
    }
  }
}


bool aes_doQueryConnect(
  const int screenType,
  int valType,
  dyn_string dsAttr,
  string from,
  string c_where,
  dyn_string valSystemSelections,
  bool valCheckAllSystems,
  int valTypeAlertSummary 
)
{
  bool    bOnlyOwnSystem, wantsAnswer=false;
  int     iSystemId;
  string  remote, command, remoteCommand, attrList;

  int iCountSystems, iNumberSystemSelections;
  bool connectFlag=false;
  string tmpCmd, whereString;
  
  int i_retFromSys;
  
  dyn_string ds_systemsToQuery;
  bool b_notAllSystemsConnected;
  
  mappingClear(g_mQueryReplies);  

  if(valCheckAllSystems == 0)
    DebugFTN("aesDist",__LINE__,__FUNCTION__,"selected systems",valSystemSelections);
  else
    DebugFTN("aesDist",__LINE__,__FUNCTION__,"check all systems",valCheckAllSystems);

  
  // 118465 - check if all selected systems are connected
  if(valCheckAllSystems == 0)
  {
    ds_systemsToQuery = valSystemSelections;
    
    // IM 120435, TFS 3619
    if ( dynlen(ds_systemsToQuery) > 0 )
      for ( int i = 1; i <= dynlen(ds_systemsToQuery); i++ )
        strreplace(ds_systemsToQuery[i], ":", ""); 
    
    dynClear(valSystemSelections);
  
    for(iCountSystems=1;iCountSystems<=dynlen(ds_systemsToQuery);iCountSystems++)
    {
      if(!dynContains(gds_connectedSystems,ds_systemsToQuery[iCountSystems]))
      {
        DebugFTN("aesDist",__LINE__,__FUNCTION__,"system not connected",ds_systemsToQuery[iCountSystems]);
        b_notAllSystemsConnected = 1;
      }
      else
      {
        DebugFTN("aesDist",__LINE__,__FUNCTION__,"system is connected",ds_systemsToQuery[iCountSystems]);
        dynAppend(valSystemSelections,ds_systemsToQuery[iCountSystems]);
      }
    }

    DebugFTN("aesDist",__LINE__,__FUNCTION__,"systems to query",valSystemSelections);

    // show a warning dialog for the user
    if(b_notAllSystemsConnected == 1 && valCheckAllSystems == 0)
    {
      dyn_float df_return;
      dyn_string ds_return;
    
      DebugFTN("aesDist",__LINE__,__FUNCTION__,"not all selected systems are connected");
      ChildPanelOnCentralModalReturn("vision/MessageWarning2",getCatStr("sc","Attention"),makeDynString(getCatStr("aes","warning_distConn"),getCatStr("general","yes"),getCatStr("sc","no")),df_return,ds_return);
    
      if(df_return[1] == 0)
      {
        DebugFTN("aesDist",__LINE__,__FUNCTION__,"canceled by the user");
        return false;
      }
    }
  }

  g_dsSystems = valSystemSelections;
  iNumberSystemSelections=dynlen( valSystemSelections );

  // save the current AES settings in a global dyn_anytype
  da_screenSettings[1] = screenType;
  da_screenSettings[2] = valType;
  da_screenSettings[3] = dsAttr;
  da_screenSettings[4] = from;
  da_screenSettings[5] = c_where;
  da_screenSettings[6] = valSystemSelections;
  da_screenSettings[7] = valCheckAllSystems;
  da_screenSettings[8] = valTypeAlertSummary;

  DebugFTN("aesDist",__LINE__,__FUNCTION__,"iNumberSystemSelections",iNumberSystemSelections);

  // an update for the dist information is necessary
  if(iNumberSystemSelections == 0)
  {
    aes_createDistInfo();
  }
  else
  {
    for( iCountSystems = 1; iCountSystems <= iNumberSystemSelections; iCountSystems++ )
    {
      string s_fromToCheck;
      string s_fromSys;

      // for every loop we have to use the initial from statement
      // the result is written to s_fromSys
      s_fromToCheck = from;
    
      if( valType == AES_MODE_CURRENT )
      {
        wantsAnswer=true;   // only with current mode we want an answer
      }
      else
      {
      
        // ATTENTION - isAnswer() is no longer in use 
        // at reduswitch we react on special errocode 157
        wantsAnswer=false;    // see AES_ERR_REDUOPENDISC - no automatic refresh at reduswitch in open mode -  we only will delete obsolete data from table
      }

      // 118465 - only when a list of system is selected a check needs to be done
      if(valCheckAllSystems == 0)
        aes_checkSystems( bOnlyOwnSystem );
    
      if( bOnlyOwnSystem )
      {
        // 118465 - call a FROM statement only with DPEs for the own system
        DebugFTN("aesDist",__LINE__,__FUNCTION__,"call aes_dpQueryConnectThread",s_fromToCheck);
        aes_createFromSys(s_fromToCheck,getSystemName(),s_fromSys,i_retFromSys);
        if(i_retFromSys == -1)
        {
          DebugFTN("aesDist",__LINE__,__FUNCTION__,"no matching DPEs in FROM statement",i_retFromSys);
        }
        else
        {
          DebugFTN("aesDist",__LINE__,__FUNCTION__,"call aes_dpQueryConnectThread",i_retFromSys,s_fromSys);
        }
        iSystemId = getSystemId();
        remoteCommand="";
      }
      else
      {
        remote = valSystemSelections[iCountSystems];
        if( strpos( remote, ":" ) <= -1)
        {
          remote += ":";
        }
        
        iSystemId = getSystemId( remote );
        remote = "'" + remote + "'";
    
        if( valCheckAllSystems )
        {
          // in case of REMOTE ALL we need to make a query for every system if the FROM statement contains system names
          // if the result of aes_createFromSys == 1 REMOTE ALL can be used
        
          DebugFTN("aesDist",__LINE__,__FUNCTION__,"check if REMOTE ALL can be used",s_fromToCheck);
          aes_createFromSys(s_fromToCheck,getSystemName(),s_fromSys,i_retFromSys);
          if(i_retFromSys == 1)
          {
            DebugFTN("aesDist",__LINE__,__FUNCTION__,"connect to all systems using REMOTE ALL");
            remoteCommand=" REMOTE ALL ";
            b_remoteAllSingleQueries = 0;
          }
          else
          {
            // call the function to make an own query for every system
            DebugFTN("aesDist",__LINE__,__FUNCTION__,"call aes_connectAllDistributedSystems");
            if(valCheckAllSystems)
              b_remoteAllSingleQueries = 1;
            aes_connectAllDistributedSystems();
            break;
          }
        }
        else
        {
          // 118465 - call a FROM statement only with DPEs for the own system
          DebugFTN("aesDist",__LINE__,__FUNCTION__,"call aes_dpQueryConnectThread",from);
          aes_createFromSys(s_fromToCheck,remote,s_fromSys,i_retFromSys);
          if(i_retFromSys == -1)
          {
            DebugFTN("aesDist",__LINE__,__FUNCTION__,"no matching DPEs in FROM statement",i_retFromSys);
          }
          else
          {
            DebugFTN("aesDist",__LINE__,__FUNCTION__,"call aes_dpQueryConnectThread",remote,from);

            remoteCommand=" REMOTE " + remote;
          }
        }
      }

      // build attribute select statement from attributes dyn_string
      attrList=aes_getAttributeString( dsAttr, screenType, valType , valTypeAlertSummary );

      //command="SELECT ALERT " + attrList + " FROM " + from + " REMOTE " + remote + " WHERE " + c_where;

      if( c_where != "" )
        whereString=" WHERE " + c_where;
      else
        whereString=" ";

      if( screenType == AESTYPE_EVENTS )
      {
        // orig command="SELECT " + attrList + " FROM " + from + remoteCommand + " WHERE " + c_where;
        command="SELECT " + attrList + " FROM " + s_fromSys + remoteCommand + whereString; 
        tmpCmd="SELECT attrList FROM " + s_fromSys + remoteCommand + whereString;
      }
      else
      {
        // orig command="SELECT ALERT " + attrList + " FROM " + from + remoteCommand + " WHERE " + c_where;
        command="SELECT ALERT " + attrList + " FROM " + s_fromSys + remoteCommand + whereString; 
        tmpCmd="SELECT ALERT attrList FROM " + s_fromSys + remoteCommand + whereString; 
      }
      //mt: additional filters
      if(isFunctionDefined("HOOK_aes_modifyQuery"))
        HOOK_aes_modifyQuery(command, g_propDp);
      

      // valType in diesem fall o.k. 0,1,2 currentMode,openMode,closedMode - closedModeAppend hier nicht
      // ACHTUNG - pruefe ob bei events 1 u. 2 kommt ( open/closed ) !!!
      // in check all mode we have to use the dummysysid because we don not know the right one
      if( valCheckAllSystems )
      {
        iSystemId=AES_DUMMYSYSID;
      }

      // start the query with the correct query string
      DebugFTN("aesDist",__LINE__,__FUNCTION__,"call aes_dpQueryConnectThread",valSystemSelections[iCountSystems],command);
      startThread("aes_dpQueryConnectThread", valType, valSystemSelections[iCountSystems],valCheckAllSystems, wantsAnswer, iSystemId, command, i_retFromSys);

      // if we are in checkAll mode we need only one query connect - even for the own system
      // therefore a break is made at the end of the first loop
      if( valCheckAllSystems )
      {
        break;
      }

    }// end loop systems
  }
    
  if( valCheckAllSystems )
    iNumberSystemSelections = 1;
  
  while(mappinglen(g_mQueryReplies) < iNumberSystemSelections)
  {
    delay(0,100);
  }    
  if(dynlen(g_counterConnectId) > 0)
    connectFlag = true;
  
  // if we have at least one successfull connect - we return o.k.
  if( connectFlag )
    return true;
  else
    return false;

}


void aes_throwError( int code, int prio=PRIO_WARNING, string note1="", string note2="", string note3="" )
{
  dyn_errClass dErr;
  bit32 b32=0;
  int type, manId, userId;
  string cat, dp;

  cat=AES_CATALOGUE;
  
  type=ERR_SYSTEM;

  dp="";

  if( note3 != "" )
    dErr=makeError( cat, prio, type, code, note1, note2, note3 );
  else if( note2 != "" )
    dErr=makeError( cat, prio, type, code, note1, note2 );
  else if( note1 != "" )
    dErr=makeError( cat, prio, type, code, note1 );
  else
    dErr=makeError( cat, prio, type, code );


  throwError( dErr );
}


void aes_debugTableData( dyn_dyn_anytype &xtab )
{
  int i,l;
  l=dynlen(xtab);
  for(i=1; i<=l;i++)
  {
    aes_debug("  xtab["+i+"]="+xtab[i], 5 );
  }
}


/**
  Function to update the g_configMatrix reference indexes when an item is deleted from attrList
  TFS 13083
*/
void aes_updateReferenceIndexes(int index)
{
  for (int counter = 1; counter <= dynlen(g_configMatrix); ++counter)
  {
    if ((dynlen(g_configMatrix[counter]) >= 1) && (getType(g_configMatrix[counter][1]) == DYN_INT_VAR) ) // this should always be true
    {
      // iterate the reference indexes twice
      // first remove the references to the deleted lines
      for (int line = 1; line <= dynlen(g_configMatrix[counter][1]); ++line)
      {
        if (g_configMatrix[counter][1][line] == index)
        {
          dynRemove(g_configMatrix[counter][1], line);
        }
      }
  
      // update the references
      for (int line = 1; line <= dynlen(g_configMatrix[counter][1]); ++line)
      {
        if (g_configMatrix[counter][1][line] > index)
        {
          g_configMatrix[counter][1][line] -= 1;
        }
      }
    }
  }
}


/**
  Main properties callback function. 
  @param identifier Identifies the query
  @param tab Table with callback attribute/row matrix
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/
void aes_propertiesScreenCB(
             unsigned valState,
             string valShortcut,
             string valPrio,
             string valDpCommentFilter,   // event mapping
             string valAlertText,
             dyn_string valDpList,        // event mapping
             unsigned valMinPrio,
             
             dyn_string valSortList,
             
             unsigned valType,
             time valBegin,
             time valEnd,
             bool valChrono,
             bool valCameWentSort,        // new!!!
             bool valHistoricalData,      // new!!!
             unsigned valMaxLines,
             unsigned valSelection,
             unsigned valShift,

             string currentConfig,
             
             dyn_int valTypeSelections,   // event mapping
             int valTypeAlertSummary,
             
             dyn_string valSystemSelections,
             bool valCheckAllSystems,
             time valTimeUpdate,
             bit32  valUserbits,
             //------------ neu
             bool valOneRowPerAlert,
             unsigned valOpenClosedMode,
             unsigned valDirection,
             unsigned valLogicalCombine,
             dyn_string addValValue,    
             dyn_string addValCombine,  
             dyn_string addValCompare,  
             dyn_string addValIndex     
             )
{
  string from, where, c_where;
  string strMinPrio = valMinPrio;
  int    count;
  string remote;
  int    iNumberSystemSelections;
  int    iCountSystems;
  int    n;
  bool   bOnlyOwnSystem;
  int    iSystemId;
  int    noOfDpes;

  int    screenType;

  dyn_string attrList;
  unsigned action;

  time t;
  int hours;
  
  dyn_string sortList;
  dyn_bool sortAsc;

  aes_debug( __FUNCTION__+"() / checkAllSystems=" + valCheckAllSystems );

  // reset closed idf list and connect counter
  dynClear( g_closedIdf );


  g_historicalData=valHistoricalData;

  // prepared for dp use ( instead of panelglobal variable ) => see aes_doDpQUery()
  action=p_action;

  // needed for aes_append(closed)Ident4SysId()
  g_valType=valType;

  
  // try to disconnect all id's in any case ( independent from g_connectId !? )
  // new - runmodeset happens within function
  aes_queryDisconnect( g_counterConnectId );

  // deltete full table content in any case
  this.deleteAllLines();

//1 createSettings() - bestimmte Parameter aus Properties beruecksichtigen  / dpComment, oneRowPerAlert etc.

//2 Ueberparametrierung der Spaltensichtbarkeit aus Properties beruecksichtigen !!!


///////// PRUEFEN OB HIER NOCH NOTWENDIG !!!!!!!!!!!!!!!!!!!!!

  if( dynlen( valSortList ) <= 0 )
  {
    //if we have an empty sort list we do a time sort / performance !!!
    dynAppend( valSortList, _TIME_ );
  }

  valSortList=aes_correctTimeSort( valSortList );

  if( valCameWentSort )
  {
    // deactivate table sort / attention - slow sort / slow table update !!!!!
    // we use aes_resortTab()
    this.sortDyn=makeDynString();  
  
  }
  else
  {
    aes_splitSortList(valSortList, sortList, sortAsc);
    setValue (getShape(this.name), "sortDyn", sortAsc, sortList);
  }


  // historical data treating
  if( valType != AES_MODE_OPEN )
  {
    valHistoricalData=false;
  }

  //DebugN("cameWentSort="+ valCameWentSort );
  //DebugN("historicalData="+ valHistoricalData );
  //DebugN("g_historicalDataInterval="+ g_historicalDataInterval );
  
  // Check redu-switch
  if (valTimeUpdate == g_timeLastUpdate) // No update when redu-switch
  {
//    return;
  }
  else
  {
    g_timeLastUpdate = valTimeUpdate;
  }

  aes_getScreenType( g_propDp, screenType );
  // every query run will step through this routine
  // settings screenType to global variable for better performance


/////////// IMPLEMENTIEREN UND AKTIVIEREN  
  //g_screenType=screenType; 
  
//   std_startBusy();
  
  g_dpCommentFilter = valDpCommentFilter;
  g_maxLines = valMaxLines;
  // entfernen wenn bei defaultproperties implementiert
  if( g_maxLines == 0 )
  {
    g_maxLines=100;
  }


  g_state    = valState;
  iNumberSystemSelections = dynlen( valSystemSelections );
  


  /*
  // allow "set filter" button in openMode or closedMode
  if ( (valType == 1) || (valType ==2) )
  {
    setMultiValue("", "tableMode", TABLE_SELECT_BROWSE,
                  "", "selectByClick", TABLE_SELECT_LINE,
                  "filter", "enabled", true,
                  "trend",  "enabled", true);
  }
  else
  {
    setMultiValue("", "tableMode", TABLE_SELECT_NOTHING,
                  "filter", "enabled", false,
                  "trend",  "enabled", false);
  }
  */

  {  // correct begin/end-times
    // time t;
    // end-time must be greater than begin-time
    // if ( valBegin > valEnd ) { t = valBegin; valBegin = valEnd; valEnd = t; }
    // IM 117474 - do not modify the times and give a warning if valBegin > valEnd
    if ( valBegin > valEnd )
    {
      string sWarningText;
      sWarningText = getCatStr( "misc", "valSmall" );
      ChildPanelOnCentralModal("vision/MessageWarning", "", makeDynString( "$1:" + sWarningText ));
      aes_doStop(g_propDp);
      return;
    }
    
    // this check is not necessary anymore
    // if ( valEnd > getCurrentTime() ) valEnd = getCurrentTime();
  }
  // attributes were prebuild and saved in scriptglobal variable
  attrList=g_attrList;


  if( screenType == AESTYPE_EVENTS )
  {
    aes_esGetFromWhere(from, where, valDpList, valUserbits, valDpCommentFilter, valTypeSelections,( (valType==AES_MODE_CLOSED)?true:false ),
                       valSystemSelections, valCheckAllSystems);  // da valType in der Funktion nicht verwendet wird nur dieser zentrale Aufruf !! 
    where = " _LEAF " + where;
  }
  else
  {
    //
    aes_AV_asGetFromWhere(from, where, valState, valShortcut, valPrio, valAlertText, valDpList, valTypeSelections, valTypeAlertSummary, valType,
    // new filters 
    valOpenClosedMode,
    valDirection,
    valLogicalCombine,"", strMinPrio,
    addValValue,    
    addValCombine,  
    addValCompare,  
    addValIndex,    
    valSystemSelections,
    valCheckAllSystems     
    );

  }

  // checking if number of dpes greater then g_asMaxDpeToDisplay
  if ( valType != AES_MODE_CURRENT )   // open mode or closed mode / even events !!!
  {
    aes_getDpesOfFilter(from, true, noOfDpes);

    if (noOfDpes == -1 || noOfDpes > g_asMaxDpeToDisplay)
    {
      dyn_float  df;
      dyn_string ds;
      string     sTemp;

      // Die aktuelle Anzahl der DPE konnte nicht festgestellt werden.
      // Es ist moeglich, dass die Anzahl sehr gross ist, und damit die Abfrage lange dauert.
      // Wollen Sie die Abfrage starten?
      if (noOfDpes != -1)
      { 
        if( screenType == AESTYPE_EVENTS )
          sTemp = getCatStr("aes","toomuchevents1");
        else
          sTemp = getCatStr("sc","toomuchalert1");
        strreplace(sTemp, "\uA7", noOfDpes);
        strreplace(sTemp, "\uB0", g_asMaxDpeToDisplay);
      }
      else
      {
        if( screenType == AESTYPE_EVENTS )
          sTemp = getCatStr("aes","toomucharchivedevents1");
        else
          sTemp = getCatStr("sc","toomucharchivedalerts1");
      }
      ChildPanelOnCentralModalReturn("vision/MessageWarning2",
        getCatStr("sc","Attention"),
        makeDynString(sTemp,
                      getCatStr("general","OK"),
                      getCatStr("sc","cancel")),
        df, ds );

      if (!df[1])
      {
        aes_stopBusy( g_tabType );
        g_asDisplayDpes = 1; // do not display, return

        if( !g_alertRow )
          aes_doStop( g_propDp );
          
        aes_displayStatus();
        

        return;
      }
      else
      {
        strreplace(sTemp,"\n"," ");
        aes_debug(getCurrentTime(),"ManNum:"+myUiNumber(),"User: "+getUserName(),sTemp,getCatStr("para","yes"));
        g_asDisplayDpes  = 2; // do display
      }
    }
  }

  // now do a QUERY-CONNECT
 
  //if (valType == 2)
  if( valType == AES_MODE_CLOSED )
  {
    string st1, st2;

    // restrict query using ack. time
    st1 = valBegin;   // convert time to string
    st2 = valEnd;     // convert time to string
    
    t=valEnd - valBegin;
    hours=period(t);
    
    hours /= AS_HIST_RANGE_SEC;

    if( g_asDisplayHours != AES_DPQUERY_CONTINUEQUERY && ( noOfDpes * hours > g_asMaxDpeHourToDisplay ) )
    {
      dyn_float  df;
      dyn_string ds;
      string     sTemp;

      if( noOfDpes != -1 )
      { 
        if( screenType == AESTYPE_EVENTS )
          sTemp = getCatStr("sc","toomuchdpehour2");
        else
          sTemp = getCatStr("sc","toomuchalerthour2");
        
//        strreplace(sTemp, "\uA7", noOfDpes * hours); //removed in message
        strreplace(sTemp, "\uB0", g_asMaxDpeHourToDisplay);
      }
      else
      { 
        if( screenType == AESTYPE_EVENTS )
          sTemp = getCatStr("aes","toomucharchivedevents1");
        else
          sTemp = getCatStr("sc","toomucharchivedalerts1");
      }

      ChildPanelOnCentralModalReturn( "vision/MessageWarning2",
                                      getCatStr("sc","Attention"),
                                      makeDynString(  sTemp,
                                                      getCatStr("general","OK"),
                                                      getCatStr("sc","cancel") ),
                                      df, ds );

      if( !df[1] )
      {
        aes_stopBusy( g_tabType );
        g_asDisplayHours=AES_DPQUERY_CANCELQUERY; // do not display, return

        if( !g_alertRow )
          aes_doStop( g_propDp );

        aes_displayStatus();

        return;
      }
      else
      {
        strreplace(sTemp,"\n"," ");
        aes_debug(getCurrentTime(),"ManNum:"+myUiNumber(),"User: "+getUserName(),sTemp,getCatStr("para","yes"));
        g_asDisplayHours=AES_DPQUERY_CONTINUEQUERY; // do display
      }
    }


    if( screenType == AESTYPE_EVENTS )
    {
      // nothing to do here
    }
    else
    {
      c_where="('_alert_hdl.._ack_time' >= \"" + st1 + "\" AND '_alert_hdl.._ack_time' <= \"" + st2 + "\")";
    }
  }    // end AES_MODE_CLOSED
  else
  {
    c_where=where;
  }

  doTimeStamp( "BEFORE QUERYCONNECT" );  

  if( ( screenType == AESTYPE_ALERTS && valType != AES_MODE_CLOSED ) ||   // suppress queryconnect in closed mode
      ( screenType == AESTYPE_EVENTS && valType == AES_MODE_OPEN ) )

  {
    // save the information which systems have been selected in the configuration in a global variable
    gds_valSystemSelections = valSystemSelections;
    if( aes_doQueryConnect(
          screenType,
          valType,
          attrList,
          from,
          c_where,
          valSystemSelections,
          valCheckAllSystems ,
          valTypeAlertSummary) )
    {

      dpSetCache( g_propDp + ".Settings.RunMode" + AES_ORIVAL, AES_RUNMODE_RUNNING );
    }
    else
    {
      aes_doStop( g_propDp );
    }

    // nur Test - setzte erst nach erfolgreichem queryconnect !!!!

    doTimeStamp( "AFTER QUERYCONNECT" );  

  }
  
  // set stop-button depending on Mode (closed mode => not visible)
  //if( valType == 2 )
  if( valType == AES_MODE_CLOSED )
  {
//      setValue( "anhalten", "enabled", false );
  }
  else
  {
//      setValue( "anhalten", "enabled", true );
  }
  
  
  g_connectId = "currentMode";
  
  //if ( valType == 1 )  // open list
  if ( valType == AES_MODE_OPEN )  // open list
  {
    g_connectId = "openMode";
    aes_stopBusy( g_tabType );
  }

  //else if ( valType == 2 ) // closed list

//**************************************************  
//************************************************** pruefe loesung fuer historical data !!! 
//  else if ( valType == AES_MODE_CLOSED || ( ( valType==AES_MODE_OPEN ) && valHistoricalData ) ) // closed list
  if ( valType == AES_MODE_CLOSED || ( ( valType==AES_MODE_OPEN ) && valHistoricalData ) ) // closed list
  {

    if(useRDBArchive())//IM 106453
    {
      for(int i = dynlen(attrList); i > 0; i--)
      {
        if(attrList[i] == "_alert_hdl.._help")
        {
          aes_updateReferenceIndexes(i);
          dynRemove(attrList, i);
        }
        else if(attrList[i] == "_original.._status")
        {
          aes_updateReferenceIndexes(i);		
          dynRemove(attrList, i);
        }
      }
    }
    
    if( aes_doDpQuery(
      screenType,
      valType,
      valBegin,
      valEnd,
      attrList,
      from,
      where,                // PRUEFE was c_where bedeutet - siehe doDpConnect()
      valSystemSelections,
      valCheckAllSystems,
      valHistoricalData,
      valCameWentSort,
      action,
      valTypeAlertSummary) )
    {
      // we set this runmode only if connect was successfull
      dpSetCache( g_propDp + ".Settings.RunMode" + AES_ORIVAL, AES_RUNMODE_RUNNING );

      // in closed mode we will stop screen - no active connect
      //if( valType == AES_MODE_CLOSED )
      //{
      //  aes_doStop( g_propDp );
      //}
    }
    else
    {
      aes_stopBusy( g_tabType );
      dpSetCache( g_propDp + ".Settings.RunMode" + AES_ORIVAL, AES_RUNMODE_STOPPED );
    }
  }

  // update linecount
  aes_updateLineCount();


  // we have to refresh status, beceause a possible queryerror could stop the query
  aes_displayStatus();

  aes_createDistInfo();

  // we have to set readyvalue to force panel closing - only for print and save at automatic run !
  if( ( action == AES_ACTION_PRINT ) ||
      ( action == AES_ACTION_SAVE ) ||
      ( ( action == AES_ACTION_AUTORUN ) && g_longTest ) )
  {
    if( valType != AES_MODE_CLOSED && ( !g_longTest ) )
    {
      aes_throwError( AES_TE_PRINTSAVENOTPOS );
    }

    dpSetCache( g_propDp + ".Settings.Action" + AES_ORIVAL, AES_ACTION_READY );
  }
}

//**************************************************


/**
   Wrapper around the original aes_asGetFromWhere function. This ammends the option for filters on _add_values
  specific queries to the statements of the AES query.
   @param check at aes_asGetFromWhere
   @return nothing
 */
void aes_AV_asGetFromWhere(string &from, string &where,
                             int valState, string valShortcut, string valPrio, string valAlertText,
                             dyn_string valDpList, dyn_int valTypeSelections, int valTypeAlertSummary,    //bool valTypeAlertSummary,
                             //int valType, bool dpList = false, // old state - def param dpList nach unten
                             int valType,
                             // new
                             unsigned valOpenClosedMode,
                             unsigned valDirection,
                             unsigned valLogicalCombine,
                             bool dpList=false,
                             string sMinPrio = "",
                             dyn_string addValValue,
                             dyn_string addValCombine,
                             dyn_string addValCompare,
                             dyn_string addValIndex, 
                             dyn_string dsSelectedSystems = makeDynString(), 
                             bool bShowAllSystems = false
                             )
{
  string temp_where = "";
  int valIDX;
  
  aes_asGetFromWhere(from, where, valState, valShortcut, valPrio, valAlertText, valDpList, valTypeSelections, valTypeAlertSummary, valType,
                      // new filters 
                      valOpenClosedMode,
                      valDirection,
                      valLogicalCombine,"", sMinPrio, dsSelectedSystems, bShowAllSystems
                      );
  // Append to the originale AES filter string the additional values filters when they exist
  if (dynlen(addValValue) >= 1 &&
      dynlen(addValValue) == dynlen(addValCombine) &&
      dynlen(addValCombine) == dynlen(addValCompare) &&
      dynlen(addValCompare) == dynlen(addValIndex) &&
      dynlen(addValIndex) == dynlen(addValValue))
  {
    for (valIDX = 1; valIDX < dynlen(addValCombine); valIDX++)
    {
      temp_where = temp_where + " ('" + AES_ALERT_HDL + AES_EMPTY_DETAIL + ADD_VALUE_PREFIX + addValIndex[valIDX]
                              + "' " + addValCompare[valIDX] + " \"" + addValValue[valIDX]
                              + "\") " + addValCombine[valIDX+1]; 
    }
    valIDX = dynlen(addValCombine);
    temp_where = temp_where + " ('" + AES_ALERT_HDL + AES_EMPTY_DETAIL + ADD_VALUE_PREFIX + addValIndex[valIDX]
                            + "' " + addValCompare[valIDX] + " \"" + addValValue[valIDX] +"\")";
    
    // IM 118738 --> also changed next line --> original was: if ( "" != where )
    if ( where != "" )
    {
      if ( addValCombine[1] == "" )
        addValCombine[1] = "AND";
      
      where = where + " " + addValCombine[1] + " (" + temp_where + ")";
    }
    else
    {
      where = temp_where;
    }
  }
  else
  {
    if (dynlen(addValValue) >= 1)
    {
      // TFS 4779 - use throwError if parameters do not match 
      dyn_errClass deC_error;
      
      deC_error = makeError("_errors",PRIO_INFO,ERR_PARAM,54,getCatStr("aes","warning_avFilterMismatch"));
      throwError(deC_error);
    }
  }

  // the argument FILTERLANG must be the last in the query statement
  if( valType == AES_MODE_CURRENT )
  {
    if ( valAlertText != "" )// IM 105106  
      where += " FILTERLANG '" + getLocale(getActiveLang()) + "'";
    
    return;
  }

  if( valOpenClosedMode == AES_MODEOPCL_ALL )
  {
    // display all alerts
    if ( valAlertText != "" )// IM 105106  
      where += " FILTERLANG '" + getLocale(getActiveLang()) + "'";
    
    return;
  }
  else if ( valOpenClosedMode == AES_MODEOPCL_DIR )
  {
    string op;
    // filter for specified direction ( bool )
    if( where == "" ) op=" "; else op=" AND ";
    
    if( valDirection == AES_ALERTDIR_CAME )
    {
      where += op + "('_alert_hdl.._direction' == 1)";
    }
    else if ( valDirection ==AES_ALERTDIR_WENT )
    {
      where += op + "('_alert_hdl.._direction' == 0)";
    }
  }
  
  if ( valAlertText != "" )// IM 105106  
    where += " FILTERLANG '" + getLocale(getActiveLang()) + "'";
}

/**
  Main alert callback function. 
Create FROM and WHERE clause for SELECT statement with the given filter-criteria
Parameters:
  from (out) ... from clause
  where (out) ... where clause (starts with "AND ")
  
  valState ... 0=all alerts; 1=ackable; 2=pending; 3= 1 && 2
  valShortcut ... shortcut filter
  valPrio     ... priority filter
  valAlertText ... alertText filter
  valDpList ... dp-List filter
  valTypeSelections ... const of filter of DPE-Types which are selected
  valTypeAlertSummary ... parameter if summary alert should be shown
  valType ... 0=current, 1=open, 2=closed
  @param identifier Identifies the query
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/

aes_asGetFromWhere(string &from, string &where,
                int valState, string valShortcut, string valPrio, string valAlertText,
                dyn_string valDpList, dyn_int valTypeSelections, int valTypeAlertSummary,    //bool valTypeAlertSummary,
                //int valType, bool dpList = false, // old state - def param dpList nach unten
                int valType,
                // new
                unsigned valOpenClosedMode,
                unsigned valDirection,
                unsigned valLogicalCombine,
                bool dpList=false,  // von oben
                string sMinPrio = "",
                dyn_string dsSelectedSystems = makeDynString(),
                bool bShowAllSystems = false
                )
{
  int n;
  int ic=0;

  string operator;
  string tmp, op;
  int i_mode;
  
  // read the current mode
  aes_getPropMode(g_propDp,i_mode);
  
  // IM 112084 - expand in closed mode dpes with matching comment filter
  // a check for valLogicalCombine is not necessary as the DP description filter is always used in convertAlertTabEx2
  if ( g_configSettings[AESET_COMMENTFILTER] != "" && i_mode == AES_MODE_CLOSED)
  {
    dyn_string dps_result;
    dyn_string ds_valDpListTemp;
    int i_pos;
    
    ds_valDpListTemp = valDpList;
    
    // remove "_Config" from the DPE filter
    i_pos = dynContains(ds_valDpListTemp,"_Config");
    if(i_pos > 0)
      dynRemove(ds_valDpListTemp,i_pos);
    
    // check if any DPE filter is set
    // set wildcard filter "*" for searching matching dpes
    if(dynlen(ds_valDpListTemp) == 0)
      ds_valDpListTemp[1] = "*";

    for ( int i = 1; i <= dynlen(ds_valDpListTemp); i++ )
    {
      dyn_string dps_temp, desc_temp;
      string s_dpeFilter;
      
      s_dpeFilter = ds_valDpListTemp[i];
      
      //check if the filter contains a wildcard and a "." at the end of the filter pattern
      if(strpos(s_dpeFilter,".",0) == -1 && substr(s_dpeFilter,strlen(s_dpeFilter)-1,1) == "*")
        s_dpeFilter = s_dpeFilter + ".**";
      
      dpGetAllDescriptions(dps_temp,desc_temp,g_configSettings[AESET_COMMENTFILTER],s_dpeFilter);
      dynAppend(dps_result, dps_temp);
    }
    
    // if result of dpGetAllDescriptions contains more DPEs than a global limit use only the DPE filter for the query
    if ( dynlen(dps_result) <= g_asMaxDpeToDisplay )
    {
      for ( int i = 1; i <= dynlen(dps_result); i++ )
        dps_result[i] = dpSubStr(dps_result[i], DPSUB_DP_EL); // remove System
      
      valDpList = dps_result; // we have less than 1000 dpes use this as filter

      // add "_Config" to the DPE filter
      dynAppend(valDpList,"_Config");
      dynUnique(valDpList);
    }
  }
  
  // create FROM clause
  from = "'*'";

  // IM 118465 - save the input parameters in a global variable 
  gds_valDpList = valDpList;
  gb_showAllSystems = bShowAllSystems;

  from=aes_getQueryGroupClause( valDpList, dsSelectedSystems, bShowAllSystems);
  // create WHERE clause
  where = "";
  
  // in current-mode we have to receive all alerts and filter them out when we receive them
  // because lines may have to be removed when the state (_ackable) changes
  if ( valType != 0 )
  {
    switch ( valState )
    {
      case AES_MODECUR_ALL:       break;  // no filter, we want all alerts
      case AES_MODECUR_UNACK:     where = " ('_alert_hdl.._ackable' == 1) "; break;
      case AES_MODECUR_PEND:      where = " ('_alert_hdl.._partner' == 0) "; break;
      case AES_MODECUR_UNACKPEND: where = " ( ('_alert_hdl.._ackable' == 1) AND ('_alert_hdl.._partner' == 0) ) "; break;
      case AES_MODECUR_ACK:            where = " ( ('_alert_hdl.._ack_oblig' == 1) AND ('_alert_hdl.._ackable' == 0) ) "; break; 
      case AES_MODECUR_ACKPEND:        where = " ( ('_alert_hdl.._ack_oblig' == 1) AND ('_alert_hdl.._ackable' == 0) AND ('_alert_hdl.._partner' == 0) ) " ; break; 
      case AES_MODECUR_NOTACKABLE:     where = " ('_alert_hdl.._ack_oblig' == 0) " ; break;
      case AES_MODECUR_NOTACKABLEPEND: where = " ( ('_alert_hdl.._ack_oblig' == 0) AND ('_alert_hdl.._partner' == 0) ) " ; break; 
      case AES_MODECUR_OLDESTUNACK:    where = " ('_alert_hdl.._oldest_ack'  == 1) "; break; 
    }
  }
///////////// ACHTUNG - siehe Properties/Pruefe vierten Operator !!!!!!!!!!!
/////////////////////////////////////////////////////////// Meldetext
  if( valLogicalCombine == AES_LOGICCOMB_OR )
  {
    operator="OR ";
  }
  else if ( valLogicalCombine == AES_LOGICCOMB_AND )
  {
    operator="AND ";
  }

	if ( valShortcut  != "" )
  {
     int xx;
     dyn_string dsSplit;
     dsSplit = strsplit(valShortcut,",");

     if (dynlen(dsSplit) == 1)
       tmp += "('_alert_hdl.._abbr' LIKE \"" + valShortcut + "\")";
     else
     {
       for (xx=1; xx<=dynlen(dsSplit); xx++)
       {
         strreplace(dsSplit[xx]," ","");
         if (xx == 1)
           tmp += "(('_alert_hdl.._abbr' LIKE \"" + dsSplit[xx] + "\")";
         else
           tmp += " OR ('_alert_hdl.._abbr' LIKE \"" + dsSplit[xx] + "\")"; 
       }
       tmp += ")"; 
     }
  }

  // pruefe "IN RANGE" => prio wurde nach zahl geaendert / keine Bereichsangaben mehr moeglich / ACHTUNG string !
  if( tmp != "" )op=operator;else op=" ";
  
  // PRIO
// old - ok  if( ( valPrio != "" ) && ( valPrio != "0" ) ) tmp += op + " ('_alert_hdl.._prior' IN RANGE(" + valPrio + ")) ";
  bool bValPrioUsed;
  if( valPrio != "" )
  {
    int prio;
    prio=valPrio;

    if( prio > 0 || strlen(valPrio) > 1 )
    {
      bValPrioUsed = TRUE;
      //tmp += "('_alert_hdl.._prior' >= " + valPrio + ')';
      tmp += op + " ('_alert_hdl.._prior' IN RANGE(" + valPrio + ")) ";
    }
  }
  if( sMinPrio != "" )// checks if Min Prio is used
  {
    if( sMinPrio > 0 )
    {
      if(bValPrioUsed)
        tmp += op + " AND ('_alert_hdl.._prior' >= (" + sMinPrio + ")) ";
      else
        tmp += op + " ('_alert_hdl.._prior' >= (" + sMinPrio + ")) ";
    }
  }

  if( tmp != "" )op=operator;else op=" ";
  if ( valAlertText != "" ) tmp += op + " ('_alert_hdl.._text' LIKE \"" + valAlertText + "\") ";


  //aes_debug( __FUNCTION__+"() / tmp=" + tmp, 6 );


  if( tmp != "" )
  {
    if( where == "" )
      where += " ( " + tmp + " ) ";
    else
      where += " AND ( " + tmp + " ) ";
  }
  
//////////////////////////////////////////////////////////  
//////////////////////////////////////////////////////////  
  // find out the selected types and add to "where"
  tmp="";

  for( n = 1; n <= dynlen( valTypeSelections ); n++ )
  {

    if( valTypeSelections[n] > 0 )
    {
      if( ic > 0  )
        op=" AND";
      else
        op=" ";

      tmp += op + "_ELC != \"" + valTypeSelections[n] + "\"";
      ic++;
    }
  }

  if( tmp != "" )
  {
    if( where == "" )
      where += " ( " + tmp + " ) ";
    else
      where += " AND ( " + tmp + " ) ";
  }
//////////////////////////////////////////////////////////  
//////////////////////////////////////////////////////////  
  

  if( where == "" ) op=" "; else op=" AND ";
  if( valTypeAlertSummary == AES_SUMALERTS_NO )
  {
    // display only sum alerts
    where += op + "('_alert_hdl.._sum' == 0)";
  }
  else if( valTypeAlertSummary == AES_SUMALERTS_ONLY )
  {
    // display only sum alerts
    where += op + "('_alert_hdl.._sum' == 1)";
  }
  else if( valTypeAlertSummary == AES_SUMALERTS_BOTH )
  {
    // nothing to do
  }
  else if( valTypeAlertSummary == AES_SUMALERTS_FILTERED )
  {
//     where += op + "(('_alert_hdl.._sum' == 0 && '_alert_hdl.._filter_active' == 0)||('_alert_hdl.._sum' == 1 && '_alert_hdl.._force_filter_active' == 1))";
//     where += op + "(('_alert_hdl.._sum' == 0 && '_alert_hdl.._filtered' == 0)||('_alert_hdl.._sum' == 1 && '_alert_hdl.._force_filtered' == 1))";
  }
  

//aes_debug( __FUNCTION__+"() / valPrio=" + valPrio + " where=" + where, 6 );
//////////////////// ACHTUNG - nur im MODUS OFFEN / GESCHLOSSEN 
}


/**
  Main alert callback function. 
Create FROM and WHERE clause for SELECT statement with the given filter-criteria
Parameters:
  from (out) ... from clause
  where (out) ... where clause (starts with "AND ")
  
  valDpList ... dp-List filter
  valTypeNames ... filter names (DPE-Types)
  valTypeSelections ... filter names selected (DPE-Types)
  valTypeConst ... filter constants depending on filter names
  @param identifier Identifies the query
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/

aes_esGetFromWhere(string &from, string &where,
                dyn_string valDpList, bit32 valUserbits, string valdpComment,
                dyn_int valTypeSelections, bool closedmode,
                dyn_string dsSelectedSystems, bool bShowAllSystems)
{
  int i;
  string userBit;
  int n;
  int i_mode;

  // read the current mode
  aes_getPropMode(g_propDp,i_mode);
  
  // IM 112084 - expand in closed mode dpes with matching comment filter
  // a check for valLogicalCombine is not necessary as the DP description filter is always used in convertAlertTabEx2
  if ( g_configSettings[AESET_COMMENTFILTER] != "" && i_mode == AES_MODE_CLOSED)
  {
    dyn_string dps_result;
    dyn_string ds_valDpListTemp;
    int i_pos;
    
    ds_valDpListTemp = valDpList;
    
    // remove "_Config" from the DPE filter
    i_pos = dynContains(ds_valDpListTemp,"_Config");
    if(i_pos > 0)
      dynRemove(ds_valDpListTemp,i_pos);
    
    // check if any DPE filter is set
    // set wildcard filter "*" for searching matching dpes
    if(dynlen(ds_valDpListTemp) == 0)
      ds_valDpListTemp[1] = "*";

    for ( int i = 1; i <= dynlen(ds_valDpListTemp); i++ )
    {
      dyn_string dps_temp, desc_temp;
      string s_dpeFilter;
      
      s_dpeFilter = ds_valDpListTemp[i];
      
      //check if the filter contains a wildcard and a "." at the end of the filter pattern
      if(strpos(s_dpeFilter,".",0) == -1 && substr(s_dpeFilter,strlen(s_dpeFilter)-1,1) == "*")
        s_dpeFilter = s_dpeFilter + ".**";

      dpGetAllDescriptions(dps_temp, desc_temp, g_configSettings[AESET_COMMENTFILTER], s_dpeFilter); // read commentfilter from configSetting
      dynAppend(dps_result, dps_temp);
    }
   
    // if result of dpGetAllDescriptions contains more DPEs than a global limit use only the DPE filter for the query
    if ( dynlen(dps_result) <= g_asMaxDpeToDisplay )
    {
      for ( int i = 1; i <= dynlen(dps_result); i++ )
        dps_result[i] = dpSubStr(dps_result[i], DPSUB_DP_EL); // remove System
      
      valDpList = dps_result;

      // add "_Config" to the DPE filter
      dynAppend(valDpList,"_Config");
      dynUnique(valDpList);
    }
  }
  
  // create FROM clause
  from = "'*'";

  // IM 118465 - save the input parameters in a global variable 
  gds_valDpList = valDpList;
  gb_showAllSystems = bShowAllSystems;

  from=aes_getQueryGroupClause( valDpList, dsSelectedSystems, bShowAllSystems );

  // create WHERE clause
  where = "";
  

  for (i = 24; i <= 31; i++)
  {
    if (getBit(valUserbits,i))
    {
      userBit = userBit + "AND '_offline.._userbit"+(i-23)+"'";
    }
  }

  if ( userBit != "" )
  {
    if ( where != "" )
    {
      where += "AND " + userBit;
    }  
    else
    {
      where = userBit;
    }
  }
  // find out the selected types and add to "where"
  for( n = 1; n <= dynlen( valTypeSelections ); n++ )
  {
    if( valTypeSelections[n] )
      where += "AND _ELC != \"" + valTypeSelections[n] + "\"";
  }
}


string aes_getQueryGroupClause( dyn_string dpList, dyn_string dsSelectedSystems, bool bShowAllSystems )
{
  string res="", groupName;
  dyn_string dsGroup, dsDpe, pmList;
  int n,l;
  bool group=false;
  
  if ( bShowAllSystems )
  {
    dyn_string ds;
    dyn_uint di;
    getSystemNames(ds, di);
    dsSelectedSystems = ds;
  }
  

  l=dynlen(dpList);
  if( l <= 0 )
  {
    // retrieves better queryperformance than "'{}'" !!!
    res="'{*}'";
    return res;
  }


  // seperate groups and dpes
  for( n=1; n<=l; n++ )
  {
    string item=dpList[n];
    if (strlen(item)>0 && item[0]=='!') continue; // exclude all the "negative selections" in the queries
    if (item=="_Config") continue; // exclude the dummy dp added by IM 63247
    
    if( strpos( dpList[n], AES_GROUPIDF ) >= 0 )
    {
      // append group item
      dynAppend( dsGroup, dpList[n] );
    }
    else if( strpos( dpList[n], AES_PLANTMODELIDF ) >= 0 )
    {
      // CNS resolving DPEs from cns view
      string sTempTrim = dpList[n];
      uniStrReplace(sTempTrim,AES_PLANTMODELIDF,"");
      
      cnsGetIdSet(sTempTrim+"*",cnsSubStr(sTempTrim,CNSSUB_VIEW | CNSSUB_SYS),CNS_SEARCH_ALL_NAMES, CNS_SEARCH_ALL_LANGUAGES, CNS_SEARCH_ALL_TYPES, pmList);      
      
      if (cns_viewExists(cnsSubStr(sTempTrim,CNSSUB_VIEW | CNSSUB_SYS)) && dynlen(pmList) <=0)
      {
        string sWarning = getCatStr("aes","error_noDPE");

        string propName;
        aes_getConfig( g_propDp, propName );        
        strreplace(sWarning,"%1", propName);        
        strreplace(sWarning,"%2",dpList[n]);
        
        throwError(makeError("", PRIO_INFO, ERR_DP_NOT_EXISTS, 0, sWarning));        
      }      
      
      dynAppend( dsDpe, pmList);
    }
    else
    {
      // append dpe item
      dynAppend( dsDpe, dpList[n] );
    }
  }

  if( (dynlen(dsGroup)==0 ) && ( dynlen(dsDpe)==0 ) )
  {
    res="'{*}'";
    return res;
  }

  res="'{";

  //dp groups
  l=dynlen( dsGroup );
  if( l > 0 )
  {
    group=true;
    
    for( n=1; n<=l; n++ )
    {
      groupName=dsGroup[n];

      strreplace( groupName, AES_GROUPIDF, "" );
      groupName=groupNameToDpName( groupName );
    
      //the group names can be used in any case
      groupName = dpSubStr(groupName, DPSUB_DP);//IM 111089
      res += ( (n==1)?"":"," ) + "DPGROUP(" + groupName + ")";
    }
  } 
  //dpes
  l=dynlen( dsDpe );
  if( l > 0 )
  {
    for( n=1; n<=l; n++ )
    {
      res += ( ( (n==1)&&(!group) )?"":"," ) + dsDpe[n];
    }
  }

  // close command parenthesis
  res += "}'";
 DebugN("Res " + res);
  return res;
}


void aes_getTableColumnName( const int visColIdx, string &colName )
{
  int l, n;
  int screenType;
  bool visCol;
  dyn_dyn_anytype ddaCol;

  int visCount=0;
  bool found=false;

  aes_getScreenType( g_propDp, screenType );

  aes_getColumnObject( screenType, ddaCol );

  l=dynlen(ddaCol);

  for( n=1; n <= l; n++ )
  {
    visCol=ddaCol[n][CHK_VISIBLE];
    if( visCol )
    {
      visCount++;
      if( visColIdx == visCount )
      {
        found=true;
        break;
      }
    }
  }

  if( found )
  {
    colName=ddaCol[n][TE_NAME];
  }
  else
  {
    colName="";
  }
}


void aes_getTableIndex( const int screenType, const string &pattern, int &visCount )
{
  int l, n;
  bool visCol;
  string name;
  dyn_dyn_anytype ddaCol;
  bool found=false;

  // attention - columnindexes start at position one ( see configMatrix ), even if tablecolumn starts at 0
  visCount=1;

  aes_getColumnObject( screenType, ddaCol );

  l=dynlen(ddaCol);

  // traverse all columns, but treat only the visible ones
  for( n=1; n <= l; n++ )
  {
    name=ddaCol[n][TE_NAME];
    visCol=ddaCol[n][CHK_VISIBLE];
    if( visCol )
    {
      // search column names e.g. _dpid_, _time_, _count_
      if( name == pattern )
      {
       found = true;
       break;
      }
      visCount++;
    }
  }

  if( ! found )
  {
    visCount=0;
  }
}


void aes_createTableCommands( const int screenType, const int tableMode, string &cmdString )
{

  string command;
  string colName;

  int colCount;

  string keyCol_dpid  =_DPID_;
  string keyCol_time  =_TIME_;
  string keyCol_count =_COUNT_;
  string keyCol_xtab  ="xtab[";
  
  const string _SK="\"";
  string _KM=",";
  int keyCount;
  int n;
  shape tableShape;

  bool useFontProp;
  dyn_dyn_anytype ddaCol;
  bool colVis;
  int lastVisCol;
  int colVisCount=1;

  // we need the real column index of the key columns / they can have an arbitrary position
  int dpidIdx;
  int timeIdx;
  int countIdx;
  aes_getTableIndex( screenType, _DPID_, dpidIdx );
  aes_getTableIndex( screenType, _TIME_, timeIdx );
  aes_getTableIndex( screenType, _COUNT_, countIdx );

  // for workCB
  g_dpidIdx=dpidIdx;
  g_timeIdx=timeIdx;
  g_countIdx=countIdx;

  aes_getColumnObject( screenType, ddaCol );
  
  if( screenType == AESTYPE_EVENTS )
  {
    useFontProp=false;
  }
  else
  {
    useFontProp=aes_getTableSettingsValue(screenType, CHK_USEAFONTPROP );
  }

  g_useFontProp=useFontProp;  // info for workCB

  // init part of set value e.g. setValue("tab_top","updateLines",
  // dyn_int fontAttr from outside !
  command="main( dyn_dyn_anytype &xtab, dyn_int &diFontAttr ){";    

  // tablcommand index counter
  if( screenType == AESTYPE_EVENTS )
  {
    keyCount=2;
  }
  else
  {
    keyCount=3;
  }

  if( tableMode == AES_TABLECMD_UPDATE )
  {
    command+="this.updateLines(";
  }
  else if ( tableMode == AES_TABLECMD_APPEND )
  {
    command+="this.appendLines(";
  }
  else if ( tableMode == AES_TABLECMD_DELETE )
  {
    command+= "this.deleteLines(" + keyCount + _KM +
              _SK+keyCol_dpid+_SK+_KM+keyCol_xtab+ dpidIdx + "]"+_KM+
              _SK+keyCol_time+_SK+_KM+keyCol_xtab+ timeIdx + "]";

    if( screenType == AESTYPE_EVENTS )
    {
    }
    else
    {
      command+=_KM+_SK+keyCol_count+_SK+_KM+keyCol_xtab+ countIdx + "]";
    }

    command=command+");}";

    // in the delete case we can leave now
    cmdString=command;
    return;
  }

  // keypart of update lines 3, "dpid", xtab[x], "time", xtab[y], "count", xtab[z],
  // the first three columns where predefinded
  if( tableMode == AES_TABLECMD_UPDATE )
  {
    // numbers of following key columns
    command+=keyCount+_KM;

    // add key columns - only for update
    command+= _SK+keyCol_dpid+_SK+_KM+keyCol_xtab+ dpidIdx + "]"+_KM+
              _SK+keyCol_time+_SK+_KM+keyCol_xtab+ timeIdx + "]"+_KM;
   
    // the third index will only be used for type alerts/alertrow
    if( screenType == AESTYPE_EVENTS )
    {
      // nothing to do
    }
    else
    {
      command+=_SK+keyCol_count+_SK+_KM+keyCol_xtab+ countIdx + "]"+_KM;
    }
  }
  else if ( tableMode == AES_TABLECMD_APPEND )
  {
    // in the append case, number is amount of affected lines
    command+="dynlen(xtab[1]),";
  }

  // now we have to add all data columns ( column name / values pair ) - for append and update
  colCount=dynlen(ddaCol);

  // if we are using the fontproperties - insert a param pair as follows
  // 0 - to indicate fontprop and a dyn_int type for the fontappearance
  if( useFontProp )
  {
    command=command+"0,diFontAttr,";
  }

  // determine last max. visible column position
  for( n=1; n <= colCount; n++ )
  {
    colVis=ddaCol[n][CHK_VISIBLE];
    if( colVis )lastVisCol=n;
  }

// ***************************************** now in aes_createConfigMatrix() im61072
//  dynClear( g_colNames );
  
  // dynamic update column part
  for( n=1; n <= colCount; n++ )
  {
    aes_debug("ddaCol["+n+"]="+ddaCol[n]);
    colName=ddaCol[n][TE_NAME];
    colVis=ddaCol[n][CHK_VISIBLE];

    aes_debug("############# colCount="+colCount+" n="+n+" colName="+colName+ " visible="+colVis );

    // only a visible column will be added to the command string
    if( colVis ) 
    {
      command=command+_SK+colName+_SK+_KM;

      // suppress comma at last column
      _KM= ( n == lastVisCol )?"":",";
      command=command+"xtab["+ colVisCount +"]"+_KM;
      colVisCount++;

      // for workCB
// ***************************************** now in aes_createConfigMatrix() im61072
//      dynAppend( g_colNames, colName );

    }
  }

  // script termination
  command=command+");}";

  cmdString=command;
}


void aes_getVisibleColumnList( int screenType, dyn_string &colNames, dyn_string &colTitles, bool validNameFilter=false, bool configPanel=false )
{
  const int d=5;
  int count, j, i, width;
  bool vis;
  dyn_string tcolNames, tcolTitles;
  dyn_dyn_anytype dda;
  
  aes_debug( __FUNCTION__ + "() / screenType=" + screenType, d );

	if (g_alertRow && screenType == AESTYPE_EVENTS)
	  return;
  // if we were in config panel mode-we have to reload data from db
  if( configPanel )
  {
    // we have to build column information structure (ddaRes) from vst object
    dynClear( ddaRes );

    // we only want to load necessary screentype configuration / performance
    if( screenType != AESTYPE_ALERTS )
      ddaRes[1]="dummy";

    // we only need the specified screen type / pruefen //
    aes_buildColumnStruct( screenType );
  }

  dda=ddaRes[screenType];

  count=dynlen(dda);

  j = 0; 
  for (i = 1; i <= count; i++)
  {

    vis = dda[i][CHK_VISIBLE];
    width= dda[i][TE_SCREENWIDTH];

    if ( ( !vis ) || ( width <= 0 ) )   /// pruefe ob auch spalten mit width 0 unterdrueckt werden
    {
      continue;
    }

    j++;
    tcolNames[j] = dda[i][TE_NAME];

    // problem offen - langtexte sind nur pro sprache eindeutig / bei fallback
    // muss vermischung geprueft werden !!!!!!!!!!!!!!
    tcolTitles[j] = aes_getStringFromLangString( dda[i][LT_HEADERNAME] );
  }

//DebugN(__FUNCTION__+"() / tcolNames before=" + tcolNames );

  if( validNameFilter )
  {
    aes_filterSLItems( tcolTitles, tcolNames, colTitles, colNames );
  }
  else
  {
    colNames=tcolNames;
    colTitles=tcolTitles;
  }

}


void aes_prepareOldScreenVariables( 
  const int screenType,
  dyn_string &typeFilter,
  dyn_int &typeConst )
{
  if( screenType == AESTYPE_EVENTS )
  {
    typeFilter=ES_TYPEFILTER;
    typeConst=ES_TYPECONST;
  }
  else
  {
    typeFilter=AS_TYPEFILTER;
    typeConst=AS_TYPECONST;
  }

}


void aes_createConfigMatrix( const int screenType, dyn_dyn_anytype &configMatrixOrig )
{
  int i, n, l, ic=0;

  dyn_dyn_anytype ddaCol;
  bool useFontProp=false;

  string onClick;
  string func, errFunc;
  string attrib;
  int valueType;
  bool visible;
  bool apiFuncErr, pvssFuncErr;
  dyn_string attributes, dsDummy;
  dyn_string dsAPIFuncs, dsPVSSFuncs;
  string colName;
  dyn_dyn_anytype configMatrix;

  // get list of all defined api/pvss functions
  dsAPIFuncs  =aec_getAllPureFuncItems( screenType, g_alertRow, true, AEC_FT_EXT );
  dsPVSSFuncs =aec_getAllPureFuncItems( screenType, g_alertRow, true, AEC_FT_SPEC );

  aes_getColumnObject( screenType, ddaCol );

  l=dynlen( ddaCol );

  //////// main column loop
  /////////////////////////

  //im61072 - was in aes_createTableCommands()
  dynClear( g_colNames );

  // traversing all columns
  for( n=1; n <= l; n++ )
  {
    visible=false;
    dynClear( attributes );
    
    colName   =ddaCol[n][TE_NAME];
    onClick   =ddaCol[n][CB_ONCLICK];
    func      =ddaCol[n][CB_FUNCTION];
    attrib    =ddaCol[n][CB_ATTRIBUTE];
    valueType =ddaCol[n][RB_VALUETYPE];
    visible   =ddaCol[n][CHK_VISIBLE];
    attributes=ddaCol[n][SL_ARGUMENTS];
    
    g_dsWorkAttr[n] = attrib;
    g_dsWorkName[n] = colName;
    g_dsWorkVsbl[n] = visible;
    
    errFunc=func;

    // new - for dynamic handling
    onClick =aes_getPureFunctionName( onClick );
    func=aes_getPureFunctionName( ddaCol[n][CB_FUNCTION] );

    apiFuncErr=false;
    pvssFuncErr=false;

    // append config item only if column is visible !
    if( visible )
    {
      // important - internal counter for config matrix index
      ic++;

      // traversing the configurations
      for( i=1; i < CFG_LAST; i++ )
      {
        anytype aVal;
        dynClear( dsDummy );

        switch( i )
        {
          case CFG_ATTRINDEX:
            { 
              aVal=makeDynInt();
              //  pruefe ob auch fuer alle onClick richtig && bei writeFormatString empty dyn_string 
              aVal=(dyn_int)aes_getAttrIndexList( onClick, valueType, func, attrib, attributes, screenType, dsDummy );
            }
            break;


          case CFG_VALTYPE:

            // if function name like writeFormatString or valueType like dpGetSubStr - valueType==VT_DPA

            // the last two exceptions
            if( func == AECSF_WRITEFSTR || valueType == VT_SUBSTR )
            {
              aVal=(int)VT_DPA;            
            }
            else
            {  
              if( valueType == VT_FUNCTION )
              {
                // if value type == API function / check whether it exists
                if( dynContains( dsAPIFuncs, func ) <= 0 )
                {
                  apiFuncErr=true;
                  aVal=VT_DPA;
                  func=AECSF_WRITEFSTR;
                  aes_throwError( AES_TE_UNDEFFUNCTION, PRIO_WARNING, errFunc);
                }
                else
                  aVal=valueType;
              }
              else if( valueType == VT_SPECIAL )
              {
                // if value type == PVSS function / check whether it exists
                if( dynContains( dsPVSSFuncs, func ) <= 0 )
                {
                  pvssFuncErr=true;
                  aVal=VT_DPA;
                  func=AECSF_WRITEFSTR;
                  aes_throwError( AES_TE_UNDEFFUNCTION, PRIO_WARNING, errFunc );
                }
                else
                  aVal=valueType;
              }
              else
              {
                aVal=valueType;
              }
            }
            break;


          case CFG_FORMATSTR:
            aVal=(string)"";
            
            // new - dynamic
            if( apiFuncErr || pvssFuncErr )
            {
              string ttt;
              ttt=aes_getCatStr( "mid_undefFunction" ) + errFunc;
              aVal=ttt;
            }
            else
            {
              aVal=aes_getStringFromLangString( ddaCol[n][LT_MULTILANGFORMAT] );
            }
            break;


          case CFG_MILLISEC:
            aVal=(bool)false;
            aVal=ddaCol[n][CHK_MILLISEC];
            break;


          case CFG_FUNCTION:
            // exception 1) if onClick function is defined - use onClick funcName for function
            aVal=(string)"";
            // last exception for writeformatstring because its not really a function for convertalertTab
            if( ( func != "" ) && ( func != AECSF_WRITEFSTR ) )
            {
              aVal=func;
            }
            else
            {
              aVal="";
            }
            break;


          case CFG_USEFORECOLOR:
            aVal=(bool)false;
            {
              if( screenType == AESTYPE_ALERTS )
              {
                aVal=(bool)ddaCol[n][CHK_USEACFORECOL];
              }
              else
              {
                aVal=false;
              }
            }
            break;


          case CFG_USEBACKCOLOR:
            aVal=(bool)false;
            {
              if( screenType == AESTYPE_ALERTS )
              {
                aVal=(bool)ddaCol[n][CHK_USEACBACKCOL];
              }
              else
              {
                aVal=false;
              }
            }
            break;


          case CFG_SUBSTRPTR:
            //---l
            //  Fehler - warte auf convertAlertTabEx2 if value type like substr - we have to convert the attribute
            aVal=(int)0;
            if( valueType == VT_SUBSTR )
            {
              aVal=(unsigned)aec_convertSubStr2Int( attrib );
            }
            break;

          default:
            aes_debug( __FUNCTION__+"() / Defaultstatement reached !" );

        }

        configMatrix[ic][i]=aVal;
      } // end config loop

      //im61072 - was in aes_createTableCommands()
      //dynAppend( g_colNames, colName );
//DebugN( "colName(" + ic + ")=" + colName );      
      g_colNames[ic]=colName;

    } // visible check

  } // end column loop
  //
  // IM 109086, IM 110452, IM 106289 - moved because it should be done ONCE every table and not every CB
  // 2013-06-21 Stoklasek
  //
  
  //IM 117712 dspitzer 22.04.2015: When exchanging column positions, the format has not been reset. This is done here
  for(i = 0; i < this.columnCount(); i++)
    this.columnFormat(this.columnToName(i), "");
  
  dyn_int diColumnVTime, diColumnAckTime;
  dyn_bool dbFormatVTimeMS, dbFormatAckTimeMS;
  dyn_string dsFormatVTime, dsFormatAckTime, dsColumnToNameVTime, dsColumnToNameAckTime, dsVsbl;
  
  dsVsbl = g_dsWorkAttr;
  
  if ( screenType != AESTYPE_EVENTS && screenType != AESTYPE_ALERTR )
  {
    // get visible columns - remove invisble columns for right index    
    for ( int i = dynlen(dsVsbl); i >= 1; i-- )
      if ( g_dsWorkVsbl[i] == "FALSE" )
        dynRemove(dsVsbl, i);
    
    // get all columns with attribute __V_time (but not the column named __V_time) or _alert_hdl.._ack_time
    for ( int i = 1; i <= dynlen(dsVsbl); i++ )
    {
      if ( dsVsbl[i] == "__V_time" && this.columnToName(i-1) != "__V_time" )
        dynAppend(diColumnVTime, i);
      if ( dsVsbl[i] == "_alert_hdl.._ack_time" )
        dynAppend(diColumnAckTime, i);
    }
    
    // save format for columns into dyn_strings
    for ( int i = 1; i <= dynlen(diColumnVTime); i++ )
    {
      dynAppend(dsColumnToNameVTime, this.columnToName(diColumnVTime[i]-1));
      dsFormatVTime[i] = configMatrix[diColumnVTime[i]][3];
      dbFormatVTimeMS[i] = configMatrix[diColumnVTime[i]][4];
    }
    for ( int i = 1; i <= dynlen(diColumnAckTime); i++ )
    {
      dynAppend(dsColumnToNameAckTime, this.columnToName(diColumnAckTime[i]-1));
      dsFormatAckTime[i] = configMatrix[diColumnAckTime[i]][3];
      dbFormatAckTimeMS[i] = configMatrix[diColumnAckTime[i]][4];
    }
    // remove format for columns (milli seconds included)
    for ( int i = 1; i <= dynlen(diColumnVTime); i++ )
    {
      if ( configMatrix[diColumnVTime[i]][3] != "" ) configMatrix[diColumnVTime[i]][3] = "";
      if ( configMatrix[diColumnVTime[i]][4] != 0 )  configMatrix[diColumnVTime[i]][4] = 0;
    }
    for ( int i = 1; i <= dynlen(diColumnAckTime); i++ )
    {
      if ( configMatrix[diColumnAckTime[i]][3] != "" ) configMatrix[diColumnAckTime[i]][3] = "";
      if ( configMatrix[diColumnAckTime[i]][4] != 0 )  configMatrix[diColumnAckTime[i]][4] = 0;
    }
  }
  
  // IM 106289 - set saved format for __V_time and _alert_hdl.._ack_time
  if ( screenType != AESTYPE_EVENTS && screenType != AESTYPE_ALERTR )
  {
    if ( dynlen(diColumnVTime) == dynlen(dsColumnToNameVTime) && dynlen(diColumnVTime) == dynlen(dsFormatVTime) )
      for ( int i = 1; i <= dynlen(dsColumnToNameVTime); i++)
        this.columnFormat(dsColumnToNameVTime[i], "["+dsFormatVTime[i]+"t,true,False,ALIGNMENT_BEGINNING,False]");
    if ( dynlen(diColumnAckTime) == dynlen(dsColumnToNameAckTime) && dynlen(diColumnAckTime) == dynlen(dsFormatAckTime) )
      for ( int i = 1; i <= dynlen(dsColumnToNameAckTime); i++)
        this.columnFormat(dsColumnToNameAckTime[i], "["+dsFormatAckTime[i]+"t,true,False,ALIGNMENT_BEGINNING,False]");    
  }
 
  configMatrixOrig=configMatrix;  // store in global matrix
   
  //initialize function for user depending alarm display IM #117931
  if((screenType == AESTYPE_ALERTS) || (screenType == AESTYPE_ALERTR))//do it for alert screen or alert row
    if(isFunctionDefined("aes_interfaceSetupSettings"))
      aes_interfaceSetupSettings(g_configMatrix);
}


void aes_createSettings( 
  dyn_anytype &settings,
  int screenType,
  int mode,
  unsigned alertState,
  string commentFilter,
  bool multiLineSuppress,
  string backCol,
  string foreCol,
  dyn_string dsBLEComment,
  dyn_string dsDPEList,
  bool bULC = false )
{
  bool useFontProp;
  string screenFont;
  string printoutFont;
  dyn_string dsTmp;
  dyn_string dsPos, dsNeg;
  string sTmp;
  int i,l;

  dynClear( settings );
  
  if ( !bULC )
  {
    if( screenType == AESTYPE_EVENTS )
    {
      useFontProp=false;
    }
    else
    {
      useFontProp=aes_getTableSettingsValue( screenType, CHK_USEAFONTPROP );
    }
    screenFont=aes_getTableSettingsValue( screenType, TE_SCREENFONT );
    printoutFont=aes_getTableSettingsValue( screenType, TE_PRINTFONT );

    if( screenType == AESTYPE_EVENTS )
    {
      // explicitly set values - not possible at events
      useFontProp=false;
    }
  }

  settings[ AESET_SCREENTYPE ]      = screenType;
  settings[ AESET_COMMENTFILTER ]   = commentFilter;     // pruefe / von properties
  settings[ AESET_SCREENFONT ]      = screenFont;
  settings[ AESET_PRINTOUTFONT ]    = printoutFont;

//  settings[ AESET_SHOWINTERNALS ]=g_showInternals;

  if ( !bULC )
  {
    if( screenType == AESTYPE_ALERTS )
    {
      if( g_alertRow )
      {
        settings[ AESET_SHOWINTERNALS ]=g_showInternalsAR;
      }
      else
      {
        settings[ AESET_SHOWINTERNALS ]=g_showInternalsA;
      }
    }
    else
    {
      settings[ AESET_SHOWINTERNALS ]=g_showInternalsE;
    }
  }

//DebugN( "settings[]         =" + settings[ AESET_SHOWINTERNALS ] );
//DebugN( "createSettings(A)  =" + g_showInternalsA );
//DebugN( "createSettings(AR) =" + g_showInternalsAR );
//DebugN( "createSettings(E)  =" + g_showInternalsE );

  settings[ AESET_BACKCOL ]         = backCol;   // see init section
  settings[ AESET_FORECOL ]         = foreCol;   // see init section

  l=dynlen( dsBLEComment );
  
  // check if a filter for an alert comment is set
  if(dynlen(dsBLEComment) > 0)
    gb_useBLEComment = 1;
  else
    gb_useBLEComment = 0;
  
  for( i=1; i <=l; i++ )
  {
    sTmp=dsBLEComment[i];
    if( strpos( sTmp, "!" ) != 0 )  // first position
    {
      dynAppend( dsPos, sTmp );
    }
    else
    {
      sTmp=strltrim( sTmp, "!" );
      dynAppend( dsNeg, sTmp );
    }
  }

  settings[ AESET_BLECOMMENT_POS]   = dsPos;   // new - BLE
  settings[ AESET_BLECOMMENT_NEG]   = dsNeg;   // new - BLE

  aes_debug(__FUNCTION__+"() / OneRowPerAlert=" + multiLineSuppress );

  if ( screenType == AESTYPE_ALERTS )
  {
    settings[ AESET_CURRENT_MODE ]    = (mode==AES_MODE_CURRENT) ? true : false;
    settings[ AESET_USEFONTPROP ]     = useFontProp;
    settings[ AESET_ALERTSTATE ]      = alertState;         // from properties
    settings[ AESET_MULTILSUPPRES ]   = multiLineSuppress;  // from properties
  }
  else if ( screenType == AESTYPE_EVENTS )
  {
    // the following settings were hardcoded because they are not possible at events
    settings[ AESET_CURRENT_MODE ]    = false;
    settings[ AESET_USEFONTPROP ]     = false;
    settings[ AESET_ALERTSTATE ]      = (unsigned)0;
    settings[ AESET_MULTILSUPPRES ]   = false;
  }
  else
  {
    aes_debug(__FUNCTION__+"() / Unknown screenType="+screenType+" !" );
  }

// negative filter on DPEs
  l=dynlen( dsDPEList );
  dyn_string dpeNeg;
  for( i=1; i <=l; i++ )
  {
    string dpe=dsDPEList[i];
    if (dpe[0] != '!') continue;
    dpe=strltrim(dpe,"!");
    dynAppend(dpeNeg,dpe);
  }
  settings[AESET_DPELIST_NEG]     = dpeNeg;
  
  //config entry of idependent alarm acknowledgement
  g_iIndependentAcknowledge = paCfgReadValueDflt(PROJ_PATH+CONFIG_REL_PATH+"config", "general", "independentAlertAck", 0);
}

//#################################
//#################################


/**@name Menufunctionblock*/
//@{

/**
  Main initialisation routine. 
  @param none
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/
void aes_initMenu()
{
  dyn_dyn_string ddsMenu;
  int c=1;
  int pos=1;

  int first, last;

int n;

first=c;
  AES_MNUA_ALERTS=c++;
  AES_MNUA_ACK=c++;
  AES_MNUA_ACKALLVISIBLE=c++;
  AES_MNUA_INSCOMMENT=c++;
  AES_MNUA_PROCPANEL=c++;
  // IM 105602
  AES_MNUA_PROCPANEL_NEW_WINDOW=c++;
  AES_MNUA_PROCPANEL_MODULE=c++;
  AES_MNUA_TREND=c++;
  AES_MNUA_DETAILS=c++;
  AES_MNUA_SUMALERTDETAILS=c++;
  AES_MNUA_DISPHELPINFO=c++;
  AES_MNUA_PROPERTIES=c++;
  AES_MNUA_CHANGEALERTCLASS=c++;
  AES_MNUA_EXIT=c++;

  AES_MNUE_EVENTS=c++;
  AES_MNUE_INSCOMMENT=c++;
  AES_MNUE_PROCPANEL=c++;
  AES_MNUE_TREND=c++;
  AES_MNUE_DETAILS=c++;
last=c;

//////////////////
//////////////////

  ddsMenu[AES_MNUA_ALERTS][pos]               ="mnua_alerts";
  ddsMenu[AES_MNUA_ACK][pos]                  ="mnua_ack";
  ddsMenu[AES_MNUA_ACKALLVISIBLE][pos]        ="mnua_ackAllVis";
  ddsMenu[AES_MNUA_INSCOMMENT][pos]           ="mnua_insComment";
  ddsMenu[AES_MNUA_PROCPANEL][pos]            ="mnua_procPanel";
  // IM 105602
  ddsMenu[AES_MNUA_PROCPANEL_NEW_WINDOW][pos] ="mnua_procPanel_newWindow";
  ddsMenu[AES_MNUA_PROCPANEL_MODULE][pos]     ="mnua_procPanel_module";
  ddsMenu[AES_MNUA_TREND][pos]                ="mnua_trend";
  ddsMenu[AES_MNUA_DETAILS][pos]              ="mnua_details";
  ddsMenu[AES_MNUA_SUMALERTDETAILS][pos]      ="mnua_sumAlertDetails";
  ddsMenu[AES_MNUA_DISPHELPINFO][pos]         ="mnua_dispHelpInfo";
  ddsMenu[AES_MNUA_PROPERTIES][pos]           ="mnua_properties";
  ddsMenu[AES_MNUA_CHANGEALERTCLASS][pos]     ="mnua_changealertclass";
  ddsMenu[AES_MNUA_EXIT][pos]                 ="mnua_exit";

  ddsMenu[AES_MNUE_EVENTS][pos]               ="mnue_events";
  ddsMenu[AES_MNUE_INSCOMMENT][pos]           ="mnue_insComment";
  ddsMenu[AES_MNUE_PROCPANEL][pos]            ="mnue_procPanel";
  ddsMenu[AES_MNUE_TREND][pos]                ="mnue_trend";
  ddsMenu[AES_MNUE_DETAILS][pos]              ="mnue_details";


  // complete dyn_dyn_string with catalogue values
  aes_getCatNames( ddsMenu, first, last );

  aes_createPopUpMenu( ddsMenu );

}


void aes_getCatNames( dyn_dyn_string &dds, const int first=0, const int last=0 )
{
  int n, l;
  const int keyPos=1;
  const int catPos=2;

  if( last == 0 )
  {
    first=1;
    last=dynlen(dds) + 1;
  }


  for( n=first; n < last; n++ )
  {
    dds[n][catPos]=aes_getCatStr( dds[n][keyPos] );
  }
}


void aes_createPopUpMenu( const dyn_dyn_string &ddsm )
{
  const int cc=2; // catpos

  const int ct=1, // menuType
            cn=2, // menuentryName
            ca=3, // menuAnswernumber
            cv=4; // menuVisible

  const string com=",";

  int c=1;
  int n;

  // g_ddam -> panelglobal variable / keeps all menuinformations for better performance
  dyn_anytype dam;
  dyn_string dsMenu;


  //************************************ Alerts
  //*******************************************
  firstAlertMenu=c;
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_ALERTS][cc];          dam[ca]=AES_MNUA_ALERTS;          dam[cv]=0; g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_SP;                                                                                          g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_ACK][cc];             dam[ca]=AES_MNUA_ACK;             dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_ACKALLVISIBLE][cc];   dam[ca]=AES_MNUA_ACKALLVISIBLE;   dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_SP;                                                                                          g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_INSCOMMENT][cc];      dam[ca]=AES_MNUA_INSCOMMENT;      dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  // IM 105602
  //dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_PROCPANEL][cc];       dam[ca]=AES_MNUA_PROCPANEL;       dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_TREND][cc];           dam[ca]=AES_MNUA_TREND;           dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_SP;                                                                                          g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_DETAILS][cc];         dam[ca]=AES_MNUA_DETAILS;         dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_SUMALERTDETAILS][cc]; dam[ca]=AES_MNUA_SUMALERTDETAILS; dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_DISPHELPINFO][cc];    dam[ca]=AES_MNUA_DISPHELPINFO;    dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );  
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_CHANGEALERTCLASS][cc];    dam[ca]=AES_MNUA_CHANGEALERTCLASS;    dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_SP;                                                                                          g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_PROPERTIES][cc];      dam[ca]=AES_MNUA_PROPERTIES;      dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_SP; 
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_EXIT][cc];            dam[ca]=AES_MNUA_EXIT;            dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  
  // IM 105602
  dam[ct]=MENU_CB; dam[cn]=ddsm[AES_MNUA_PROCPANEL][cc];       dam[ca]="invisible";              dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_SB; dam[cn]=ddsm[AES_MNUA_PROCPANEL][cc];       dam[ca]="invisible";                         g_ddam[c++]=dam; dynClear( dam );
  // Every screen has a mainModule_X
  for (int mNr = 1; mNr <= ptms_getNumberOfScreens(); mNr++)
  { 
    // Check if mainModule_X exists on this screen
    if( isModuleOpen( ptms_BuildModuleName( "mainModule", mNr ) ) )
    {
      dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_PROCPANEL_MODULE][cc] + " " + mNr; dam[ca]=(100 * AES_MNUA_PROCPANEL_MODULE) + mNr;   dam[cv]=mNr; g_ddam[c++]=dam; dynClear( dam );
    }
  }
  dam[ct]=MENU_SP;                                                                                          g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_PROCPANEL_NEW_WINDOW][cc];  dam[ca]=AES_MNUA_PROCPANEL_NEW_WINDOW; dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );  
  
  ////////// testentry for cascade
  //dam[ct]=MENU_CB; dam[cn]="cascade_test";                                                       dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  //dam[ct]=MENU_SB; dam[cn]="cascade_test";                                                                  g_ddam[c++]=dam; dynClear( dam );
  //dam[ct]=MENU_PB; dam[cn]="sub1";                             dam[ca]=26;                       dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  //dam[ct]=MENU_PB; dam[cn]="sub2";                             dam[ca]=27;                       dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_SP;                                                                                          g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_EXIT][cc];            dam[ca]=AES_MNUA_EXIT;            dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  lastAlertMenu=c;


  //************************************ Events
  //*******************************************
  firstEventMenu=c;
  //dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUE_EVENTS][cc];          dam[ca]=AES_MNUE_EVENTS;          dam[cv]=0; g_ddam[c++]=dam; dynClear( dam );
  //dam[ct]=MENU_SP;                                                                                          g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUE_TREND][cc];           dam[ca]=AES_MNUE_TREND;           dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_SP;                                                                                          g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUE_DETAILS][cc];         dam[ca]=AES_MNUE_DETAILS;         dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  lastEventMenu=c;
  

  //************************************ AlertRow
  //*********************************************
  firstAlertRowMenu=c;
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_ACK][cc];             dam[ca]=AES_MNUA_ACK;             dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  //dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_ACKALLVISIBLE][cc];   dam[ca]=AES_MNUA_ACKALLVISIBLE;   dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_SP;                                                                                          g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_INSCOMMENT][cc];      dam[ca]=AES_MNUA_INSCOMMENT;      dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  // IM 105602
  //dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_PROCPANEL][cc];       dam[ca]=AES_MNUA_PROCPANEL;       dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  //dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_TREND][cc];           dam[ca]=AES_MNUA_TREND;           dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_SP;                                                                                          g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_DETAILS][cc];         dam[ca]=AES_MNUA_DETAILS;         dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_SUMALERTDETAILS][cc]; dam[ca]=AES_MNUA_SUMALERTDETAILS; dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_DISPHELPINFO][cc];    dam[ca]=AES_MNUA_DISPHELPINFO;    dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_CHANGEALERTCLASS][cc];    dam[ca]=AES_MNUA_CHANGEALERTCLASS;    dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_SP;                                                                                          g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_PROPERTIES][cc];      dam[ca]=AES_MNUA_PROPERTIES;      dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  //dam[ct]=MENU_SP;                                                                                          g_ddam[c++]=dam; dynClear( dam );
  //dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_EXIT][cc];            dam[ca]=AES_MNUA_EXIT;            dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  
  // IM 105602, 115702 - added process panel entry for alert row
  dam[ct]=MENU_SP;                                                                                          g_ddam[c++]=dam; dynClear( dam );

  dam[ct]=MENU_CB; dam[cn]=ddsm[AES_MNUA_PROCPANEL][cc];       dam[ca]="invisible";              dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_SB; dam[cn]=ddsm[AES_MNUA_PROCPANEL][cc];       dam[ca]="invisible";                         g_ddam[c++]=dam; dynClear( dam );
  // Every screen has a mainModule_X
  for (int mNr = 1; mNr <= ptms_getNumberOfScreens(); mNr++)
  { 
    // Check if mainModule_X exists on this screen
    if( isModuleOpen( ptms_BuildModuleName( "mainModule", mNr ) ) )
    {
      dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_PROCPANEL_MODULE][cc] + " " + mNr; dam[ca]=(100 * AES_MNUA_PROCPANEL_MODULE) + mNr;   dam[cv]=mNr; g_ddam[c++]=dam; dynClear( dam );
    }
  }
  dam[ct]=MENU_SP;                                                                                          g_ddam[c++]=dam; dynClear( dam );
  dam[ct]=MENU_PB; dam[cn]=ddsm[AES_MNUA_PROCPANEL_NEW_WINDOW][cc];  dam[ca]=AES_MNUA_PROCPANEL_NEW_WINDOW; dam[cv]=1; g_ddam[c++]=dam; dynClear( dam );  

  
  lastAlertRowMenu=c;

}


void aes_deleteRTDps( bool modeAll=false )
{
  const int d=5;
  int i,l ;
  dyn_string ds, dsTmp;
  int pos;

  if( aec_questionDialog( AEC_QUESTIONID_DELETERTDPS ) == AES_CONF_CANCEL )
  {
    return;
  }

  if( modeAll )
  {
    bool bEvStatus, bEvStatus_2;                                              // all exceppt running UIs
    dyn_int diUiMan, diUiMan_2;
    int manId = convManIdToInt(EVENT_MAN,0);
    int manId_2 = convManIdToInt(EVENT_MAN,0,0,2);
    bool bEventConnection = isConnOpen(manId);    
    bool bEventConnection_2 = isConnOpen(manId_2);         
    if ( bEventConnection ) 
     dpGet("_Connections.Ui.ManNums:_online.._value", diUiMan); 
    if ( bEventConnection_2 ) 
     dpGet("_Connections_2.Ui.ManNums:_online.._value", diUiMan_2); 
    dynAppend(diUiMan, diUiMan_2);
    dynUnique(diUiMan); 
  
    ds=dpNames( _AES_DPTYPE_PROPERTIES + "RT*", _AES_DPTYPE_PROPERTIES );
    // *cfg dp's will be temporary created for properties dialog in aesconfig panel
    dsTmp=dpNames( _AES_DPTYPE_PROPERTIES + "Cfg*", _AES_DPTYPE_PROPERTIES );
    dynAppend( ds, dsTmp );

    for ( i = dynlen(diUiMan); i >= 1; i-- )
    {
      for ( l = dynlen(ds); l >= 1; l-- )
      {
        // IM 110616
        pos = strpos(ds[l], "RT_" + diUiMan[i] + "_");
        if ( pos > 0 )
        {
          dyn_dyn_int ddi;
          dpGet(ds[l] + ".Settings.RunCommand:_connect.._manids", ddi);
          if ( dynlen(ddi) )
          {
            //somebody is connected, do not delete
            dynRemove(ds, l); 
            continue;
          }
        }
        
        pos = strpos(ds[l], "RTRow_" + diUiMan[i] + "_");
        if ( pos > 0 )
        {
          dyn_dyn_int ddi;
          dpGet(ds[l] + ".Settings.RunCommand:_connect.._manids", ddi);
          if ( dynlen(ddi) )
          {
            //somebody is connected, do not delete
            dynRemove(ds, l); 
            continue;
          }
        }
        
        pos = strpos(ds[l], "CfgPanel_" + diUiMan[i] + "_");
        if ( pos > 0 )
        {
          dyn_dyn_int ddi;
          dpGet(ds[l] + ".Settings.RunCommand:_connect.._manids", ddi);
          if ( dynlen(ddi) )
          {
            //somebody is connected, do not delete
            dynRemove(ds, l); 
          }
        }
        // IM 110616
      }
    }
  }
  else
  {
    ds=makeDynString( g_propDpNameTop, g_propDpNameBot );
  }

  //aes_debug(__FUNCTION__+"() / Delete List=" + ds, 10 );

  l=dynlen(ds);
  if (getUserPermission(4))
  for( i=1; i<=l; i++ )
  {
    aes_debug(__FUNCTION__+"() / Delete RTDP("+i+")=" + ds[i], d );

    dpRemoveCache( ds[i] ); 
    dpDelete( ds[i] ); // really remove DP    
  }
}


void aes_panelOff( bool fromPanel=false )
{
  dyn_float df=makeDynFloat();
  dyn_string ds=makeDynString();
  // !!!!!!!!!!!!!!!!!!!!! free all resources !!!!!!!!!!!!!!!!!!!!!!!!!!
  // !!!!!!!!!!!!!!!!!!!!! free all resources !!!!!!!!!!!!!!!!!!!!!!!!!!

//  aes_deleteRTDps();

  // stop all running queries
  aes_doStop( g_propDpNameTop );
  aes_doStop( g_propDpNameBot );

  if( fromPanel )
  {
    PanelOff();
  }
  else
  {
    if( g_longTest )
    {
      // at long time test we need panelOfReturn for synchronisation
      delay( 5 );
      PanelOffReturn( df, ds );
    }
    else
    {
      PanelOff();
    }
  }
}



/**
  This function builds the menustring and displays the popup menu. 
  @param none
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/
void aes_onRightClick( const string propDp, const int tabType, const string tableName,
                       int row, int column, anytype value, mapping mTableMultipleRows,
                       dyn_int diSelectedLines = makeDynInt() )
{
  if (row < 0)  //IM 94757: no line selected -> no context menue
    return;
  
  if(dynlen(diSelectedLines) == 0)  
    dynAppend(diSelectedLines, row);
  
  int screenType;
  string content;

  unsigned runMode;

  aes_getRunMode( propDp, runMode );

  if( runMode != AES_RUNMODE_RUNNING )
  {
    if( !AES_FORCE_CLICK )
      return;
  }

  // no popup menu available for user guest
  if( !getUserPermission( AES_PERMLEVEL_MENU ) )
    return;

  setInputFocus( myModuleName(), myPanelName(), tableName );

  aes_getScreenType( propDp, screenType );

  content=mTableMultipleRows[row][_DPID_];

  if( g_alertRow )
  {
    if( aes_checkPermission( AES_PERM_ALLOWAECONFIG ) == AES_PERM_NOK )
      return;
  }


  if( ( content != "" ) || g_alertRow )
  {
    bool emptyRow = ( content == "" );

    // freeze table
    // 18.03.2016:
    // comment updatesEnabled because it is used here in a wrong way and
    // it causes some problems with stylesheets (table invisible) - IM 119748
    // this.updatesEnabled=false;

    aes_displayMenu( screenType, row, column, value, propDp, tableName, tabType, emptyRow, mTableMultipleRows, diSelectedLines );  
  }
}


/**
  This function builds the menustring and displays the popup menu. 
  @param none
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/
void aes_displayMenu( const unsigned screenType, int row, int column, anytype val, const string propDpName,
                      const string tableName, const int tabType, bool emptyRow, mapping mTableMultipleRows,
                      dyn_int diSelectedLines = makeDynInt() )  
{
  //dyn_int sumAlertList = makeDynInt ( DPEL_STRUCT, DPEL_TYPEREF,DPEL_BIT32_STRUCT,DPEL_BLOB_STRUCT, DPEL_BOOL_STRUCT,DPEL_CHAR_STRUCT,DPEL_DPID_STRUCT, DPEL_DYN_BIT32_STRUCT,DPEL_DYN_BLOB_STRUCT,DPEL_DYN_BOOL_STRUCT,DPEL_DYN_CHAR_STRUCT,DPEL_DYN_DPID_STRUCT,DPEL_DYN_FLOAT_STRUCT, DPEL_DYN_INT_STRUCT,DPEL_DYN_LANGSTRING_STRUCT,DPEL_DYN_STRING_STRUCT,DPEL_DYN_TIME_STRUCT,DPEL_DYN_UINT_STRUCT,DPEL_FLOAT_STRUCT, DPEL_INT_STRUCT,DPEL_LANGSTRING_STRUCT,DPEL_STRING_STRUCT,DPEL_UINT_STRUCT, DPEL_STRING );      

  const int d=0;

  const string com=",";
  const int cc=2; // catpos

  const int ct=1, // menuType
            cn=2, // menuentryName
            ca=3, // menuAnswernumber
            cv=4; // menuVisible


  int first, last;
  int n;
  int answer, res;
  int sepCount=1;

  bool addMenu=true;
  bool ackable;
  anytype b32;

  dyn_bool availableItems;
  bool bIsPara = FALSE;
  
  bool  title,
        ack,
        denyava,
        insertComment,
        procPanel,
        trend,
        details,
        sumDetails,
        helpInfo,
        properties,
        exit,
        changeAlertClass;

  // 20150421 - #117741 - use different settings for the AEScreen and the AESRow
  if(!g_alertRow)
    dpGetCache(makeDynString("_AESConfig.generalSettings.AESGlobalSettings.contextMenu.title:_online.._value",
                             "_AESConfig.generalSettings.AESGlobalSettings.contextMenu.ack:_online.._value",
                             "_AESConfig.generalSettings.AESGlobalSettings.contextMenu.ackAV:_online.._value",
                             "_AESConfig.generalSettings.AESGlobalSettings.contextMenu.comment:_online.._value",
                             "_AESConfig.generalSettings.AESGlobalSettings.contextMenu.panel:_online.._value",
                             "_AESConfig.generalSettings.AESGlobalSettings.contextMenu.trend:_online.._value",
                             "_AESConfig.generalSettings.AESGlobalSettings.contextMenu.details:_online.._value",
                             "_AESConfig.generalSettings.AESGlobalSettings.contextMenu.sum:_online.._value",
                             "_AESConfig.generalSettings.AESGlobalSettings.contextMenu.info:_online.._value",
                             "_AESConfig.generalSettings.AESGlobalSettings.contextMenu.settings:_online.._value",
                             "_AESConfig.generalSettings.AESGlobalSettings.contextMenu.close:_online.._value",
                             "_AESConfig.generalSettings.AESGlobalSettings.contextMenu.prio:_online.._value"), 
               availableItems);

  else
    dpGetCache(makeDynString("_AESConfigRow.generalSettings.AESGlobalSettings.contextMenu.title:_online.._value",
                             "_AESConfigRow.generalSettings.AESGlobalSettings.contextMenu.ack:_online.._value",
                             "_AESConfigRow.generalSettings.AESGlobalSettings.contextMenu.ackAV:_online.._value",
                             "_AESConfigRow.generalSettings.AESGlobalSettings.contextMenu.comment:_online.._value",
                             "_AESConfigRow.generalSettings.AESGlobalSettings.contextMenu.panel:_online.._value",
                             "_AESConfigRow.generalSettings.AESGlobalSettings.contextMenu.trend:_online.._value",
                             "_AESConfigRow.generalSettings.AESGlobalSettings.contextMenu.details:_online.._value",
                             "_AESConfigRow.generalSettings.AESGlobalSettings.contextMenu.sum:_online.._value",
                             "_AESConfigRow.generalSettings.AESGlobalSettings.contextMenu.info:_online.._value",
                             "_AESConfigRow.generalSettings.AESGlobalSettings.contextMenu.settings:_online.._value",
                             "_AESConfigRow.generalSettings.AESGlobalSettings.contextMenu.close:_online.._value",
                             "_AESConfigRow.generalSettings.AESGlobalSettings.contextMenu.prio:_online.._value"), 
               availableItems);

  if(dynlen(availableItems) == 12)
  {
    bIsPara = TRUE;
    
    
    title            =availableItems[1];//
    ack              =availableItems[2];
    denyava          =!availableItems[3];
    insertComment    =availableItems[4];
    procPanel        =availableItems[5];
    trend            =availableItems[6];
    details          =availableItems[7];//
    sumDetails       =availableItems[8];
    helpInfo         =availableItems[9];
    properties       =availableItems[10];
    exit             =availableItems[11];//
    changeAlertClass =availableItems[12];
  }
  else // default visibilty settings of popup menu
  {
    title         =true;
    ack           =true;
    denyava       =false;
    insertComment =true;
    procPanel     =true;
    trend         =true;
    details       =true;
    sumDetails    =false;
    helpInfo      =true;
    properties    =true;
    exit          =true;
    changeAlertClass = false;
  }
  
  anytype aVal;
  string dpid, fullDpid, pPanel, helpAttr;
  int dpeType, archiveType, ackState;
  unsigned mode, runMode;

  aes_getPropMode( propDpName, mode );   // (type) open, closed, current
  aes_getRunMode( propDpName, runMode );

  // control popup items visibility
  dpid=mTableMultipleRows[row][_DPID_];
  fullDpid=dpid;

  dpid=dpSubStr( dpid, DPSUB_SYS_DP_EL );  

  if( emptyRow )
    dpeType=DPEL_BOOL;    // dummy
  else
    dpeType=dpElementType( dpid );

  /////////// control popup items visibility
  /////////// begin ***********************{

  //**** title - not within base struct
  //****************************************************************************************


  //**** ack - always available at alerts / permission depending ???
  if(ack || !bIsPara)
  {
    if( screenType == AESTYPE_ALERTS )
    {
      // suppress ack menu in closed mode
      if( mode == AES_MODE_CLOSED )
      {
        ack=false;
      }
      else
      {
        if( aes_checkSumAlert( dpeType ) )
        {
          ack=false;
        }
        else
        {
          string tmp;
          string ackVal, ackOldest;
          bool ackable, bAckable, bAckOldest;

          /////////////////////// workaround / replace !!!!!!!!!!!!!!!!
          ackVal    =mTableMultipleRows[row][_ACKABLE_];
          ackOldest =mTableMultipleRows[row][_ACK_OLD_];

          bAckable=(bool)strrtrim( strltrim( ackVal ) );
          bAckOldest=(bool)strrtrim( strltrim( ackOldest ) );

          if( bAckable && bAckOldest )
            ack=true;
          else
            ack=false;
        }
      }

      // suppress acknowledge if screen is stopped in any case!
      if( runMode != AES_RUNMODE_RUNNING )
        ack=false;
    }
  }
  //****************************************************************************************


  //**** deny ava
  if(denyava || !bIsPara)
  {
    if( mode == AES_MODE_CLOSED )
    {
      denyava=true;   // ==> suppres ack all visible entry !!!
    }
    else
    {
      denyava=aes_getGeneralSettingsValue( CHK_DENYAVA ); 

      // suppress acknowledge if screen is stopped in any case!
      if( runMode != AES_RUNMODE_RUNNING )
        denyava=true;  // reverse state !!! => deny
    }
  }
  //****************************************************************************************

  
  //**** insert comment - not possible at sum alert types
  if(insertComment || !bIsPara)
  {
    if( screenType == AESTYPE_ALERTS )
    {
      //if( dynContains( sumAlertList, dpeType ) > 0 )
      if( aes_checkSumAlert( dpeType ) )
        insertComment=false;
      else
        insertComment=true;
    
      if( runMode != AES_RUNMODE_RUNNING )
        insertComment=false;
    }
  }
  //****************************************************************************************
  

  //**** proc panel - onlay avl. at alerts / check whether value differs from ""
  if(procPanel || !bIsPara)
  {
    if( !emptyRow )
      dpGet( dpid + ":_alert_hdl.._panel", pPanel );
  
    pPanel=strltrim( strrtrim( pPanel ) );

    if( pPanel != "" )
    {
      pPanel=getPath( PANELS_REL_PATH, pPanel ); 
      if( pPanel == "" )
        procPanel=false;
      else
        procPanel=true;
    }
    else
      procPanel=false;
  }
  //****************************************************************************************


  //**** trend - check for sum alert type and historical data / even with dpGetPeriod ???
  if(trend || !bIsPara)  
  {
    //if( dynContains( sumAlertList, dpeType ) > 0 )
    if( aes_checkSumAlert( dpeType ) ||  
        dynlen(diSelectedLines) > 1 )  //Trend only available if only one alert selected
    {
      trend=false;
    }
    else
    {
      if( !emptyRow )
        dpGet( dpid + ":_archive.._type", archiveType );

      if( archiveType != 0 )
      {
        // archive present - trend available
        trend=true; 
      }
      else
      {
        trend=false; 
      }
    }
  }
  //****************************************************************************************


  //**** details - always available
  //****************************************************************************************


  //**** sumAlertDetails and OnlineChangingOfAlertClass
  if( screenType == AESTYPE_ALERTS )
  {
    //if( dynContains( sumAlertList, dpeType ) > 0 )
    if( aes_checkSumAlert( dpeType ) ||  dynlen(diSelectedLines) > 1)  //Details only available if only one alert selected
    {
      // changing the alert class is not possible for summary alerts
      changeAlertClass = FALSE;
      
      if(sumDetails || !bIsPara)
      {
        if( mode != AES_MODE_CLOSED && dynlen(diSelectedLines) <= 1)  //SumDetails only available if only one alert selected
          sumDetails=true;
        else
          sumDetails=false;

        details=false;
      }
    }
    else
    {
      sumDetails=false;
      
//IM 95447: allow online alert class change in Current mode with RDB for discret alarms      
      if(changeAlertClass || !bIsPara) 
      {
        if (mode == AES_MODE_CURRENT && mTableMultipleRows[row][_ACK_OLD_] && useRDBArchive())
        {
          bool bDiscretAlert;
        
          dpGet( dpid + ":_alert_hdl.._discrete_states", bDiscretAlert );
          if (bDiscretAlert)
            changeAlertClass = TRUE;
          else
            changeAlertClass = FALSE;
        }
        else
          changeAlertClass = FALSE;
      }
    }
  }
  //****************************************************************************************

  //**** help info 
  if(helpInfo || !bIsPara)  
  {
    if( !emptyRow )
      dpGet( dpid + ":_alert_hdl.._help", helpAttr );
  
    helpAttr=strltrim( strrtrim( helpAttr ) );
    if( helpAttr == "" )
    {
      helpInfo=false; 
    }
  }
  //****************************************************************************************


  //**** properties
  if(properties || !bIsPara)  
  {
    if( !getUserPermission( AES_PERMLEVEL_MENUPROP ) )
    {
      // suppress properties entry if no valid permission
      properties=false;
    }
  }
  //****************************************************************************************


  //**** exit
  //****************************************************************************************


  /////////// control popup items visibility
  /////////// end *************************}


  aes_debug( __FUNCTION__+"() row="+row+" column="+column+" val="+val, " propDpName=" + propDpName + " tableName=" + tableName + " tabType=" + tabType, d );

  string sMenu;
  dyn_string dsMenu;

  dyn_string menu_text;

  menu_text[MENU_PB]="PUSH_BUTTON";
  menu_text[MENU_CB]="CASCADE_BUTTON";
  menu_text[MENU_SP]="SEPARATOR";

  if( screenType == AESTYPE_ALERTS )
  {
    first=firstAlertMenu;
    last=lastAlertMenu;
  }
  else if( screenType == AESTYPE_EVENTS )
  {
    first=firstEventMenu;
    last=lastEventMenu;
  }

  if( g_alertRow )
  {
    first=firstAlertRowMenu;
    last=lastAlertRowMenu;
  }

  // create menu dyn_string
  for( n=first; n < last; n++ )
  {
    dyn_anytype da=g_ddam[n];
    int entryType=da[ct]; 

    addMenu=true;
  
    // at empty alert row we only want to display the properties menu item
    if( g_alertRow && emptyRow )
    {
      if( entryType == MENU_PB )
      {
        if( da[ca] != AES_MNUA_PROPERTIES )
        {
          continue;
        }
      }
      else
      {
        continue;
      }
    }
    
    
    if( entryType == MENU_SB )
    {
      sMenu=da[cn];
    }
    else
    {
      sMenu=menu_text[entryType];
    }

    switch( entryType )
    {
      case MENU_PB:

        //****** title
        if ( da[ca]==AES_MNUA_ALERTS || da[ca]==AES_MNUE_EVENTS )
        {

          // exception for top menu line
          if( title )
          {
            string entryName;
            aes_getStatusString( entryName, propDpName, true );
          
            aes_addMenu( sMenu, da, entryName );
          }
          else
          {
            addMenu=false;
          }
        }
        //*/

        //****** ack
        else if( da[ca]==AES_MNUA_ACK )
        {
          if( ack )
          {
            aes_addMenu( sMenu, da );
          }
          else
          {
            addMenu=false;
          }
        }
        //*/

        //****** ack all visible
        else if( da[ca]==AES_MNUA_ACKALLVISIBLE )
        {
          if( !denyava  )
          {
            aes_addMenu( sMenu, da );
            //sMenu=sMenu + com + da[cn] + com + da[ca] + com + da[cv];
          }
          else
          {
            addMenu=false;
          }
        }
        //*/

        //****** insert comment
        else if( da[ca]==AES_MNUA_INSCOMMENT || da[ca]==AES_MNUE_INSCOMMENT )
        {
          if( insertComment )
          {
            aes_addMenu( sMenu, da );
          }
          else
          {
            addMenu=false;
          }
        }
        //*/

        //****** proc panel
        else if( da[ca]==AES_MNUA_PROCPANEL || da[ca]==AES_MNUE_PROCPANEL || da[ca]==AES_MNUA_PROCPANEL_NEW_WINDOW || da[ca]==AES_MNUA_PROCPANEL_MODULE )
        {
          if( procPanel )
          {
            // IM 105602
            // check if module is open, because menu won't be refreshed
            if ( isModuleOpen( ptms_BuildModuleName( "mainModule", substr(da[cn], strlen(da[cn])-1, 1) ) ) || da[ca]==AES_MNUA_PROCPANEL_NEW_WINDOW )
            {
              aes_addMenu( sMenu, da );
            }
            else
            {
              addMenu=false;
            }
          }
          else
          {
            addMenu=false;
          }
        }
        //*/
        
        //****** trend
        else if( da[ca]==AES_MNUA_TREND || da[ca]==AES_MNUE_TREND )
        {
          if( trend )
          {
            aes_addMenu( sMenu, da );
          }
          else
          {
            addMenu=false;
          }
        }
        //*/
        
        //****** details
        else if( da[ca]==AES_MNUA_DETAILS || da[ca]==AES_MNUE_DETAILS )
        {
          if( details )
          {
            aes_addMenu( sMenu, da );
          }
          else
          {
            addMenu=false;
          }
        }
        //*/

        //****** sumalert details
        else if( da[ca]==AES_MNUA_SUMALERTDETAILS )
        {
          if( sumDetails )
          {
            aes_addMenu( sMenu, da );
          }
          else
          {
            addMenu=false;
          }
        }
        //*/

        //****** help info
        else if( da[ca]==AES_MNUA_DISPHELPINFO )
        {
          if( helpInfo )
          {
            aes_addMenu( sMenu, da );
          }
          else
          {
            addMenu=false;
          }
        }
        //*/

        //****** properties
        else if( da[ca]==AES_MNUA_PROPERTIES )
        {
          if( properties )
          {
            aes_addMenu( sMenu, da );
          }
          else
          {
            addMenu=false;
          }
        }
        //*/

        //****** exit
        else if( da[ca]==AES_MNUA_EXIT )
        {
          if( exit )
          {
            aes_addMenu( sMenu, da );
          }
          else
          {
            addMenu=false;
          }
        }
        else if ( da[ca]==AES_MNUA_CHANGEALERTCLASS)
        {
          if(changeAlertClass)  //mtrummer: entscheide ob menu eintrag
          {
            aes_addMenu( sMenu, da); 
          }
          else
          {
            addMenu = false;
          }
        }
        //*/
        else
        {
          aes_addMenu( sMenu, da );
          //sMenu=sMenu + com + da[cn] + com + da[ca] + com + da[cv];
        }

      break;

      case MENU_CB:
        // IM 105602
        // if button should be invisible, don't show it (for procPanel)
        if ( da[ca] == "invisible" && !procPanel )
        {
          addMenu = false;
        }
        else
        {
          sMenu=sMenu + com + da[cn] + com + da[cv] + com;
        }
      break;

      case MENU_SP:
        // suppress first seperator line / no itmes to separate | ALERTS
        if( sepCount == 1 && ( ( ack == false ) && ( denyava == true ) ) )
          addMenu=false;

        // suppress second seperator line / no itmes to separate | ALERTS
        if( sepCount == 2 && ( ( insertComment == false ) && ( procPanel == false ) ) )
          addMenu=false;

        // suppress first seperator line / no itmes to separate | EVENTS
        if( screenType == AESTYPE_EVENTS && ( !trend  ) && ( sepCount == 1 ) )
          addMenu=false;

        if( g_alertRow )
        {
          // if no properties where available / suppress last seperator
          if( !properties )
          {
            // check whether next item is properties
            if( n < ( last - 1 ) )
            {
              // if we where not on last pos
              dyn_anytype dat=g_ddam[n+1];
              if( dat[ca] == AES_MNUA_PROPERTIES )
              {
                addMenu=false;
              }
            }
            else
            {
              // last pos - no further entries available
              addMenu=false;
            }
          }
        }

        sepCount++;
      break;

      case MENU_SB:
        // nothing to do
      break;

      default:
       aes_message( AESMSG_GENERAL_ERROR, makeDynAnytype(), 1, __FUNCTION__ );        
    }

    if( addMenu )
    {
      dynAppend( dsMenu, sMenu );
    }
  }

  // select table row
  if( !g_alertRow )
  {
    this.selectLineN( row );
  }
  
  //makes sure that the last entry is not a SEPARATOR
  if(dsMenu[dynlen(dsMenu)] == "SEPARATOR")
    dynRemove(dsMenu, dynlen(dsMenu));
  
  if( dynlen( dsMenu ) > 0 )
  {
    res=popupMenu( dsMenu, answer );

    if( res == 0 )
    {
      aes_menuFunctionHandler( propDpName, answer, row, column, val, tabType, tableName, emptyRow, mTableMultipleRows, diSelectedLines );  
    }
  }

  // 18.03.2016:
  // comment updatesEnabled because it is used here in a wrong way and
  // it causes some problems with stylesheets (table invisible) - IM 119748
  // this.updatesEnabled=true;
}

/**
  Main menu function routine, called after selection. 
  @param none
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/
void aes_addMenu( string &sMenu, dyn_anytype &da, string entryName="" )
{
  string entry;
  const string com=",";
  const int ct=1, // menuType
            cn=2, // menuentryName
            ca=3, // menuAnswernumber
            cv=4; // menuVisible

  if( entryName != "" )
  {
    entry=entryName;
  }
  else
  {
    entry=da[cn];
  }

  sMenu=sMenu + com + entry + com + da[ca] + com + da[cv];

}


/**
  Main menu function routine, called after selection. 
  @param none
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/
void aes_menuFunctionHandler( const string propDpName, const int functionId, int row, int column,
                              anytype val, const int tabType, const string tableName, bool emptyRow, mapping mTableMultipleRows,
                              dyn_int diSelectedLines = makeDynInt() )  
{
  anytype cellVal;
  string dpid="";
  int res=0;
  int iScreenType;
  mapping mTableRow;

  if( !emptyRow ) 
  {
    // leave if nothing is selected / exception only for ackAllVisible
    if( ( row < 0 ) && ( functionId != AES_MNUA_ACKALLVISIBLE ) )
    {
      return;
    }

    res=aes_getDpidFromTable( row, dpid, mTableMultipleRows[row] );

    if( res != 0 )
    {
      return;
    }
    cellVal=mTableMultipleRows[row][_DPID_];
  }
  
  // IM 105602
  // Module menu for procPanel, because we cannot detect later which module button was clicked
  if ( functionId > (100 * AES_MNUA_PROCPANEL_MODULE) )
  {
    int moduleId = functionId % (100 * AES_MNUA_PROCPANEL_MODULE);
    aes_displayAlertHdlPanel( dpid, row, ptms_BuildModuleName( "mainModule", moduleId ) );  
  }
  
  switch( functionId )
  {
    // Alerts
    /////////
    case AES_MNUA_ACK:
      //change format of mapping because mapping should only contain single row to ack
      if(dynlen(diSelectedLines) > 1)
      {
        mTableRow = mTableMultipleRows;
        mappingClear(mTableMultipleRows);
        for(int i = 1; i <= dynlen(diSelectedLines); i++)
          mTableMultipleRows[diSelectedLines[i]] = mTableRow[diSelectedLines[i]];
      }
      else
      {
        mTableRow = mTableMultipleRows[row];
        mappingClear(mTableMultipleRows);
        mTableMultipleRows[row] = mTableRow;
      }
      
      aes_changedAcknowledgeWithRowData( AES_CHANGED_ACKSINGLE, tabType, mTableMultipleRows );
      break;

    case AES_MNUA_ACKALLVISIBLE:
      //IM 116668: Use the same function which is used on the general ack button
      aes_doAckVisible( propDpName );
//       aes_changedAcknowledgeWithRowData( AES_CHANGED_ACKALLVIS, tabType, mTableMultipleRows );
      break;

    case AES_MNUA_INSCOMMENT:
      if(dynlen(diSelectedLines) > 1)  
        aes_insertCommentMulti(mTableMultipleRows, diSelectedLines);
      else
        aes_insertComment( row, mTableMultipleRows[row] );
      break;

    // IM 105602
    /*case AES_MNUA_PROCPANEL:
      aes_displayAlertHdlPanel( dpid, row, ptms_BuildModuleName( "mainModule", g_sScreenOpenedFirst ) );
      break;*/
    
    // IM 105602
    case AES_MNUA_PROCPANEL_NEW_WINDOW:
      aes_displayAlertHdlPanel( dpid, row, "_newWindow_" );
      break;

    case AES_MNUA_TREND:
      aes_displayTrend( row, mTableMultipleRows );
      break;

    case AES_MNUA_DETAILS:
      aes_getScreenType(propDpName, iScreenType);
      aes_displayDetails( iScreenType, row, propDpName, mTableMultipleRows[row] );
      break;

    case AES_MNUA_SUMALERTDETAILS:
      //aes_displaySumalertDetails( dpid, row );
      aes_displaySumalertDetails( cellVal, row, propDpName );
      break;

    case AES_MNUA_DISPHELPINFO:
      aes_displayAlertHelp( dpid );
      break;
      
    case AES_MNUA_CHANGEALERTCLASS:
      aes_displayChangeAlertClass( mTableMultipleRows[row] );//mtrummer: change alert class at runtime
      break;

    case AES_MNUA_PROPERTIES:
      if( g_alertRow )
      {
        //  if we call it from there it will be alert row and we have to use the top table???
        aes_propertyDialog( tabType, true, true );
      }
      else
      {
        aes_propertyDialog( tabType, true, false );
      }
      break;

    case AES_MNUA_EXIT:
      aes_panelOff();
      break;
    // Events
    /////////
    case AES_MNUE_TREND:
      aes_displayTrend( row, mTableMultipleRows );
      break;

    case AES_MNUE_DETAILS:
      aes_getScreenType(propDpName, iScreenType);
      aes_displayDetails( iScreenType, row, propDpName, mTableMultipleRows[row] );  // check mtrummer AESTYPE_EVENTS ??
      break;

    default:
      aes_message( AESMSG_GENERAL_ERROR, makeDynAnytype(), 1, __FUNCTION__ );
  }


  // thaw table
  // 18.03.2016:
  // comment updatesEnabled because it is used here in a wrong way and
  // it causes some problems with stylesheets (table invisible) - IM 119748
  // this.updatesEnabled=true;

}


void aes_insertComment( int row, mapping mTableRow )
{
  atime  ti; 
  string sAlertDp; 
  string sClass; 
  bool   bArchiv;
  string sWarningText;
   

  // Alert with a class which is not saving the alert should not be commented
  ti = mTableRow[_TIME_];

  sAlertDp = dpSubStr( getAIdentifier( ti ), DPSUB_SYS_DP_EL_CONF_DET );
  dpGet( sAlertDp + "._class", sClass );
  dpGet( sClass + ":_alert_class.._archive", bArchiv );

  // Give a comment to a DP from another system is not allowed
  if( dpSubStr( sAlertDp, DPSUB_SYS ) == "" )           // check if correct system
  {
    sWarningText = getCatStr( "sc", "noCommentSystem" );
    ChildPanelOnCentralModal("vision/MessageWarning", "",
      makeDynString( "$1:" + sWarningText ));
  }
  else if( !bArchiv ) 
  { 
    // Alert will not be saved 
    sWarningText = getCatStr( "sc", "noComment" );
    strreplace ( sWarningText, "\uA7", "\n" );  
    ChildPanelOnCentralModal("vision/MessageWarning", "", 
      makeDynString( "$1:" + sWarningText )); 
  }
  else
  {
    // Alert will be saved and system is ok
    //as_commentAction(row, "vision/SC/AS_detail");
    aes_commentAction(row, "vision/aes/AS_detail.pnl", mTableRow);
  }
}

/**
  New function for the comment functionality if multiselect is used
  @param none
  @author Daniel Spitzer
  @version 1.0
  @return nothing
*/
void aes_insertCommentMulti(mapping mTableRow, dyn_int diSelectedLines)
{
  atime  ti; 
  string sAlertDp; 
  string sClass; 
  bool   bArchiv, bError = FALSE;
  string sWarningText;
   
  for(int i = 1; i <= dynlen(diSelectedLines) && !bError; i++)
  {
    // Alert with a class which is not saving the alert should not be commented
    ti = mTableRow[diSelectedLines[i]][_TIME_];
    
    sAlertDp = dpSubStr( getAIdentifier( ti ), DPSUB_SYS_DP_EL_CONF_DET );
    dpGet( sAlertDp + "._class", sClass );
    dpGet( sClass + ":_alert_class.._archive", bArchiv );
    
    // Give a comment to a DP from another system is not allowed
    if( dpSubStr( sAlertDp, DPSUB_SYS ) == "" )           // check if correct system
    {
      bError = TRUE;
      sWarningText = getCatStr( "sc", "noCommentSystem" );
    }
    else if( !bArchiv ) 
    {
      bError = TRUE;
      // Alert will not be saved 
      sWarningText = getCatStr( "sc", "noComment" );
      strreplace ( sWarningText, "\uA7", "\n" );  
    }
  }
  
  if(!bError)
  {
    // Alert will be saved and system is ok
    //as_commentAction(row, "vision/SC/AS_detail");
    aes_commentActionMulti("vision/aes/AS_detail.pnl", mTableRow, diSelectedLines);
  }
  else
    ChildPanelOnCentralModal("vision/MessageWarning", "", 
        makeDynString( "$1:" + sWarningText ));
}


void aes_commentAction(int row, string panel, mapping mTableRow)
{
  string comment, dpe, tim, count, ackable, oldest;  // string for automatic conversion
  atime ti;
  time t;
  dyn_string ds;
  dyn_float df;
  dyn_string dsTemp;

  // 18.03.2016:
  // comment updatesEnabled because it is used here in a wrong way and
  // it causes some problems with stylesheets (table invisible) - IM 119748
  // this.updatesEnabled = false;
         
  comment = mTableRow[_COMMENT_];
  ti = mTableRow[_TIME_];
  ackable = mTableRow[_ACKABLE_];
  oldest = mTableRow[_ACK_OLD_];

  {
    dyn_int counts;
    dyn_string dpes1;
    dyn_time times; 
    dyn_string comments;
    int i; 


    // get attributes of alert
    alertGetPeriod(ti, ti, times, counts,
                   dpSubStr(getAIdentifier(ti), DPSUB_SYS_DP_EL_CONF_DET) + "._comment",   dpes1, comments  );
  
    count = getACount(ti); 

    for (i = 1; (i <= dynlen(counts)) && (counts[i] != count); i++) ;
   
    if ( i > dynlen(counts) )
    {
      std_error("AS", ERR_IMPL, PRIO_WARNING, E_AS_FUNCTION, "main():alertGetPeriod("+ dpSubStr(getAIdentifier(ti), DPSUB_SYS_DP_EL_CONF_DET) +")");
    }
    else
      comment = comments[i];
  }

  // start child panel for comment input                 /// panel jetzt AESComments.pnl
  ChildPanelOnCentralModalReturn("vision/aes/AESComments.pnl", getCatStr( "STD_Symbols","Komentareingabe"),    // blubbersatzpanelname
       makeDynString("$comment:" + comment,
                     "$dpid:" + dpSubStr(getAIdentifier(ti), DPSUB_SYS_DP_EL_CONF_DET),
                     "$time:" + (tim = ti),
                     "$count:" + (count = getACount(ti)),
                     "$ackable:" + ackable,
                     "$oldest:" + oldest,
                     "$detailPanel:" + panel,
                     "$mode:SINGLE"),  
                     df, ds);

  if ( dynlen(df) == 1 && df[1] == 1)
  { 
    strreplace(ds[1], "<>", recode((char)0xA7, "ISO-8859-1"));
    dsTemp = strsplit(ds[1], recode((char)0xA7, "ISO-8859-1"));
    t= ti;

    int ret = alertSet(t, getACount(ti), dpSubStr(getAIdentifier(ti), DPSUB_SYS_DP_EL_CONF_DET) + "._comment", ds[1]);
    dyn_errClass err = getLastError();
    
    if ( ret == -1 )
    {
      std_error("AS", ERR_SYSTEM, PRIO_SEVERE,
                E_AS_FUNCTION, "main(): alertSet( ... _comment ...)");
    }
    
    if ( dynlen(err) )
    {
      errorDialog(err);
    }
    else
    {
      this.updateLine(3,  _COUNT_, mTableRow[_COUNT_],
                          _DPID_, mTableRow[_DPID_],
                          _TIME_, mTableRow[_TIME_],
                          _COMMENT_, ds[1],
                          "nofComments", dynlen(dsTemp));
         //IM 116232 synchronize comments in DRS
          int mode;
          string propDp;
          aes_getPropDpName4TabType(AESTAB_TOP,propDp);
          aes_getPropMode( propDp, mode );   // (type) open, closed, current
          if(mode != AES_MODE_CURRENT)//aktuelle Alarme werden im DRS Script synchronisiert
          {
            if(isFunctionDefined("disRecSystem_aesSyncAlertComments") && dpExists("_2x2Redu"))
              disRecSystem_aesSyncAlertComments(ti,ds[1]);
          }
        //IM 116232 synchronize alert comments
          
    }

  } 
  // 18.03.2016:
  // comment updatesEnabled because it is used here in a wrong way and
  // it causes some problems with stylesheets (table invisible) - IM 119748
  // this.updatesEnabled = true;

}

/**
  New function for the comment functionality if multiselect is used
  @param none
  @author Daniel Spitzer
  @version 1.0
  @return nothing
*/
void aes_commentActionMulti(string panel, mapping mTableRow, dyn_int diSelectedLines)
{
  string comment, dpe, tim, count, ackable, oldest;  // string for automatic conversion
  atime ti;
  time t;
  dyn_string ds;
  dyn_float df;
  dyn_string dsTemp;
  dyn_string dsTime, dsDP, dsText, dsDirection;

  // 18.03.2016:
  // comment updatesEnabled because it is used here in a wrong way and
  // it causes some problems with stylesheets (table invisible) - IM 119748
  // this.updatesEnabled = false;
  
  for(int j = 1; j <= dynlen(diSelectedLines); j++)
  {
    dynAppend(dsTime, mTableRow[diSelectedLines[j]][_TIME_]);
    dynAppend(dsDP, mTableRow[diSelectedLines[j]]["elementName"]);
    dynAppend(dsText, mTableRow[diSelectedLines[j]]["alertText"]);
    dynAppend(dsDirection, mTableRow[diSelectedLines[j]]["direction"]);
  }
  
  // start child panel for comment input                 /// panel jetzt AESComments.pnl
  ChildPanelOnCentralModalReturn("vision/aes/AESComments.pnl", getCatStr( "STD_Symbols","Komentareingabe"),    // Ersatzpanelname
       makeDynString("$time:" + dynStringToString(dsTime),
                     "$dp:" + dynStringToString(dsDP),
                     "$text:" + dynStringToString(dsText),
                     "$direction:" + dynStringToString(dsDirection),
                     "$mode:MULTI"),
                     df, ds);

  if ( dynlen(df) == 1  && df[1] == 1 && dynlen(ds) == 1)  //The comments panel was closed with OK ( df[1]==1 ) and a comment text was entered ( dynlen(ds)==1 )
  {
    for(int j = 1; j <= dynlen(diSelectedLines); j++)
    {
      comment = mTableRow[diSelectedLines[j]][_COMMENT_];
      ti = mTableRow[diSelectedLines[j]][_TIME_];
      ackable = mTableRow[diSelectedLines[j]][_ACKABLE_];
      oldest = mTableRow[diSelectedLines[j]][_ACK_OLD_];
      
      dyn_int counts;
      dyn_string dpes1;
      dyn_time times; 
      dyn_string comments;
      int i;
      
      int iDpeType = dpElementType(dpSubStr(getAIdentifier(ti), DPSUB_SYS_DP_EL));
      
      if(aes_checkSumAlert(iDpeType))  //Skip sum alert DPEs when inserting new comment because AES does not allow to insert comments on sum alert DPEs
        continue;
      
      // get attributes of alert
      alertGetPeriod(ti, ti, times, counts,
                     dpSubStr(getAIdentifier(ti), DPSUB_SYS_DP_EL_CONF_DET) + "._comment",   dpes1, comments );
      
      count = getACount(ti); 
      
      for (i = 1; (i <= dynlen(counts)) && (counts[i] != count); i++) ;
      
      if ( i > dynlen(counts) )
      {
        std_error("AS", ERR_IMPL, PRIO_WARNING, E_AS_FUNCTION, "main():alertGetPeriod("+ dpSubStr(getAIdentifier(ti), DPSUB_SYS_DP_EL_CONF_DET) +")");
      }
      else
        comment = comments[i];
      
      
      comment += ds[1] + recode((char)0xA7, "ISO-8859-1");  //Append new comment to the existing comment string
      
      t = ti;
      
      if ( alertSet(t, getACount(ti), dpSubStr(getAIdentifier(ti), DPSUB_SYS_DP_EL_CONF_DET) + "._comment", comment) == -1 )
      {
        std_error("AS", ERR_SYSTEM, PRIO_SEVERE,
                  E_AS_FUNCTION, "main(): alertSet( ... _comment ...)");
      }
    }
  }
  
  // 18.03.2016:
  // comment updatesEnabled because it is used here in a wrong way and
  // it causes some problems with stylesheets (table invisible) - IM 119748
  // this.updatesEnabled = true;
}


dyn_string aes_splitComment(string comment)
{
  strreplace(comment, "<>", recode((char)0xA7, "ISO-8859-1"));
  return strsplit(comment, recode((char)0xA7, "ISO-8859-1"));
}


void aes_addCommentApply()
{
  string text, ti = getCurrentTime();
        
  getValue("text", "text", text);
          
  if ( text != "" )
  {
    //sprintf(user, "%10s|%s|", getUserName(), ti);
    setValue("tblHistory", "appendLine", "Time", ti, "User", getUserName(), "Comment", text);
    setValue("text", "text", "");  // clear own text
  }
}


void aes_addCommentOK()
{
/*
$-Parameter:
  dpid (string) ... DP-Element name + config + detail
  time (time as string) ... time of alert
  count (int) ... count of alert
  ackable (bool) ... is alert ackable
  oldest (boold) ... is this the oldest alert
  comment (string) ... comment of alert
*/
  dyn_string dsTemp;  
  string comment, text, sTemp;
  
  getValue("text", "text", text);

  if(g_bMulti)  
  {
    if(text != "")
    {
      strreplace(text, recode((char)0xA7, "ISO-8859-1"), "&sect;");
      strreplace(text, ">", "&gt;");
      strreplace(text, "<", "&lt;");
      strreplace(text, "|", "&brvbar;");

      sTemp = getUserName() + "|" + (string)getCurrentTime() + "|" + text;  //comment in correct format
      dsTemp = makeDynString(sTemp);
    }
    
    PanelOffReturn(makeDynFloat(1), dsTemp);  //In case that no comment was entered an empty DynString will be returned
  }
  else
  {
    if ( text != "" ) as_addComment();  //TFS 5042: New Comments should also be inserted by using OK button
    
    int iColIdxTime, iColIdxUser, iColIdxText;
    dyn_string dsColValTime, dsColValUser, dsColValText;
    
    getValue("tblHistory", "nameToColumn", "Time", iColIdxTime,
                           "nameToColumn", "User", iColIdxUser,
                           "nameToColumn", "Comment", iColIdxText);
    
    getValue("tblHistory", "getColumnN", iColIdxTime, dsColValTime,
                           "getColumnN", iColIdxUser, dsColValUser,
                           "getColumnN", iColIdxText, dsColValText);
    
    for(int i=1; i<=dynlen(dsColValTime); i++)
    {
      sTemp = dsColValText[i];
      strreplace(sTemp, recode((char)0xA7, "ISO-8859-1"), "&sect;");
      strreplace(sTemp, ">", "&gt;");
      strreplace(sTemp, "<", "&lt;");

      if (dsColValUser[i] != "CommCenter" && dsColValTime[i] != "unknown format")
        strreplace(sTemp, "|", "&brvbar;");

      if (dsColValTime[i] != "unknown format")
        sTemp = dsColValUser[i] + "|" + dsColValTime[i] + "|" + sTemp;  //comment in correct format

      comment += sTemp + recode((char)0xA7, "ISO-8859-1");
    }
    
    PanelOffReturn(makeDynFloat(1), makeDynString(comment));
  }
}

aes_addCommentNOK()
{
   PanelOffReturn(makeDynFloat(-1), makeDynString (""));
}


void aes_displayTrend(int row, mapping mTableMultipleRows)
{
  if ( !getUserPermission(3) )
  {
    ChildPanelOnCentralModal("vision/MessageWarning", "",
      makeDynString("$1:" + getCatStr("sc", "noOperatorPerm")));
    
    return;
  }
    
  const string panel="vision/aes/AESTrend.pnl";

  time tiBegin, tiEnd;
  string dpe, dpeRow, tib, tie;
  dyn_int lines;
  int count, i;
  dyn_anytype da;
  dyn_time dt;
  dyn_int di;
  bool archived;
  dyn_errClass err;
  
  dpe = mTableMultipleRows[row][_DPID_];
  
  dpGet(dpSubStr(dpe, DPSUB_SYS_DP_EL) + ":_archive.._archive", archived);

  if ( archived )
  {
    tiBegin = tiEnd = 0;

    //search to find oldest and newest times for trend
    count = mappinglen(mTableMultipleRows);
    for(i=0; i<count; i++)
    {
      if(mTableMultipleRows[i][_DPID_] == dpe)
      {
        if(mTableMultipleRows[i][_TIME_] > tiEnd)
          tiEnd = mTableMultipleRows[i][_TIME_];
      
        if(!tiBegin)
          tiBegin = tiEnd;  
      
        if(mTableMultipleRows[i][_TIME_] < tiBegin)
          tiBegin = mTableMultipleRows[i][_TIME_];
      }
    }

    tib = tiBegin;  // convert time to string
    tie = tiEnd;

    dpGetPeriod(tiBegin, tiEnd, 1, dpSubStr(dpe, DPSUB_SYS_DP_EL) + ":_offline.._value", da, dt, di);
    err = getLastError();
  }
  
  if ( dynlen(err) || (dynlen(dt) == 0) )
  {
    ChildPanelOnCentralModal("vision/MessageWarning", "",
      makeDynString("$1:" + getCatStr("sc", "noHistory")));
    return;
  }

  openTrendCurves("MIN-MAX",1, makeDynString("$CURVE1:"+dpSubStr(dpe, DPSUB_SYS_DP_EL)));
}


void aes_displayDetails( const int screenType, int row, string propDpName, mapping mTableRow )
{
  string panel, dpid, tim, count, val;
  anytype value;
  int dpeType;
  
  dpid = mTableRow[_DPID_];
  tim = mTableRow[_TIME_];

  dpeType=dpElementType( dpid );

  // check alarmtype - if sumalert / display sumalertdetails instead of details !
  if( aes_checkSumAlert( dpeType ) )
  {
    aes_displaySumalertDetails( dpid, row, propDpName );
  }
  else
  {
    if( screenType == AESTYPE_EVENTS )
    {
      panel="vision/aes/ES_detail.pnl";
      value = mTableRow[_VALUE_];

      // start child panel for detail information
      ChildPanelOnCentralModal( panel, "",
          makeDynString("$dpid:" + dpid,
                        "$time:" + tim,
                        "$value:" + (value)));   // convert value to string
                        //stoki "$value:" + (val = value)));   // convert value to string
    }
    else
    {
      int mode;

      panel="vision/aes/AS_detail.pnl";
      count = mTableRow[_COUNT_];
      aes_getPropMode( propDpName, mode );
      // start child panel for detail information
      ChildPanelOnCentralModal(panel, "",
                      makeDynString("$dpid:" + dpid,
                                    "$time:" + tim,
                                    "$count:" + count,
                                    "$aesMode:"+ mode));
    }
  }
}

void aes_displayChangeAlertClass( mapping mTableRow )
{
      string panel="vision/aes/AS_changeAlertClass.pnl";
      // start child panel for online changing of alarm class
      ChildPanelOnCentralModal(panel, "",
                      makeDynString("$dpid:" + mTableRow[_DPID_],
                                    "$time:" + (string)mTableRow[_TIME_],
                                    "$count:" + mTableRow[_COUNT_]));
}

bool aes_checkSumAlert( int type )
{
  return (isDpTypeSumAlert(type));  //IM 81892 use the standard Function
}


void aes_displaySumalertDetails( string dpid, int row, string propDpName )
{
  int mode;

  const string panel="vision/aes/AESSumAlertDetails.pnl";

  aes_getPropMode( propDpName, mode );
  // check mode - we only want to display the panel at current and open mode
  
  if( mode == AES_MODE_CURRENT || mode == AES_MODE_OPEN )
  {
    ChildPanelOnCentralModal( panel, "",
        makeDynString("$dpid:" + dpid ) );
  }
  else
  {
    //dialog - "SumAlert only available at current or open mode !" );
    aes_throwError( AES_TE_SUMALERTNOAVL, PRIO_INFO );
  }

}

//@} Menufunctionblock-end


//********************************************************
//********************************************************
//********************************************************
//********************************************************
//********************************************************


/**@name Propertiesfunctionblock*/ 
//@{


/*
  Main property connection routine
  @param none
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/
void aes_doPropControlConnect( int &ret )
{
  const string settings=".Settings.";
  const string ovl=":_online.._value";

  if( dpConnect( AESCONTROL_WORKFUNC, false,
        g_propDp + settings + "Cancel" + ovl,
        g_propDp + settings + "RunCommand" + ovl,
        g_propDp + settings + "Changed" + ovl ) )
  {
    aes_message( AESMSG_DPCONNECT_FAILED, makeDynString( g_propDp ), 1, __FUNCTION__ );
    ret=-1;
    return;
  }

  ret=0;
  return;
}


void aes_getProportion( const string &propDp, int &proportion )
{
  dpGetCache( propDp + ".Settings.Proportion" + AES_ONLVAL, proportion );
}


void aes_getActivity( const string &propDp, bool &active )
{
  dpGetCache( propDp + ".Settings.Active" + AES_ONLVAL, active );
}


void aes_getPropMode( const string &propDp, unsigned &propMode )
{
  dpGetCache( propDp + ".Both.Timerange.Type" + AES_ONLVAL, propMode );
}


void aes_triggerPropCB( string &propDp, bool interval=false )
{
  time valBegin, valEnd;
  unsigned propMode, valSelection, valShift;
  bool valHistData=false;
  uint uHistoricalDataInterval, uEndTimeSeconds; 

  dpGetCache( propDp + ".Both.Timerange.Type" + AES_ONLVAL, propMode,
              propDp + ".Both.Timerange.Begin" + AES_ONLVAL, valBegin,
              propDp + ".Both.Timerange.End" + AES_ONLVAL, valEnd,
              propDp + ".Both.Timerange.Selection" + AES_ONLVAL, valSelection,
              propDp + ".Both.Timerange.Shift" + AES_ONLVAL, valShift,
              propDp + ".Both.Timerange.HistoricalData" + AES_ONLVAL, valHistData,
              propDp + ".Both.Timerange.HistoricalDataInterval" + AES_ONLVAL, uHistoricalDataInterval );
 
  // 1) correct time info
  if( propMode == AES_MODE_CLOSED )
  {
    // we will only recalculate the timeinterval if we didn't perform a intervalchange 
    if( ! interval )
      aes_getBeginEndTime( valBegin, valEnd, valSelection, valShift );  // correct timerange

  }
  else if( ( propMode == AES_MODE_OPEN ) && valHistData )
  {
    // set start and end time for historical data !!!
    valEnd = getCurrentTime();

    if(uHistoricalDataInterval > 0)  //There is a user defined time interval for historical data set
    {
      uEndTimeSeconds = period(valEnd);  //Returns the seconds of the time valEnd that have elapsed since 1.1.1970, 00:00 (UTC)
      uHistoricalDataInterval = uHistoricalDataInterval * (uint)60;  //Convert the user defined interval from minutes to seconds
      
      if(uHistoricalDataInterval > uEndTimeSeconds)  //The interval in seconds must not exceed the seconds that have elapsed since 1.1.1970 until the end time
        uHistoricalDataInterval = uEndTimeSeconds;
      
      setPeriod(valBegin, uEndTimeSeconds - uHistoricalDataInterval);
    }
    else  //There is NO user defined time interval so we use the interval set in the central settings
    {
      valBegin = valEnd - g_historicalDataInterval;
    }
  }

  // correct sort/visible column list / systems happens in aes_copyProperties() !!!

  // this set operation triggers the propertyCB
  dpSetCache( propDp + ".Both.Timerange.Begin" + AES_ORIVAL, valBegin,
              propDp + ".Both.Timerange.End" + AES_ORIVAL, valEnd );
}


void aes_getRunMode( const string &propDp, unsigned &runMode, const string dummy="" )
{
  const int d=0;

  //aes_debug( __FUNCTION__+"() / RunMode=" + runMode + " - called from : " + dummy, d );
  dpGetCache( propDp + ".Settings.RunMode" + AES_ONLVAL, runMode );
}


/*
  Resort the given table so that the "left" alerts are directly after the "entered" alert
  @param tab (in) ... result of query (& only for performance, but tab is being changed!!)
  @author Martin Pallesch
  @version 1.0
  @return resorted table
*/
dyn_dyn_anytype aes_resortTab(const int screenType, dyn_dyn_anytype &tab)
{
  const int d=5;
  int i, j, retIdx = 1;
  dyn_dyn_anytype ret;
  time t;

  int _timeIdx, _dirIdx;


  DebugN(__FUNCTION__+"() / Called xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");

  // we didnt need the table indexes - we need the attribute index from the query

  // the timeidx is always on second position
  _timeIdx=2;
  _dirIdx=dynContains( g_attrList, AES_SEARCH_DIRECTION );

  if( _dirIdx <= 0 )
  {
    // error - needed attribute not found
    aes_debug( __FUNCTION__+"() / Needed attribute=" + AES_SEARCH_DIRECTION + " not found !", d );
    return ret;
  }

  ret[retIdx++] = tab[1];   // we have to save the header

  for (i = 2; i <= dynlen(tab); i++)  // line 1 is header


    if ( (t = tab[i][_timeIdx]) != 0 )   // not used before in this function
    {
      ret[retIdx++] = tab[i];

      ///// frage Sinnhaftigkeit ??????????????? eigentlich "_text" Spalte
      if ( tab[i][_dirIdx] )  // _direction column == entered
      {
        for (j = i+1; j <= dynlen(tab); j++)   // search partner ("left" alert)
        {
          if ( getAIdentifier(tab[j][_timeIdx]) == getAIdentifier(tab[i][_timeIdx]) )  // same dpid && same detail
          {
            ret[retIdx++] = tab[j];
            tab[j][_timeIdx] = 0;  // set to "already used"
            break; 
          }
        }
      }
    }

  return ret;
}


void aes_getDpesOfFilter(string from, bool as, int &noOfDps)
{
  ///// neu - aus as.ctl !!!!!!!!!!!!! pruefen
  // ACHTUNG - diese Funktion kann nicht fuer eine Kombination aus Group und Dpes verwendet werden !!!!

  int        i, j, overflow, n;
  string     select, dpeT;
  dyn_string ds, ds1, ds2, dss, dps,
             typeFilter=makeDynString(""),
             dpeFilter=makeDynString(""),
             tdFilter=makeDynString("");
  // do not query if one of the filters is equal to one of the following patterns
  dyn_string badFilter = makeDynString( "**","*.**","*.*.**","*.*.*.**");
  dyn_dyn_anytype tab;

  dyn_string gds;

  noOfDps = 0;



  if (strpos(from,"{DPGROUP(") > 0)
  {
    string gName = substr(from,strpos(from,"{DPGROUP(")+9,
                               strpos(from,")}")-(strpos(from,"{DPGROUP(")+9));

    gds=aes_strsplit( gName, "),DPGROUP(" );

    for( n=1; n<=dynlen(gds); n++ )
    {
      groupGetFilterItemsRecursive( gds[n],ds1,ds2,overflow);
      if (overflow==-1 || overflow>20)
      {
        groupErrorScreen(-11);
        return;
      }
      dynAppend(typeFilter,ds1);
      dynAppend(dpeFilter,ds2);

      for (i=1;i<=dynlen(typeFilter);i++)
      {
        groupGetFilteredDps(typeFilter[i],dpeFilter[i],ds,overflow);
        if (overflow==-1)
        {
          groupErrorScreen(-11);
          return;
        }
        dynAppend(dps,ds);
      }
    }
  }
  else
  {
    if ( from == "'*'" )
    {
      noOfDps = -1;
      return;
    }
    else
    {
      string filter;

      filter = substr(from,strpos(from,"{")+1,
                           strpos(from,"}")-(strpos(from,"{")+1));
      ds = strsplit(filter,",");
      for (i = 1; i <= dynlen(ds); i++)
      {
        // system name and config in filter are not needed, only dp(e)-filter
        dss=strsplit(ds[i], ":");
        for ( j = 1; j <= dynlen(dss); j++)
        {
          if ( dynContains(badFilter,dss[j]) > 0 )
          {
            noOfDps = -1;
            return;
          }
        }
        ds1 = dpNames(ds[i]);
        dynAppend(dps,ds1);
      }
    }
  }

  dynSortAsc(dps);
  dynUnique(dps);

  noOfDps = dynlen(dps);

  //DebugN("Mengenoptimierung: ALERTSCREEN="+as,"Elemente: "+dynlen(dps),getCurrentTime());
}


void aes_doRestart( string propDp, bool fromDiscarding=false )
{
  unsigned runMode;

  aes_getRunMode( propDp, runMode );

  // check if query was stopped intermediatelly / only for discarded hangling - NOT for properties restart
  if( fromDiscarding )
  {
    if( runMode == AES_RUNMODE_RUNNING )
    {
      aes_doStop( propDp );
      delay(1);
      aes_doStart( propDp, 1 );
    }
    else
    {
      aes_displayStatus();
    }
  }
  else
  {
    aes_doStop( propDp );
    delay(1);
    aes_doStart( propDp, 1 );
  }
}


/*
  helper function for as_alertsCB
  this is a function, so that the CTRL can not interrupt it for better performance
  Parameters:
    xtab (in/out) ... already converted table of lines for the widget
    oldcount (in/out) ... old linecount of table
  @param none
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/
void aes_discardTimeOut( bool systemVis )
{
  string pre, app;
  bool vis;
  
  aes_getPreApp4TabType( g_tabType, pre, app );

  while (true)
  {
    if ( (getCurrentTime() - g_discardStart) > MAXCB_TIME )
    {
      string screenType, dpProp;
      dyn_string state;

      g_discarded = false;
      g_discardThread = -1;

      setValue( pre + "te_system",  "backCol", "",
                                    "visible", systemVis );

      aes_doRestart( g_propDp, true );

      return;
    }
    delay(1);
  }
}


bool aes_checkMaxLinesToDisplayProp( int lines, int screenType )
{
  if( lines > g_asMaxLinesToDisplay )  // too much lines found
  {
    dyn_float  df;
    dyn_string ds;
    string     sTemp;

    if( screenType == AESTYPE_EVENTS )
      sTemp = getCatStr("sc","toomuchevents2");
    else
      sTemp = getCatStr("sc","toomuchalert2");

    strreplace(sTemp, "\uA7", lines );
    strreplace(sTemp, "\uB0", g_asMaxLinesToDisplay);


    ChildPanelOnCentralModalReturn( "vision/MessageWarning2",
                                    getCatStr("sc","Attention"),
                                    makeDynString(  sTemp,
                                                    getCatStr("general","OK"),
                                                    getCatStr("sc","cancel") ),
                                    df, ds );

    if( !df[1] )  // No, don't display results
    {
//          if( lastSystem )
      aes_stopBusy( g_tabType );

      g_asDisplayLines=AES_DPQUERY_CANCELQUERY;
      setValue("", "deleteAllLines");
      setValue("", "visible",true);

      aes_doStop( g_propDp );
      return false;
    }
    else  // Yes, display them
    {
      strreplace(sTemp,"\n"," ");
      aes_debug( getCurrentTime(),"ManNum:"+myUiNumber(),"User: "+getUserName(),sTemp,getCatStr("para","yes") );
      g_asDisplayLines=AES_DPQUERY_CONTINUEQUERY; // do display

      return true;
    }
  }

  return true;
}


bool aes_checkMaxLinesToDisplay( int dlTab, int screenType, string ident )
{
  dyn_float  df;
  dyn_string ds;
  string     sTemp;
  
  int tabType, mode, systemId;
  bool fromProp;
  aes_getInfoFromIdentifier( ident, tabType, mode, systemId, fromProp );
  
  //Die Pruefung auf die maximalen Zeilenlimits fuer den geschlossen Modus erfolgen bereits in der Funktion aes_doDpQuery
  //Wenn diese Funktion fuer den Modus CLOSED oder CLOSEDAPP aufgerufen wird kann es sich nur um den Modus Offen+HistData handeln
  //und daher muss zur Pruefung des Zeilenlimits nicht die Tab Laenge sondern die maximale Anzahl von Zeilen im offenen Modus aus den Properties verwendet werden
  
  if((mode == AES_MODE_CLOSED || mode == AES_MODE_CLOSEDAPP) && (dlTab > g_maxLines))  //Im offenen Modus wird nur die max. Zeilenanzahl angezeigt daher diese anstatt der DynLen verwenden
    dlTab = g_maxLines;
  
  
  if( g_asDisplayLines != AES_DPQUERY_CONTINUEQUERY && dlTab > g_asMaxLinesToDisplay )
  {
    if( g_asDisplayLines == AES_DPQUERY_CANCELQUERY ) // do not display
    {
      aes_stopBusy( g_tabType );
      setValue("", "deleteAllLines");
      setValue("", "visible",true);
      
      aes_doStop( g_propDp );
      aes_displayStatus();

      return false;
    }
    else
    { 
      if( screenType == AESTYPE_EVENTS )
        sTemp = getCatStr("sc","toomuchevents2");
      else
        sTemp = getCatStr("sc","toomuchalert2");

      strreplace(sTemp, "\uA7", dlTab );
      strreplace(sTemp, "\uB0", g_asMaxLinesToDisplay);

      ChildPanelOnCentralModalReturn("vision/MessageWarning2",
                         getCatStr("sc","Attention"),
                         makeDynString(sTemp,
                                       getCatStr("general","OK"),
                                       getCatStr("sc","cancel")),
                         df, ds );
    }


    if( !df[1] )
    {
      aes_stopBusy( g_tabType );
      g_asDisplayLines = AES_DPQUERY_CANCELQUERY;
      setValue("", "deleteAllLines");
      setValue("", "visible",true);

      aes_doStop( g_propDp );
      aes_displayStatus();

      return false;
    }
    else
    {
      strreplace(sTemp,"\n"," ");
      g_asDisplayLines = AES_DPQUERY_CONTINUEQUERY;
    }
  }

  return true;
}


int aes_checkQueryError( dyn_errClass err, int iSystemId, int id=-1, bool fromDpQuery=false )
{
  int        iPos;
  int        errCode=-1;
  string     msg;
  string     sSystemName;
  int systemId;
  string errName;
  bool bShowWarningPopUps = true;
  string sAesShowDistDisconnections;
  
  
  // display PopUp on disconnection of Distsystem
  paCfgReadValue(PROJ_PATH+"config/config", "ui", "aesShowDistDisconnections", sAesShowDistDisconnections);
  if (sAesShowDistDisconnections!="")
    bShowWarningPopUps = (bool) sAesShowDistDisconnections;

  if( dynlen( err ) > 0 )
  {
    errCode = getErrorCode( err[1] );
    errName=  getErrorDpName( err[1] );
  }

  aes_debug( __FUNCTION__+"() / ERROR called from=" + id + " sysId=" + iSystemId + " errCode=" + errCode + " fromDpQuery=" + fromDpQuery, 0 );

  //DebugN(__FUNCTION__+"() / errCode=" + errCode ); 
  //DebugN(__FUNCTION__+"() / err=", err[1] ); 
 
  if( dynlen( err ) > 0 )
  { // Find out type of error


    errCode = getErrorCode( err[1] );
    
    if( iSystemId == AES_DUMMYSYSID )
      sSystemName = AES_DUMMYSYSNAME;   // in checked all mode we will use a dummy sysname
    else
      sSystemName = getSystemName( iSystemId );
    
    sSystemName = strrtrim( sSystemName, ":" );
    
    if( errCode == AES_ERR_REDUSWITCHED )
    {
      if ( !shapeExists("ar_currentLine") ) // If there is a row, show no error because of autom. reconnect
      {
        msg = getCatStr("sc","reduSwitched");
        strreplace(msg, "\uA7", "\n");
        ChildPanelOnCentral("vision/MessageWarning",
                            getCatStr("sc","Attention") + "_" + sSystemName,
                            makeDynString("$1:" + msg + sSystemName + " (" + iSystemId + ")" )
                           );
      }
      return AES_CHKERR_GOON;
    }
    else if( errCode == AES_ERR_REDUCONNLOST )
    {
      msg = getCatStr("sc","reduConnectionLost");
      strreplace(msg, "\uA7", "\n");
      ChildPanelOnCentral("vision/MessageWarning",
                          getCatStr("sc","Attention") + "_" + sSystemName,
                          makeDynString("$1:" + msg + sSystemName + " (" + iSystemId + ")" )
                         );
      return AES_CHKERR_GOON;
    }
    else if( errCode == AES_ERR_DISTCONLOST )
    {
      // this errcode will be treated in the reduDist function
      if (bShowWarningPopUps)
        aec_warningDialog( AEC_WARNINGID_DISTCONLOST, sSystemName );

      // the connection to all systems was lost
      if(iSystemId == 0)
      {
        int i;
        
        //remove the entries in the table for all distributed systems
        DebugFTN("aesDist",__LINE__,__FUNCTION__,gds_queryConnectedSystems);
        for(i=1;i<=dynlen(gds_queryConnectedSystems);i++)
        {
          string s_ownSystem;
    
          s_ownSystem = getSystemName();
          strreplace(s_ownSystem,":","");

          if(gds_queryConnectedSystems[i] != s_ownSystem)
          {
            DebugFTN("aesDist",__LINE__,__FUNCTION__,"aes_deleteSystemTableRows",gds_queryConnectedSystems[i]);
            aes_deleteSystemTableRows( gds_queryConnectedSystems[i] + ":" );
          }
        }
      }
      else
      {
        DebugFTN("aesDist",__LINE__,__FUNCTION__,"call aes_removeIdent4SysId - dist connection lost",iSystemId);
        aes_removeIdent4SysId( iSystemId, 1 );

        // in function aes_deleteSystemTableRows the system name is expected with ":" at the end
        DebugFTN("aesDist",__LINE__,__FUNCTION__,"call aes_deleteSystemTableRows",sSystemName);
        aes_deleteSystemTableRows( sSystemName + ":" );
      }

      //added update of line count when dist system lost
      aes_updateLineCount();
      aes_createDistInfo();
      return AES_CHKERR_GOON;
    }
    else if( errCode == AES_ERR_MAXALERTREQ )
    {
      aec_warningDialog( AEC_WARNINGID_MAXALERTREQ );

      // stop screen
//       aes_doStop( g_propDp );
//       aes_displayStatus();
      //return AES_CHKERR_GOON;
      return AES_CHKERR_ABORT;
    }
    else if( errCode == AES_ERR_SYNTAXERROR )
    {
      aec_warningDialog( AEC_WARNINGID_MAXALERTCON );

      // stop screen
//       aes_doStop( g_propDp );
//       aes_displayStatus();
      //return AES_CHKERR_GOON;
      return AES_CHKERR_ABORT;
    }
    else if( errCode == AES_ERR_MAXALERTCONRT )
    {
      aec_warningDialog( AEC_WARNINGID_MAXALERTCON );

      // stop screen
      aes_doStop( g_propDp );
      aes_displayStatus();
      return AES_CHKERR_GOON;
    }
    else if( errCode == AES_ERR_REDUOPENDISC )
    {
      unsigned propMode;
      bool valHistData;
      
      dpGetCache( g_propDp + ".Both.Timerange.Type" + AES_ONLVAL, propMode,
                  g_propDp + ".Both.Timerange.HistoricalData" + AES_ONLVAL, valHistData );
      
      if( ( propMode == AES_MODE_OPEN ) && valHistData )
      {
        aes_doRestart( g_propDp, FALSE);
      }
      else
      {
        if (this.lineCount() > 0)
        {
          // delete possible old information
          aes_deleteSystemTableRows( sSystemName +":" );
          // no dialog / im60442
          //aec_warningDialog( AEC_WARNINGID_REDUOPENDISC, sSystemName );

          systemId=getSystemId( (sSystemName+":") );
          aes_appendIdent4SysId( systemId );
        }
      }
      
      return AES_CHKERR_GOON;
    }
    else if( errCode == AES_ERR_MSGNOTSEND )
    {
    //line added to report that dist system did not reply when doing closed query
    //this makes sure that the dist info correctly reports system missing
      aes_removeIdent4SysId( iSystemId );

      // nothing to do rigth now
      // exception for dist system not connectable at start time !!!
      return AES_CHKERR_GOON;
    }
    else
    {
      // unexpected error and state - show dialog and stop screen
      throwError( err );
      errorDialog(err);
      
      aes_doStop( g_propDp );
      aes_displayStatus();
      return AES_CHKERR_GOON;
    }

    // Delete connect-Id
    aes_removeIdent4SysId( iSystemId );
  }

  return AES_CHKERR_GOON;
}


void aes_doIntervalChange( string propDpName, bool up, int tabType )
{

  time begin, end, diff;
  time nBegin, nEnd;

  string pre, app;

  //string setProp="visible";
  string setProp="enabled";
  int valSelection;


  aes_getPreApp4TabType( tabType, pre, app );

  // read begin and end time from propdp
  aes_getBeginEnd( propDpName, begin, end );
  diff=end-begin;

  dpGetCache( propDpName + ".Both.Timerange.Selection" + AES_ONLVAL, valSelection);
  // 1:  // today
  // 2:  // yesterday
  // 3:  // any day
  // 4:  // this week
  // 5:  // last week
  // 6:  // any timerange
  // 7:  // last 24 hours
    
  if( up )
  {
	  switch (valSelection)
	  {
	    case 2: valSelection = 1;break;  // yesterday -> today
	    case 5: valSelection = 4;break;  // last week -> this week
      default:break;
	  }
    
    //if ( valSelection == 3)
    //   diff += 3600.000;    // MEZ 

    // set other button
    setValue( pre + "pb_intervalDec", setProp, true);

    nBegin=begin + diff + 0.001;

    //if ( valSelection == 6)
    //   diff -= 1;    // 1 second 

    nEnd=nBegin + diff;

    if( nEnd >= getCurrentTime() )
    {
      //this.visible=false;
      this.enabled=false;
    }
    else
    {
      //this.visible=true;
      this.enabled=true;
    }
  }
  else
  {

	  switch (valSelection)
	  {
	    case 1: valSelection = 2;break;  // today -> yesterday
	    case 2: valSelection = 3;break;  // yesterday -> any day
	    case 4: valSelection = 5;break;  // this week -> last week
	    case 5: valSelection = 6;break;  // last week -> any timerange
	    case 7: valSelection = 6;break;  // last 24 hours -> any timerange
      default: break;
	  }

    //if ( valSelection == 6)
    //   diff -= 1;    // 1 second 

    // set other button
    setValue( pre + "pb_intervalInc", setProp, true);
    // down
    nBegin=begin - diff - 0.001;

    //if ( valSelection == 6)
    //   diff += 1;    // 1 second 

    nEnd=nBegin + diff;

    
    if( nBegin <= diff )
    {
      this.enabled=false;
    }
    else
    {
      this.enabled=true;
    }
  }

  // suppress automatic start when properties where set
  aes_runCmdStop( propDpName, 1 );
  
  // first we have to stop the query
  aes_doStop( propDpName );

  // set new begin/end time and restart query
  dpSetCache(  propDpName + ".Both.Timerange.Selection" + AES_ORIVAL, valSelection, 
              propDpName + ".Both.Timerange.Begin" + AES_ORIVAL, nBegin,
              propDpName + ".Both.Timerange.End" + AES_ORIVAL, nEnd );

  
  // ETM - #112990: 2014.03.13 calling aes_doStartInterval is not necessary
  // restart query
  //aes_doStartInterval( propDpName );

}

//////////////////////////////// printTable/tableToFile //////////////////////


void aes_saveTable(string fileName, dyn_dyn_anytype &tab)
{
  // for both - alerts/events => at automatic run !
  file fd;
  int i, j;

  if ( fileName == "" )
  {
    std_error("AS", ERR_SYSTEM, PRIO_SEVERE,
              E_AS_DP_VAL, "as_saveTable(fileName)");
    return;
  }

  fd = fopen(DATA_PATH + fileName, "w");

  if ( fd == false )
  {
    return;
  }

  for (i = 1; i <= dynlen(tab[1]); i++)     // order is [column][line]
  {
    for (j = 1; j <= dynlen(tab); j++)
      fprintf(fd, "%s\t", tab[j][i]);

    fprintf(fd, "\n");
  }

  fclose(fd);
}


void aes_as_printTable( string dpProp, string shapeName, bool showDialog )
{
  dyn_string header, footer;
  //string dpProp = as_getPropDP(true);
  string dummy;
  langString headerText;
  
  unsigned valState;
  string stateText;
  string valShortcut;
  string valPrio;
  string valDpComment;
  string valAlertText;
  dyn_string valDpList;
                          
  unsigned valType;
  time valBegin;
  time valEnd;
  
  dyn_int valTypeSelections;
  bool    valTypeAlertSummary;
  bool    bFirstType;
  int     i;
  string  valTypeFooter;
  
  dyn_string valSystemSelections;
  string     valSystemFooter;
  
  // TI 18225 - pallesch / variables for printTable()
  //bool    showDialog = true;
  //string  shapeName;
  int     columnsType=PT_VISIBLECOLUMNS;
  dyn_int columns=makeDynInt();
  bool    fitToPage=true;
  bool    landscape=true;
  bool    gridLines=true;
  bool    gridBackground=true;
  dyn_int margin=makeDynInt( 20,20,20,20 );
  string  printerName="";

  dpProp += ".";
   
  dpGetCache(dpProp + "Both.General.Header:_online.._value",       headerText,
  
        dpProp + "Alerts.FilterState.State:_online.._value",  valState,
        dpProp + "Alerts.Filter.Shortcut:_online.._value",    valShortcut,
        dpProp + "Alerts.Filter.Prio:_online.._value",        valPrio,
        dpProp + "Alerts.Filter.DpComment:_online.._value",   valDpComment,
        dpProp + "Alerts.Filter.AlertText:_online.._value",   valAlertText,
        dpProp + "Alerts.Filter.DpList:_online.._value",      valDpList,

        dpProp + "Both.Timerange.Type:_online.._value",       valType,
        dpProp + "Both.Timerange.Begin:_online.._value",      valBegin,
        dpProp + "Both.Timerange.End:_online.._value",        valEnd,
        
        dpProp + "Alerts.FilterTypes.Selections:_online.._value",    valTypeSelections,
        dpProp + "Alerts.FilterTypes.AlertSummary:_online.._value",  valTypeAlertSummary,
        
        dpProp + "Both.Systems.Selections:_online.._value",   valSystemSelections
       );
       
  // building footer for filterTypes and filterAlertSummary
  valTypeFooter = "";
  if( dynMax( valTypeSelections ) != 0 )
  {
    bFirstType = 0;
    for( i = 1; i <= dynlen( valTypeSelections ); i++ )
    {
      if( valTypeSelections[i] == 0 )
      {
        if( bFirstType == 0 )
        {
          valTypeFooter += AS_TYPEFILTER[i];
          bFirstType = 1;
        }
        else
          valTypeFooter += " | " + AS_TYPEFILTER[i];
      }
    }
    if( !bFirstType )
    {
      valTypeFooter += getCatStr("sc", "notDisplay");
    }
  }
  
  // building footer for systems
  valSystemFooter = "";
  for( i = 1; i <= dynlen( valSystemSelections ); i++ )
  {
    if( i != 1 )
      valSystemFooter += "  |  ";
    valSystemFooter += valSystemSelections[i];
  }
  
  
    switch ( valState )
    {
      case 0: stateText = getCatStr("sc", "all");       break;
      case 1: stateText = getCatStr("sc", "noack");     break;
      case 2: stateText = getCatStr("sc", "pending");   break;
      case 3: stateText = getCatStr("sc", "noackPend"); break;
      default:
        std_error("AS", ERR_PARAM, PRIO_WARNING, E_AS_DP_VAL, "");
        stateText = "????";
    }
  
  header[1] = "\\left{" + getCatStr("sc", "alerts") + "," +
              ((headerText == "") ? "" : (headerText + ",")) + 
              formatTime("%c", getCurrentTime()) + "}\\center{" +
              "}\\right{\\page/\\numpages}";
  
  // show timerange only in closed mode
  if(valType == 2)
  {
    header[2] = "\\left{" + formatTime("%c", valBegin) + " - " + formatTime("%c", valEnd)+ "}";
    header[3] = "\\fill{_}";
    header[4] = "\\tablehead";
    header[5] = "\\fill{_}";
  }
  else
  {
    header[2] = "\\fill{_}";
    header[3] = "\\tablehead";
    header[4] = "\\fill{_}";
  }
  footer[1] = "\\fill{_}";
  footer[2] = getCatStr("sc", "filter") + ":" + stateText + 
                ((valShortcut  == "") ? "" : ("|" + getCatStr("sc", "shortcut")     + valShortcut )) +
                ((valPrio      == "") ? "" : ("|" + getCatStr("sc", "prio")         + valPrio     )) +
                ((valDpComment == "") ? "" : ("|" + getCatStr("sc", "dpComment")    + valDpComment)) +
                ((valAlertText == "") ? "" : ("|" + getCatStr("sc", "alertText")    + valAlertText)) +
                ((valTypeFooter== "") ? "" : ("|" + getCatStr("sc", "types") + ": " + valTypeFooter)) +
                ((valTypeAlertSummary == 0) ? "" : ("|" + getCatStr("sc", "alert_summary"))) +
                ((valSystemFooter == "") ? "" : ("|" + getCatStr("sc", "systems") + ": " + valSystemFooter));

  if ( dynlen(valDpList) ) dynAppend(footer, getCatStr("sc", "dpList") + (dummy = valDpList));
  


  if( isMotif() )
  {
    setValue( shapeName, "printTable",
              header,
              makeDynString(),   // no special column attributes
              footer,
              _UNIX ? "AS_UNIX.cfg" : "AS_NT.cfg",  // config-file for Alert Screen
              PAPER_FORMAT_A4_COND,
              true,              // landscape ?
              false,             // all columns ?
              '|',               // delimiter
              0,                 // leftSpace 
              0);                // lineSpace
  }
  else
  {
    // TI 18225 - pallesch / new printTable() instead of setValue( "printTable" ...
    printTable( shapeName,
                showDialog,
                header,
                footer,
                columnsType,
                columns,
                fitToPage,
                landscape,
                gridLines,
                gridBackground,
                margin,
                printerName );
  }
}


void aes_es_printTable( string dpProp, string shapeName, bool showDialog )
{
  dyn_string header, footer;
  //string dpProp = es_getPropDP();
  string dummy, userbitstring;
  langString headerText;
  bit32 valUserbits;
  
  int i;
  
  string valDpComment;
  dyn_string valDpList;
             
  unsigned valType;
  time valBegin;
  time valEnd;
  
  dyn_int valTypeSelections;
  bool    bFirstType;
  int     n;
  string  valTypeFooter;
  
  dyn_string valSystemSelections;
  string     valSystemFooter;
  int        k;
  
  // TI 18225 - pallesch / variables for printTable()
  //bool    showDialog = true;
  //string  shapeName = "table";
  int     columnsType=PT_VISIBLECOLUMNS;
  dyn_int columns=makeDynInt();
  bool    fitToPage=true;
  bool    landscape=true;
  bool    gridLines=true;
  bool    gridBackground=true;
  dyn_int margin=makeDynInt( 20,20,20,20 );
  string  printerName="";

  dpProp += ".";
  
  dpGetCache(dpProp + "Both.General.Header:_online.._value",           headerText,
        dpProp + "Events.Filter.DpComment:_online.._value",       valDpComment,
        dpProp + "Events.Filter.DpList:_online.._value",          valDpList,
        dpProp + "Events.Filter.Userbits:_online.._value",        valUserbits,
                
        dpProp + "Both.Timerange.Type:_online.._value",           valType,
        dpProp + "Both.Timerange.Begin:_online.._value",          valBegin,
        dpProp + "Both.Timerange.End:_online.._value",            valEnd,
        
        dpProp + "Events.FilterTypes.Selections:_online.._value", valTypeSelections,
        
        dpProp + "Both.Systems.Selections:_online.._value",       valSystemSelections
       );
       
       
  // building footer for filterTypes and filterAlertSummary
  valTypeFooter = "";
  if( dynMax( valTypeSelections ) != 0 )
  {
    bFirstType = 0;
    for( n = 1; n <= dynlen( valTypeSelections ); n++ )
    {
      if( valTypeSelections[n] == 0 )
      {
        if( bFirstType == 0 )
        {
          valTypeFooter += ES_TYPEFILTER[n];
          bFirstType = 1;
        }
        else
          valTypeFooter += " | " + ES_TYPEFILTER[n];
      }
    }
    if( !bFirstType )
    {
      valTypeFooter += getCatStr("sc", "notDisplay");
    }
  }
  
  
  // building footer for systems
  valSystemFooter = "";
  for( k = 1; k <= dynlen( valSystemSelections ); k++ )
  {
    if( k != 1 )
      valSystemFooter += "  |  ";
    valSystemFooter += valSystemSelections[k];
  }
  
  
  for (i=1; i<=8; i++) 
  {
    if (getBit(valUserbits,(i+23)) == 1)
    {
      if (userbitstring == "")
      {
        userbitstring = " "+i;
      }
      else
      {
        userbitstring = userbitstring + ", "+i;
      }
    }
  }

  header[1] = "\\left{" + getCatStr("sc", "alerts") + "," +
              ((headerText == "") ? "" : (headerText + ",")) + 
              formatTime("%c", getCurrentTime()) + "}\\center{" +
              "}\\right{\\page/\\numpages}";
  
  // show timerange only in closed mode
  if(valType == 2)
  {
    header[2] = "\\left{" + formatTime("%c", valBegin) + " - " + formatTime("%c", valEnd)+ "}";
    header[3] = "\\fill{_}";
    header[4] = "\\tablehead";
    header[5] = "\\fill{_}";
  }
  else
  {
    header[2] = "\\fill{_}";
    header[3] = "\\tablehead";
    header[4] = "\\fill{_}";
  }
  footer[1] = "\\fill{_}";
  footer[2] = getCatStr("sc", "filter") + ":" + valDpComment;
  if ( dynlen(valDpList) ) dynAppend(footer, getCatStr("sc", "dpList") + (dummy = valDpList));
  if ( userbitstring != "" ) dynAppend(footer, getCatStr("sc", "Userbits") + (userbitstring));
  if ( valTypeFooter != "" ) dynAppend(footer, getCatStr("sc", "types") + ": " + (valTypeFooter));
  if ( valSystemFooter != "") dynAppend(footer, getCatStr("sc", "systems") + ": " + (valSystemFooter));

  if( isMotif() )
  {
    setValue( shapeName, "printTable",
              header,
              makeDynString(),   // no special column attributes
              footer,
              _UNIX ? "ES_UNIX.cfg" : "ES_NT.cfg",  // config-file for Event Screen
              PAPER_FORMAT_A4_COND,
              false,             // landscape ?
              false,             // all columns ?
              '|',               // delimiter
              0,                 // leftSpace 
              0);                // lineSpace
  }
  else
  {
    // TI 18225 - pallesch / new printTable() instead of setValue( "printTable" ...
    printTable( shapeName,
                showDialog,
                header,
                footer,
                columnsType,
                columns,
                fitToPage,
                landscape,
                gridLines,
                gridBackground,
                margin,
                printerName );
  }
}


void aes_as_tableToFile( string dpProp, string tableName )
{
  int        iCount;
  string     sFile;
  dyn_string dsFileNames;
  dyn_float  dfAnswer;
  dyn_string dsAnswer;

  string     sData;
  //string     dpProp;
  string     dummy;
  langString headerText;

  unsigned   valState;
  string     stateText;
  string     valShortcut;
  string     valPrio;
  string     valDpComment;
  string     valAlertText;
  dyn_string valDpList;
                          
  unsigned   valType;
  time       valBegin;
  time       valEnd;

  dyn_int    valTypeSelections;
  bool       valTypeAlertSummary;
  bool       bFirstType;
  int        i;
  string     valTypeFooter;
  dyn_string valSystemSelections;
  string     valSystemFooter;
  string     valDpListFooter;

  int        err;
  file       fFile;




  getValue( tableName, "lineCount", iCount );

  if( iCount <= 0 )
  {
    // No data available
    ChildPanelOnCentralModalReturn( "vision/MessageInfo",
                                    getCatStr( "general", "information" ),
                                    makeDynString( getCatStr( "sc", "noData" ),
                                                   getCatStr( "sc", "yes" ),
                                                   getCatStr( "sc", "no" )),
                                    dfAnswer, dsAnswer );
    if( dfAnswer[1] == 0 )
      return;
  }
  
  // Select file
  //fileSelector( sFile, getPath( DPLIST_REL_PATH ), false );
  fileSelector( sFile, getPath( DATA_REL_PATH ), false, "", false);
  if( strlen( sFile ) == 0 )
    return;
  else
  {
    // Check if file still exists

    if( isfile(sFile) )
    {
      // File exists. Ask to overwrite
      ChildPanelOnCentralModalReturn( "vision/MessageInfo",
                                      getCatStr( "general", "information" ),
                                      makeDynString( getCatStr( "sc", "overwrite" ),
                                                     getCatStr( "sc", "yes" ),
                                                     getCatStr( "sc", "no" )),
                                      dfAnswer, dsAnswer );
      if( dfAnswer[1] == 1 )
      {
        // Overwrite file
        setValue( tableName, "writeToFile", sFile, TABLE_WRITE_COLUMN_HEADER, "\t" );
      }
    }
    else
    {
      // File does not exist
      setValue( tableName, "writeToFile", sFile, TABLE_WRITE_COLUMN_HEADER, "\t" );
    }
  }
  
  
  //Writing Footer
  //dpProp = as_getPropDP("AlertScreen");
  
  dpGetCache(dpProp + ".Both.General.Header:_online.._value",             headerText,
  
        dpProp + ".Alerts.FilterState.State:_online.._value",        valState,
        dpProp + ".Alerts.Filter.Shortcut:_online.._value",          valShortcut,
        dpProp + ".Alerts.Filter.Prio:_online.._value",              valPrio,
        dpProp + ".Alerts.Filter.DpComment:_online.._value",         valDpComment,
        dpProp + ".Alerts.Filter.AlertText:_online.._value",         valAlertText,
        dpProp + ".Alerts.Filter.DpList:_online.._value",            valDpList,

        dpProp + ".Both.Timerange.Type:_online.._value",             valType,
        dpProp + ".Both.Timerange.Begin:_online.._value",            valBegin,
        dpProp + ".Both.Timerange.End:_online.._value",              valEnd,
        
        dpProp + ".Alerts.FilterTypes.Selections:_online.._value",   valTypeSelections,
        dpProp + ".Alerts.FilterTypes.AlertSummary:_online.._value", valTypeAlertSummary,
        
        dpProp + ".Both.Systems.Selections:_online.._value",         valSystemSelections
       );


  // Building footer for filterTypes and filterAlertSummary
  valTypeFooter = "";
  if( dynMax( valTypeSelections ) != 0 )
  {
    bFirstType = 0;
    for( i = 1; i <= dynlen( valTypeSelections ); i++ )
    {
      if( valTypeSelections[i] == 0 )
      {
        if( bFirstType == 0 )
        {
          valTypeFooter += AS_TYPEFILTER[i];
          bFirstType = 1;
        }
        else
          valTypeFooter += ", " + AS_TYPEFILTER[i];
      }
    }
    if( !bFirstType )
    {
      valTypeFooter += getCatStr("sc", "notDisplay");
    }
  }
  
  // Building footer for systems
  valSystemFooter = "";
  for( i = 1; i <= dynlen( valSystemSelections ); i++ )
  {
    if( i != 1 )
      valSystemFooter += ", ";
    valSystemFooter += valSystemSelections[i];
  }
  
  // Building footer for DP's
  valDpListFooter = "";
  for( i = 1; i <= dynlen( valDpList ); i++ )
  {
    if( i != 1 )
      valDpListFooter += ", ";
    valDpListFooter += valDpList[i];
  }
  
  switch ( valState )
  {
    case 0: stateText = getCatStr("sc", "all");       break;
    case 1: stateText = getCatStr("sc", "noack");     break;
    case 2: stateText = getCatStr("sc", "pending");   break;
    case 3: stateText = getCatStr("sc", "noackPend"); break;
    default:
      std_error("AS", ERR_PARAM, PRIO_WARNING, E_AS_DP_VAL, "");
      stateText = "????";
  }
  
  sData = "\n" +
          getCatStr( "sc", "alerts" ) + ", " + ((headerText == "") ? "" : (headerText + ",")) + 
          formatTime("%c", getCurrentTime()) + "\n" +
          formatTime("%c", valBegin) + " - " + formatTime("%c", valEnd) + "\n" +
          getCatStr("sc", "filter") + ":\n" + stateText + 
          ((valShortcut  == "") ? "" : ("\n" + getCatStr("sc", "shortcut")     + valShortcut )) +
          ((valPrio      == "") ? "" : ("\n" + getCatStr("sc", "prio")         + valPrio     )) +
          ((valDpComment == "") ? "" : ("\n" + getCatStr("sc", "dpComment")    + valDpComment)) +
          ((valAlertText == "") ? "" : ("\n" + getCatStr("sc", "alertText")    + valAlertText)) +
          ((valTypeFooter== "") ? "" : ("\n" + getCatStr("sc", "types") + ": " + valTypeFooter)) +
          ((valTypeAlertSummary == 0) ? "" : ("\n" + getCatStr("sc", "alert_summary"))) +
          ((valSystemFooter == "") ? "" : ("\n" + getCatStr("sc", "systems") + ": " + valSystemFooter)) +
          ((valDpList == "") ? "" : ("\n" + getCatStr("sc", "dpList") + " " + valDpListFooter));


  // Write data to file
  err = 0;
  fFile = fopen( sFile, "a" );
  err = ferror( fFile );

 if( err == 0 )
    fputs( sData, fFile );
  else
   ChildPanelOnCentralModal( "vision/MessageInfo1",
                              getCatStr( "general", "information"),
                              makeDynString( getCatStr( "ac", "notSaved" )));
  fclose( fFile );
}


void aes_es_tableToFile( string dpProp, string tableName )
{
  int        iCount;
  string     sFile;
  dyn_string dsFileNames;
  dyn_float  dfAnswer;
  dyn_string dsAnswer;

  string     sData;
  //string     dpProp;
  string     userbitstring;
  langString headerText;
  bit32      valUserbits;
    
  int        i;
  string     valDpComment;
  dyn_string valDpList;
  unsigned   valType;
  time       valBegin;
  time       valEnd;
  dyn_int    valTypeSelections;
  bool       bFirstType;
  int        n;
  string     valTypeFooter;
  dyn_string valSystemSelections;
  string     valSystemFooter;
  string     valDpListFooter;
  int        k;

  int        err;
  file       fFile;

  getValue( tableName, "lineCount", iCount );
  if( iCount <= 0 )
  {
    // No data available
    ChildPanelOnCentralModalReturn( "vision/MessageInfo",
                                    getCatStr( "general", "information" ),
                                    makeDynString( getCatStr( "sc", "noData" ),
                                                   getCatStr( "sc", "yes" ),
                                                   getCatStr( "sc", "no" )),
                                    dfAnswer, dsAnswer );
    if( dfAnswer[1] == 0 )
      return;
  }
  
  // Select file
  fileSelector( sFile, getPath( DATA_REL_PATH ), false, "", false);
  if( strlen( sFile ) == 0 )
    return;
  else
  {
    // Check if file still exists

    if( isfile(sFile) )
    {
      // File exists. Ask to overwrite
      ChildPanelOnCentralModalReturn( "vision/MessageInfo",
                                      getCatStr( "general", "information" ),
                                      makeDynString( getCatStr( "sc", "overwrite" ),
                                                     getCatStr( "sc", "yes" ),
                                                     getCatStr( "sc", "no" )),
                                      dfAnswer, dsAnswer );
      if( dfAnswer[1] == 1 )
      {
        // Overwrite file
        setValue( tableName, "writeToFile", sFile, TABLE_WRITE_COLUMN_HEADER, "\t" );
      }
    }
    else
    {
      // File does not exist
      setValue( tableName, "writeToFile", sFile, TABLE_WRITE_COLUMN_HEADER, "\t" );
    }
  }
  
  
  //Writing Footer
  //dpProp = es_getPropDP();
  
  dpGetCache(dpProp + ".Both.General.Header:_online.._value",        headerText,
        dpProp + ".Events.Filter.DpComment:_online.._value",    valDpComment,
        dpProp + ".Events.Filter.DpList:_online.._value",       valDpList,
        dpProp + ".Events.Filter.Userbits:_online.._value",     valUserbits,
                
        dpProp + ".Both.Timerange.Type:_online.._value",      valType,
        dpProp + ".Both.Timerange.Begin:_online.._value",     valBegin,
        dpProp + ".Both.Timerange.End:_online.._value",       valEnd,
        
        dpProp + ".Events.FilterTypes.Selections:_online.._value",     valTypeSelections,
        
        dpProp + ".Both.Systems.Selections:_online.._value",   valSystemSelections
       );


  // Building footer for filterTypes and filterAlertSummary
  valTypeFooter = "";
  if( dynMax( valTypeSelections ) != 0 )
  {
    bFirstType = 0;
    for( n = 1; n <= dynlen( valTypeSelections ); n++ )
    {
      if( valTypeSelections[n] == 0 )
      {
        if( bFirstType == 0 )
        {
          valTypeFooter += ES_TYPEFILTER[n];
          bFirstType = 1;
        }
        else
          valTypeFooter += ", " + ES_TYPEFILTER[n];
      }
    }
    if( !bFirstType )
    {
      valTypeFooter += getCatStr("sc", "notDisplay");
    }
  }
  
  // Building footer for systems
  valSystemFooter = "";
  for( k = 1; k <= dynlen( valSystemSelections ); k++ )
  {
    if( k != 1 )
      valSystemFooter += ", ";
    valSystemFooter += valSystemSelections[k];
  }
  
  
  for (i=1; i<=8; i++) 
  {
    if (getBit(valUserbits,(i+23)) == 1)
    {
      if (userbitstring == "")
      {
        userbitstring = " "+i;
      }
      else
      {
        userbitstring = userbitstring + ", "+i;
      }
    }
  }

  // Building footer for DP's
  valDpListFooter = "";
  for( i = 1; i <= dynlen( valDpList ); i++ )
  {
    if( i != 1 )
      valDpListFooter += ", ";
    valDpListFooter += valDpList[i];
  }
  
  sData = "\n" +
          getCatStr( "sc", "events" ) + "," + ((headerText == "") ? "" : (headerText + ",")) +
          formatTime("%c", getCurrentTime()) + "\n" +
          formatTime("%c", valBegin) + " - " + formatTime("%c", valEnd) + "\n" +
          getCatStr("sc", "filter") + ":" + 
          ((valDpComment    == "" ) ? "" : ("\n" + valDpComment )) +
          ((valDpListFooter == "" ) ? "" : ("\n" + getCatStr("sc", "dpList") + " " + valDpListFooter )) +
          ((userbitstring   == "" ) ? "" : ("\n" + getCatStr("sc", "Userbits") + ": " + userbitstring )) +
          ((valTypeFooter   == "" ) ? "" : ("\n" + getCatStr("sc", "types") + ": " + valTypeFooter)) +
          ((valSystemFooter == "" ) ? "" : ("\n" + getCatStr("sc", "systems") + ": " + valSystemFooter));

  // Write data to file
  err = 0;
  fFile = fopen( sFile, "a" );
  err = ferror( fFile );

 if( err == 0 )
    fputs( sData, fFile );
  else
   ChildPanelOnCentralModal( "vision/MessageInfo1",
                              getCatStr( "general", "information"),
                              makeDynString( getCatStr( "ac", "notSaved" )));
  fclose( fFile );
}



////////////////////////////////////////////////////////////////// printTable/tableToFile end //////////


void aes_doSaveTable( const string propDpName )
{
  dpSetCache( propDpName + ".Settings.Changed" + AES_ORIVAL, AES_CHANGED_SAVETABLE );
}


void aes_doPrintTable( const string propDpName )
{
  dpSetCache( propDpName + ".Settings.Changed" + AES_ORIVAL, AES_CHANGED_PRINTTABLE );
}


void aes_doStartInterval( const string propDpName )
{
   while (!dpExists(propDpName))
   {
      delay(0,100);
   }


  aes_doStart( propDpName );
}


void aes_doStart( const string propDpName, int dummy=999 )
{
  unsigned runMode;
  int n=1;
  
  //IM 64416: show dist connection changes on Play-button
  if (shapeExists("buRun"))
    buRun.color("_Button");
  
  while (!dpExists(propDpName))
  {
    delay(0,100);
  }


  dpSetCache( propDpName + ".Settings.Changed" + AES_ORIVAL, AES_CHANGED_RUNCMD,
             propDpName + ".Settings.RunCommand" + AES_ORIVAL, AES_RUNCMD_START );

}


void aes_doPropDialog( const string propDpName )
{
  dyn_string ds;
  dyn_float df;
  
  if (!getUserPermission(3))           // minimum permission operatorAll for opening properties 
  {  
    ChildPanelOnCentralModalReturn("vision/MessageWarning",
      getCatStr("para","warning"),
      makeDynString(getCatStr("general","permission")), df, ds);
     return;
  }
  dpSetCache( propDpName + ".Settings.Changed" + AES_ORIVAL, AES_CHANGED_PROPDIALOG );
}


void aes_doStop( const string propDpName )
{
  //IM 64416: show dist connection changes on Play-button
  if (shapeExists("buRun"))
    buRun.color("_Button");
  
  dpSetCache( propDpName + ".Settings.Changed" + AES_ORIVAL, AES_CHANGED_RUNCMD,
             propDpName + ".Settings.RunCommand" + AES_ORIVAL, AES_RUNCMD_STOP );
}


void aes_doPause( const string propDpName )
{
  dpSetCache( g_propDpName + ".Settings.Changed" + AES_ORIVAL, AES_CHANGED_RUNCMD,
             g_propDpName + ".Settings.RunCommand" + AES_ORIVAL, AES_RUNCMD_PAUSE );
}


void aes_removeIdent4SysId( int remSysId, bool b_distConnLost = FALSE )
{
  int n,l;
  int tabType, mode, systemId, mySystemId;
  bool fromProp;
  bool lostAllCon=false;

  mySystemId=getSystemId();

  // exception - ask C.Theis / if system like 0 or 255 we lost all dist connections ( excl. the own !! )
  if( remSysId == 0 || remSysId == 255 )
  {
    if( g_checkAll )
      lostAllCon=true;
    else
      lostAllCon=false;
  }
  
  l=dynlen( g_counterConnectId );

  for( n=l; n > 0; n-- )
  {
    aes_getInfoFromIdentifier( g_counterConnectId[n], tabType, mode, systemId, fromProp );
    if( ( systemId == remSysId  && systemId != mySystemId ) ||
      ( lostAllCon && ( systemId != mySystemId && systemId != AES_DUMMYSYSID ) ) )
    {
      // the g_counterConnectId is not removed when the dist connection is lost
      if(!b_distConnLost)
        dynRemove( g_counterConnectId, n );

      if( !g_checkAll )
        break;
    }
  }

  // we even have to remove closed list ids
  l=dynlen( g_closedIdf );
  for( n=l; n>0; n-- )
  {
    aes_getInfoFromIdentifier( g_closedIdf[n], tabType, mode, systemId, fromProp );
    if( ( systemId == remSysId  && systemId != mySystemId ) ||
      ( lostAllCon && ( systemId != mySystemId && systemId != AES_DUMMYSYSID ) ) )
    {
      dynRemove( g_closedIdf, n );

      if( !g_checkAll )
        break;
    }
  }

}


bool aes_appendClosedIdent4SysId( int sysId )
{
  string closedIdf;

  closedIdf=aes_createIdentifier( g_tabType, g_valType, sysId, true );

  if( dynContains( g_closedIdf, closedIdf ) <= 0 )
  {
    //aes_debug( __FUNCTION__+"() / Append closedIdf=" + closedIdf );
    dynAppend( g_closedIdf, closedIdf );
  }
}


bool aes_appendIdent4SysId( int sysId )
{
  const int d=5;

  string identifier=aes_createIdentifier( g_tabType, g_valType, sysId );
  
  
  if( dynContains( g_counterConnectId, identifier ) == 0 )
  {
    aes_debug( __FUNCTION__+"() Append ident=" + identifier, d );
    aes_appendIdentifier ( identifier );     
    aes_createDistInfo();
  }
  return true;
}


/*
  Main property connection routine
  @param none
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/
void aes_propControlCB(
  string dpCancel,        unsigned  valCancel,
  string dpRunCommand,    unsigned  valRunCommand,
  string dpChanged,       unsigned  valChanged )
{
  string screenConfigName;
  unsigned screenType;
  unsigned runMode;
  bool regTab=false;
  bool useRTValues=true;
  bool showDialog;
  mapping mTableMultipleRows;

  // acknowledge treating
  if( valChanged == AES_CHANGED_ACKSINGLE ||
      valChanged == AES_CHANGED_ACKALLVIS ||
      valChanged == AES_CHANGED_ACKALL )
  { 
    //added to keep consistency with previous versions
    //aes_propControlCB never passed row number to ack function so AES_CHANGED_ACKSINGLE was always changed to AES_CHANGED_ACKALLVIS
    if(valChanged == AES_CHANGED_ACKSINGLE)
      valChanged = AES_CHANGED_ACKALLVIS;
    
    //due to call back there is no easy way esnure consistent state of table now and at time action was triggered
    //synch used to ensure consistency at least while preparing the data for the ACK function
    synchronized(g_bTableLineSynchronisation)
    {      
      aes_prepareForTableAcknowledge(valChanged, g_tabType, mTableMultipleRows);    
    }
    aes_changedAcknowledgeWithRowData( valChanged, g_tabType, mTableMultipleRows );
  }

  // display property dialog
  if( valChanged == AES_CHANGED_PROPDIALOG )
  {
    aes_propertyDialog( g_tabType, true );
    return;
  }

  // interact print 
  if( valChanged == AES_CHANGED_PRINTTABLE )
  {
    showDialog=aes_getGeneralSettingsValue( CHK_DISPPDLG ); 

    if( g_screenType == AESTYPE_ALERTS )
    {
      aes_as_printTable( g_propDp, this.name, showDialog );
    }
    else
    {
      aes_es_printTable( g_propDp, this.name, showDialog );
    }
    return;
  }
  
  // interact save
  if( valChanged == AES_CHANGED_SAVETABLE )
  {
    if( g_screenType == AESTYPE_ALERTS )
    {
      // interactive save
      aes_as_tableToFile( g_propDp, this.name );
    }
    else
    {
      // interactive save
      aes_es_tableToFile( g_propDp, this.name );
    }
    return;
  }

  // treating for aeconfig changed - here because we have access to vst(n) variable

  // treating for aeconfig changed - here because we have access to vst(n) variable
  if( valChanged == AES_CHANGED_AECONFIG )
  {
    aes_changedAEConfig(); 
    return;
  }
  
  if( valChanged == AES_CHANGED_PROPCONFIG )
  {
    aes_changedPropConfig();
  }

  if( valChanged == AES_CHANGED_SCREENCONFIG )
  {
    // es wird nicht explizit ausgefuehrt - nur ueber zwei screenType changes
  }

  if( valChanged == AES_CHANGED_ACTIVITY )
  {
    aes_changedActivity( g_tabType );  
    return;
  }

  if( valChanged == AES_CHANGED_PROPORTION )
  {
    aes_changedProportion();  
    return;
  }

  if( valChanged == AES_CHANGED_REGTAB )
  {

    // ruft nur propConfig change - stoppt daher queries / nicht notwendig ????

    // nur mehr in funktion behandeln
    //aes_changedRegTab();
    
    // behandlung hier und in screenTypeChangeed entfernen !!!!!!!!!!!!!!
    regTab=true;
  }

  
  if( valChanged == AES_CHANGED_SCREENTYPE )
  {
    aes_getScreenType( g_propDp, screenType );
    // set screenType to scriptglobal variable for better performance
    g_screenType=screenType;
    // refresh register and tablesettings
    aes_changedScreenType( g_tabType, screenType, regTab );   // refrescht alles, auch activity
  }


// auch cancel abfangen !!!!!

  // special changed mode to perform processing
  if( valChanged == AES_CHANGED_RUNCMD )
  {
    // get current table runMode
    aes_getRunMode( g_propDp, runMode, __FUNCTION__ );

    if( valRunCommand == AES_RUNCMD_START )
    {
      aes_runCmdStart( runMode );
    }
    else if( valRunCommand == AES_RUNCMD_STARTINTERVAL )
    {
      aes_runCmdStart( runMode, true );
    }
    else if ( valRunCommand == AES_RUNCMD_PAUSE )
    {
      aes_runCmdPause( runMode );
    }
    else if ( valRunCommand == AES_RUNCMD_STOP )
    {
      aes_runCmdStop( "", 2);
    }
  }
}


void aes_runCmdStart( int runMode, bool interval=false )
{
  if( runMode == AES_RUNMODE_STOPPED )
  {
    g_firstHL=true;
    dpSetCache( g_propDp + ".Settings.RunMode" + AES_ORIVAL, AES_RUNMODE_RUNNING );
    
    // activate propertiesCB
    aes_triggerPropCB( g_propDp, interval );

    aes_startBusy( g_tabType );
  }
  else
  {
    //DebugN("QUERY STILL RUNNING" );
  }

  // write status to tabheader
  aes_displayStatus();
}


void aes_runCmdStop( string propDpName="", int dummy=999 )
{
  string workDpName;
  string pre, app;


  //aes_debug(__FUNCTION__+"() propDpName=", 5 );
  if( propDpName == "" )
    g_asDisplayLines=AES_DPQUERY_NOQUESTION;

  if( propDpName=="" )
  {
    // if we know g_propDp / function was called from table!!!
    workDpName=g_propDp;
  }
  else
  {  
    workDpName=propDpName;
  }

  // if a propdpname was entered we can leave function
  if( propDpName != "" )
  {
    // +/- wurde gedrueckt und kann nicht direkt ( nur ueber controlCB verarbeitet werden )
    // deshalb return - normaler stop aufruf erfolgt ohne propDpName da g_propDp verwendet wird
    return;
  }

  
  dpSetCache( workDpName + ".Settings.RunMode" + AES_ORIVAL, AES_RUNMODE_STOPPED );
  // runmodeset happens within function
  if(dynlen(g_counterConnectId) > 0)
  {
    DebugFTN("aesDist",__LINE__,__FUNCTION__,"call aes_queryDisconnect",g_counterConnectId);
    aes_queryDisconnect( g_counterConnectId );
  }

  aes_stopBusy( g_tabType );

  // write status to tabheader
  aes_displayStatus();

  aes_getPreApp4TabType( g_tabType, pre, app );

  // hide all objects
  setMultiValue(  pre + "pb_distInfo", "visible", false,
                  pre + "te_system", "visible", false,
                  pre + "pb_intervalInc", "visible", false,
                  pre + "pb_intervalDec", "visible", false );

}


void aes_runCmdPause( const int runMode )
{
  bool tableRunning;

  // changing table stop mode
  // read table "paused" status
  tableRunning=this.updatesEnabled;

  //toggle running state
  tableRunning=!tableRunning;
  
  // set new state
  this.updatesEnabled=tableRunning;

  // write status to tabheader
  aes_displayStatus();

}


void aes_getStatusString( string &statusString, const string propDpName="", bool fromMenu=false )
{
  const string sep=" / ";

  string sMode, sRunMode, sTabType, sScreenType, sPaused;
  string pre, app;
  string propDp;
  unsigned mode, runMode, tabType, screenType;

  bool tableRunning;

  statusString="";

  if( propDpName == "" )
  {
    propDp=g_propDp;
  }
  else
  {
    propDp=propDpName;
  }

  aes_getTabType( propDp, tabType );
  aes_getScreenType( propDp, screenType );
  aes_getPropMode( propDp, mode );   // (type) open, closed, current
  aes_getRunMode( propDp, runMode, __FUNCTION__ );

//aes_debug(__FUNCTION__+"() / runMode=" + runMode, 5 );

  aes_getPreApp4TabType( tabType, pre, app );
  
  // read table "paused" status
  tableRunning=this.updatesEnabled;

  // reading strings
  sTabType=aes_getTBStrLang( tabType );
  sScreenType=aes_getAEStrLang( screenType );
  sRunMode=aes_getRunModeStrLang( runMode );      // stopped/running
  sMode=aes_getModeStrLang( mode );               // open/closed/current

  sPaused=aes_getCatStr( "mid_paused" );

  // we need g_tabType, g_screenType, type(mode), runMode and the table paused state

  if( !tableRunning )
  {
    sRunMode = sPaused;
  }

  // write back text to tabheader
  // e.g. "Top / Alerts / Open / Running" 
  if( fromMenu )
  {
    statusString= sScreenType + sep +
                  sMode + sep +
                  sRunMode;
  }
  else
  {
    statusString= sTabType + sep +
                  sScreenType + sep +
                  sMode + sep +
                  sRunMode;
  }
}


void aes_getSettingsString( string &settings, const string propDpName="" )
{
  const string sep=" / ";

  string sMode, sRunMode, sTabType, sScreenType, sPaused;
  string pre, app;
  string propDp, modeText;
  unsigned mode, runMode, tabType, screenType;

  bool tableRunning;
  time begin, end;
  int maxLines;

  settings="";

  if( propDpName == "" )
  {
    propDp=g_propDp;
  }
  else
  {
    propDp=propDpName;
  }

  aes_getTabType( propDp, tabType );
  aes_getScreenType( propDp, screenType );
  aes_getPropMode( propDp, mode );   // (type) open, closed, current
  aes_getRunMode( propDp, runMode, __FUNCTION__ );

  aes_getPreApp4TabType( tabType, pre, app );
  
  // read table "paused" status
  tableRunning=this.updatesEnabled;

  // reading strings
  sTabType=aes_getTBStrLang( tabType );
  sScreenType=aes_getAEStrLang( screenType );
  sRunMode=aes_getRunModeStrLang( runMode );      // stopped/running
  sMode=aes_getModeStrLang( mode );               // open/closed/current

  sPaused=aes_getCatStr( "mid_paused" );

  //read time information
  aes_getBeginEnd( propDp, begin, end );
  aes_getMaxLines( propDp, maxLines );

  modeText=aes_getCatStr("mid_mode");
  settings=modeText + " : " + sMode;

  if( mode == AES_MODE_OPEN )
  {
    // append max lines
    settings=settings + "(" + maxLines + ")";
  }
  else if ( mode == AES_MODE_CLOSED )
  {
    string sBegin, sEnd;

    sBegin=formatTime( "%c", begin );
    sEnd=formatTime( "%c", end );

    // append begin/end time
    settings=settings + " : " + sBegin + " - " + sEnd;
  }

}


void aes_displayStatus()
{
  bool paused;
  int runMode, propMode;

  string regTab, headerText, sRunMode;
  string pre, app;

  bool pmVis=false;
  bool ackVis=false;
  bool denyava=false;
  bool checkAll;
  
  string settings="";
  string mySystem;
  dyn_string systemSelections;

  aes_getRunMode( g_propDp, runMode, __FUNCTION__ );
  aes_getPropMode( g_propDp, propMode );
  aes_getSystemSelections( g_propDp, systemSelections );
  aes_getCheckAll( g_propDp, checkAll );
  
  sRunMode=aes_getRunModeStrLang( runMode );      // stopped/running
//aes_debug(__FUNCTION__+"() / runMode=" + runMode, 5 );

  aes_getPreApp4TabType( g_tabType, pre, app );
  
  // build status string
  aes_getStatusString( headerText );

  regTab=aes_getTabName4TabType( g_tabType );

  // set tabheader and runmode textbox
  setMultiValue( AES_REGMAIN, "namedColumnHeader", regTab, headerText,
                 pre + "te_mode", "text", sRunMode );

//aes_debug(__FUNCTION__+"() / tab=" + headerText + " textBox=" + sRunMode, 5 );


  // test treat settings textbox
  // possible function call to create aes_getSettingsString()

  mySystem=getSystemName();
  mySystem=substr( mySystem, 0, strlen( mySystem ) - 1 ); // remove trailing :

  if( dynlen( systemSelections ) > 1 || ( (dynlen( systemSelections ) == 1 ) && ( dynContains( systemSelections, mySystem ) <= 0 ) ) || checkAll )
  {
    setMultiValue(  pre + "pb_distInfo", "visible", true,
                    pre + "te_system", "visible", true );

    //if( runMode == AES_RUNMODE_RUNNING || ( propMode == AES_MODE_CLOSED ) )
    if( runMode == AES_RUNMODE_RUNNING )
    {
      setValue( pre + "pb_distInfo", "enabled", true );

      aes_getSettingsString( settings );
    }
    else
    {
      setValue( pre + "pb_distInfo", "enabled", false );

      // delete content if stopped
      setMultiValue(  pre + "te_system", "text", "",
                      pre + "te_system", "backCol", "_3DFace" );

      aes_dpSetDistInfo( g_propDp, makeDynString( "" ) );
    }

  }
  else
  {
    // hide all objects
    setMultiValue(  pre + "pb_distInfo", "visible", false,
                    pre + "te_system", "visible", false );
  }
  
  if( runMode == AES_RUNMODE_RUNNING )
  {
    aes_getSettingsString( settings );
  } 
  else
  {
    settings="";
  }

  setMultiValue(  pre + "te_settings", "text", settings );

  // treat +/- closed mode button visibility
  if( propMode == AES_MODE_CLOSED )
  {
    pmVis=true;
  }
  else
  {
    pmVis=false;
  }



  setMultiValue( pre + "pb_intervalInc", "visible", pmVis,
                 pre + "pb_intervalDec", "visible", pmVis );
//  setMultiValue( pre + "pb_intervalInc", "enabled", pmVis,
//                 pre + "pb_intervalDec", "enabled", pmVis );
  
  // treat acknowledge button visibility
  denyava=aes_getGeneralSettingsValue( CHK_DENYAVA ); 
  if( g_screenType == AESTYPE_ALERTS )
  {
    if( denyava )
    {
      ackVis=false;
    }
    else
    {
      if( propMode != AES_MODE_CLOSED )
      {
        ackVis=true;
      }
      else
      {
        ackVis=false;
      }
    }
  }
  else
  {
    ackVis=false;
  }

  // currently only allAck in use !!!
  //setMultiValue( pre + "pb_singleAck", "enabled", ackVis,
  //               pre + "pb_allAck",    "enabled", ackVis );

  setMultiValue(  pre + "pb_allAck", "enabled", ackVis,
                  pre + "pb_allAck", "visible", ackVis );


}

void aes_dpSetDistInfo( string propDp, dyn_string dsNew )
{
  int dlOld, dlNew;
  dyn_string dsOld;

  dpGetCache( propDp + ".Settings.DistInfo" + AES_ONLVAL, dsOld );

  dlOld=dynlen( dsOld );
  dlNew=dynlen( dsNew );

  if( dlOld == 0 )
  {
    dpSetCache( propDp + ".Settings.DistInfo" + AES_ORIVAL, dsNew );
    return;
  }

  if( ( dsOld[1] != dsNew[1] ) ||
      ( dlOld != dlNew ) )
  {
    dpSetCache( propDp + ".Settings.DistInfo" + AES_ORIVAL, dsNew );
    return;
  }

  // index 1 matches and dynlen is the same
  if( dlNew == 2 )
  {
    if( dsOld[2] != dsNew[2] )
    {
      dpSetCache( propDp + ".Settings.DistInfo" + AES_ORIVAL, dsNew );
    }
  }

}

void aes_dpSetBusy( string propDp, int val )
{
  int curVal;

  dpGetCache( propDp + ".Settings.BusyTrigger" + AES_ONLVAL, curVal );


  if( curVal != val )
    dpSetCache( propDp + ".Settings.BusyTrigger" + AES_ORIVAL, val );
}


string aes_getTabName4TabType( const int tabType )
{

  if( tabType == AESTAB_TOP )
    return AES_TABNAME_TOP;
  else if( tabType == AESTAB_BOT )
    return AES_TABNAME_BOT;
  else if( tabType == AESTAB_GENERAL )
    return AES_TABNAME_GENERAL;

  return "";
}


void aes_getPreApp4TabType( const unsigned tabType, string &pre, string &app )
{
  if( tabType == AESTAB_TOP )
  {
    app=_AESTAB_TOP;
    pre=AES_TABNAME_TOP + ".";
  }
  else if ( tabType == AESTAB_BOT )
  {
    app=_AESTAB_BOT;
    pre=AES_TABNAME_BOT + ".";
  }
}


void aes_treatOldConfigs( const int screenType, const string object )
{
  dyn_string dsRealNames, dsDpNames;
  dyn_bool dbDefaults;

  // reading all available properties for screenType
  aes_getDpsPerType( dsRealNames, dsDpNames, dbDefaults, AES_DPTYPE_PROPERTIES, screenType, false, AES_ARPROP_EXCL ); //  EXCL error at defaultarguments !!!

  setValue( object, "items", dsRealNames );

}


//NOT USED anymore - AES uses aes_changedAcknowledgeWithRowData instead
void aes_changedAcknowledge( unsigned ackType, int tabType, int row=-1 )
{
  // ACHTUNG - problem aus altem as betr. finde aeltesten alarm !!!
  string propDp;

  string myTable;
  int from=0, to=0;

  if( tabType == AESTAB_TOP )
  {
    myTable=AES_TABLENAME_TOP;
  }
  else
  {
    myTable=AES_TABLENAME_BOT;
  }

  if( ackType == AES_CHANGED_ACKSINGLE )
  {
    // acknowledge all visible alerts of object - from,to == row ( only one line )
    ep_acknowledgeTableFunction( myTable, 1, _DPID_, _TIME_, _COUNT_, _ACKABLE_, row, row );
  }
  else if( ackType == AES_CHANGED_ACKALLVIS )
  {
    // acknowledge all visible alerts of object
    ep_acknowledgeTableFunction( myTable, 1, _DPID_, _TIME_, _COUNT_, _ACKABLE_ );
  }
  else if ( ackType == AES_CHANGED_ACKALL )
  {
    getValue( myTable, "lineCount", to );
    to--; // decrement because from starts at zero !
    ep_acknowledgeTableFunction( myTable, 1, _DPID_, _TIME_, _COUNT_, _ACKABLE_, from, to );
  }

}

//!!changed function signature - can keep compatible with old one?
void aes_changedAcknowledgeWithRowData( unsigned ackType, int tabType, mapping mTableMultipleRows )
{
  // ACHTUNG - problem aus altem as betr. finde aeltesten alarm !!!
  string propDp;

  string myTable;

  if( tabType == AESTAB_TOP )
  {
    myTable=AES_TABLENAME_TOP;
  }
  else
  {
    myTable=AES_TABLENAME_BOT;
  }

  aes_acknowledgeTableFunction( myTable, 1, mTableMultipleRows );
}


aes_doAckSingle( const string propDpName )
{
  // sollte nur von OnClick aufgerufen werden !
  dpSetCache( propDpName + ".Settings.Changed" + AES_ORIVAL, AES_CHANGED_ACKSINGLE );
}


aes_doAckVisible( const string propDpName )
{
  dpSetCache( propDpName + ".Settings.Changed" + AES_ORIVAL, AES_CHANGED_ACKALLVIS );
}


aes_doAckAll( const string propDpName )
{
  dpSetCache( propDpName + ".Settings.Changed" + AES_ORIVAL, AES_CHANGED_ACKALL );
}


void aes_changedPropConfig(bool bChangeAesType=false)
{
  const int d=0;

  string activeReg, config, app, pre, balApp, balPre;
  dyn_string configs;

  string configTop, configBot;
  unsigned sctTop, sctBot, mySct, balSct, balTabType;
  unsigned propMode;

  unsigned tabType=g_tabType;

  dyn_string visibleColumns;
  int screenType;
  string dpSource, dpTarget, propName;

  aes_runCmdStop( "", 3 );
  
  while (!dpExists(g_propDp))
  {
    delay(0,100);
  }
  aes_getScreenType( g_propDp, screenType );
  aes_getConfig( g_propDp, propName );

  aes_getDpName4RealName( propName, AES_DPTYPE_PROPERTIES, screenType, dpSource );

  // copy properties
  dpTarget=g_propDp;
  aes_copyProperties( dpSource, dpTarget, screenType );



  // find out active registertab
  getValue( AES_REGMAIN, "namedActiveRegister", activeReg );

  // read config settings from active tab and set it to balancing tab
  aes_getPreApp4TabType( tabType, pre, app );

  aes_getScreenType( g_propDpNameTop, sctTop );
  aes_getScreenType( g_propDpNameBot, sctBot );

  if( tabType == AESTAB_TOP )
  {
    mySct=sctTop;
    balSct=sctBot;
    balTabType=AESTAB_BOT;
  }
  else
  {
    mySct=sctBot;
    balSct=sctTop;
    balTabType=AESTAB_TOP;
  }

  aes_debug(__FUNCTION__+" tabType="+tabType + " activeReg=" + activeReg + " mySct=" + mySct + " balSct=" + balSct, d );


//  in zukunft alle informationen nur mehr von DP!!! LESEN
// DP muss um configs (dyn_string) erweitert werden
// Auch "active" soll auf DP schreiben !!!

  // read config settings from balanced tab
  aes_getPreApp4TabType( balTabType, balPre, balApp );
  if (bChangeAesType==false)
  {
    if( activeReg == AES_TABNAME_GENERAL )
    {
      // get items of my tabType ( general )
      getValue(  "cb_config" + app, "items", configs );
      // set items to my tabType ( top/bot )
      setValue(  pre + "cb_config", "items", configs );   // now on OnFocus()
      // check balancing tabtype and set itmes even if its necessary
      if( mySct == balSct )
      {
        //  ACHTUNG - PRUEFUNG ob config aktiv, der sich in liste nicht mehr befindet !!!!
        // set items to bal tabType ( general )
        setValue( "cb_config" + balApp, "items", configs );
        // set items to bal tabType ( top/bot )
        setValue( balPre + "cb_config", "items", configs );
      }

      // update selected config
      getValue(  "cb_config" + app, "text", config );
      // set values in top/bot tab
      setValue( pre + "cb_config", "text", config );
    }
    else
    {
      // get items of my tabType ( top/bot )
      getValue(  pre + "cb_config", "items", configs );
      // set items to my tabType ( general )
      setValue( "cb_config" + app, "items", configs );   // now on OnFocus
      // check balancing tabtype and set itmes even if its necessary
      if( mySct == balSct )
      {
        // set items to bal tabType ( general )
        setValue( "cb_config" + balApp, "items", configs );
        // set items to bal tabType ( top/bot )
        setValue( balPre + "cb_config", "items", configs );   // now on OnFocus
      }

      // read from top/bot
      getValue(  pre + "cb_config", "text", config );
    
      // set to general
      setValue(  "cb_config" + app, "text", config );
    }
  }
  aes_getVisibleColumns( g_propDp, visibleColumns );
  aes_initTable( this.name, screenType, visibleColumns ); 

  // clear table and lineCount
  this.deleteAllLines();
  setValue(  pre + "te_rows", "text", "" );

  aes_displayStatus();
}


void aes_getPropDpName4TabType( const int tabType, string &propDp)
{

  if( tabType == AESTAB_TOP )
  {
    propDp=g_propDpNameTop;
  }
  else
  {
    propDp=g_propDpNameBot;
  }

}


void aes_changedRegTab()
{
  const int d=5;
  aes_debug( __FUNCTION__, d );

  // right now we only have to consider the properties comboboxes
  aes_changedPropConfig(); 

}


void aes_changedAEConfig()
{
    string screenConfigName;

    aes_runCmdStop( "", 4);

    aes_reload();

    // read config name from panel
    screenConfigName=cb_aesConfig.text; 
    // reinit both tables - without reloading settings from dp / dont overwrite RT Dp values
    aes_treatScreenConfigChange( AESTAB_TOP, screenConfigName, useRTValues );   // jetzt in lib
    aes_treatScreenConfigChange( AESTAB_BOT, screenConfigName, useRTValues );   // jetzt in lib

    // clear both line counts
    setMultiValue(  "tab_top.te_rows", "text", "",
                    "tab_bot.te_rows", "text", "" );

}


void aes_changedScreenType( const unsigned tabType, unsigned screenType, const bool regChanged=false )
{
  string propDpName, pre, app;
  bool vis;
  string headerText, tbText, sctText, modeText, regTab, mode;
  dyn_string visibleColumns;

  aes_runCmdStop("", 5);

  aes_debug(__FUNCTION__+"() - tabType="+tabType+" screenType="+screenType+" name="+this.name );

  aes_getVisibleColumns( g_propDp, visibleColumns );

  // delete table content
  this.deleteAllLines();

  // 3 exchange config settings is not needed here, because will be done by aes_treatScreenConfigChange() for both tables
  aes_changedPropConfig(true);

  // 5 treat proportion/activity settings and resize and manage tablescale and visibility
  aes_changedActivity( tabType ); 

  aes_displayStatus();

}


/*
  Used in AS_propTime and ES_propTime panel for updating the historical data interval shapes when the corresponding radio box was changed
  @param none
  @author cboehm
  @version 1.0
  @return nothing
*/
void aes_changedPropsTimeHistDataInterval()
{
  int iHistDataIntervalConfig, iNumber;

  getValue("ti_HistoricalDataInterval", "number", iNumber);
  
  if(iNumber == 0)  //Central setting for HistDataInterval
  {
    dpGetCache("_Config.HistoricalDataInterval", iHistDataIntervalConfig);
    
    setValue("txtHistoricalDataInterval", "enabled", false,
                                          "text", iHistDataIntervalConfig);  //Reset the displayed interval to the central setting value
  }
  else if(iNumber == 1)  //User defined setting for HistDataInterval
  {
    setValue("txtHistoricalDataInterval", "enabled", true);  //The user defined interval will be only set once on init by aes_getPropsTime
  }
}


/*
  Used in AS_propTime and ES_propTime panel for updating the historical data interval shapes when the display setting for historical data was changed
  @param none
  @author cboehm
  @version 1.0
  @return nothing
*/
void aes_changedPropsTimeHistDataDisplay(bool bHistDataState)
{
  setMultiValue("lblInterval", "visible", bHistDataState,  //Display the shapes for the historical data interval selection only if historical data is displayed
                "ti_HistoricalDataInterval", "visible", bHistDataState,
                "txtHistoricalDataInterval", "visible", bHistDataState,
                "lblHistoricalDataInterval", "visible", bHistDataState);
}


void aes_initBoth()
{
  string panelName, rootName, oldName; 
  int screenType;

  string tc, ts, ta;

  while (!isDollarDefined(AESREGDOLLAR_TABTYPE))
  {
    delay(1); 
  }

  g_tabType=aes_getTBNum( getDollarValue(AESREGDOLLAR_TABTYPE) );
  g_propDpName=getDollarValue(AESREGDOLLAR_PROPDP);
  g_balPropDpName=getDollarValue(AESREGDOLLAR_BALPROPDP);

// geht nicht bei panel => nur bei object
  rootName=getDollarValue(AESREGDOLLAR_TABNAME) + ".";

  // we have to update the following object names to access them unequivocal from outside

  setMultiValue(
    "cb_config", "name", rootName + "cb_config", 
    "pb_singleAck", "name", rootName + "pb_singleAck", 
    "pb_allAck", "name", rootName + "pb_allAck", 
    "te_settings", "name", rootName + "te_settings", 
//  "te_screenType", "name", rootName + "te_screenType", 
    "te_rows", "name", rootName + "te_rows", 
    "te_mode", "name", rootName + "te_mode", 

    "pb_intervalInc", "name", rootName + "pb_intervalInc", 
    "pb_intervalDec", "name", rootName + "pb_intervalDec", 

    "te_system", "name", rootName + "te_system", 
    "pb_distInfo", "name", rootName + "pb_distInfo");

  //"te_hidden", "name", rootName + "te_hidden", 
  //"te_busy", "name", rootName + "te_busy");

  // init busy trigger
  aes_initBusy();

  aes_getScreenType( g_propDpName, screenType );
  aes_treatOldConfigs( screenType, rootName + "cb_config");

}


void aes_propertyDialog( int tabType, bool fromGeneral=false, bool alertRow=false, bool configPanel=false )
{

  // the general flag is only important for propertyname variables
  // if general g_propDpNameTop if not g_propDpName

  
  // code from general !!!
  shape sConfig;
  string configName, balConfigName;
  int retState, balTabType;

  dyn_string newConfigList;
  unsigned newSelPos;

  string cbName, pre, app, tmp;
  string propDpName, balPropDpName;
  string objName, balObjName, objConfig, balObjConfig;
  string val, balVal;
  int screenType, balScreenType;

  tmp="cb_config";

  // if we are in config panel - we have to create dummy runtime dp's
  if( configPanel )
  {


    if( tabType == AESTAB_TOP )
    {
      objName     ="cb_screenTypeTop";
      objConfig   ="cb_configTop";
      balObjName  ="cb_screenTypeBot";
      balObjConfig="cb_configBot";
      balTabType  = AESTAB_BOT;
    }
    else
    {
      objName     ="cb_screenTypeBot";
      objConfig   ="cb_configBot";
      balObjName  ="cb_screenTypeTop";
      balObjConfig="cb_configTop";
      balTabType  = AESTAB_TOP;
    }

    // getting screenTypes from panel
    getMultiValue(
      objName,    "selectedText", val,
      balObjName, "selectedText", balVal );

    screenType=aes_getAENumLang( val );
    balScreenType=aes_getAENumLang( balVal );

    // add dummy runtime prop dp
    aes_addPropertyDp( tabType, propDpName, true );

    // add dummy balanced runtime prop dp
    aes_addPropertyDp( balTabType, balPropDpName, true );


    // set tabType and screenType
    dpSetCache(  propDpName    + ".Settings.ScreenType"  + AES_ORIVAL, screenType,
                propDpName    + ".Settings.TabType"     + AES_ORIVAL, tabType,
                balPropDpName + ".Settings.ScreenType"  + AES_ORIVAL, balScreenType,
                balPropDpName + ".Settings.TabType"     + AES_ORIVAL, balTabType );
    
  }
  else
  {
    aes_getPreApp4TabType( tabType, pre, app );
    if( fromGeneral )
    {
      cbName=tmp + app;

      if( tabType == AESTAB_TOP )
      {
        propDpName=g_propDpNameTop;
        balPropDpName=g_propDpNameBot;
      }
      else
      {
        propDpName=g_propDpNameBot;
        balPropDpName=g_propDpNameTop;
      }
    }
    else
    {
      cbName=pre + tmp;

      if( tabType == AESTAB_TOP )
      {
        propDpName=g_propDpName;
        balPropDpName=g_balPropDpName;
      }
      else
      {
        propDpName=g_propDpName;
        balPropDpName=g_balPropDpName;
      }
    }
  }


  if( configPanel )
  {
    string dpSource;

    getMultiValue(  objConfig,    "text", configName,
                    balObjConfig, "text", balConfigName );

    // get dp name from objConfig !
    aes_getDpName4RealName( configName, AES_DPTYPE_PROPERTIES, screenType, dpSource );

    // copy properties to rt dp
    aes_copyProperties( dpSource, propDpName, screenType, configPanel );  // uses aes_getVisibleColumnList !!!!!!!!!!!!!!!!!!!!
  }
  else
  {
    cbName=pre + tmp;

    sConfig=getShape( cbName ); 
    configName=sConfig.text;
  }

  aes_doPropertyChild( propDpName, balPropDpName, configName, tabType, newConfigList, newSelPos, retState, alertRow, configPanel );

  if( configPanel )
  {

    // delete temp property config dp names / we have the permission because only a para user can open the panel
    dpRemoveCache( propDpName ); 
    dpDelete( propDpName );
    dpRemoveCache( balPropDpName ); 
    dpDelete( balPropDpName );

    // update itemlist in any case
    setValue( objConfig, "items", newConfigList );

    if( retState == AES_CONF_OK )
    {
      setValue( objConfig, "selectedPos", newSelPos );
    }

    if( screenType == balScreenType )
    {
      // update balanced config list
      setValue( balObjConfig, "items", newConfigList );
      if( dynContains( newConfigList, balConfigName ) <= 0 )
      {
        if( dynlen( newConfigList ) > 0 )
          setValue( balObjConfig, "selectedPos", 1 );
      }
    }
  }
  else
  {
    // write back new config information
    sConfig.items=newConfigList;

    // if ok- restart 
    if( retState == AES_CONF_OK )
    {
      if( newSelPos >= 0 )
      {
        sConfig.selectedPos=newSelPos;
      }
      aes_doRestart(propDpName, 1 );
    }
  }
}


void aes_changedProportion()
{
  // in this function we only have to set unaccesible object properties
  
  int proportion, tabType;
  
  aes_getTabType( g_propDp, tabType );

  aes_getProportion( g_propDp, proportion );

  aes_checkPercent( proportion );
  sl_gauge.value=proportion;
  
  // set table propoertion
  aes_setSplitPosition( g_top, g_bottom, proportion );

}


void aes_changedActivity( const int tabType )
{
  bool activeTop, activeBot, myState;
  int propTop;
  string pre, app;

  aes_runCmdStop( "", 6 );

  // getting both activity states from db - using panlglobal variables
  aes_getActivity( g_propDpNameTop, activeTop );
  aes_getActivity( g_propDpNameBot, activeBot );

  // get own state from scriptglobal dp
  aes_getActivity( g_propDp, myState );

  // get proportion from db, we need only the top one
  aes_getProportion( g_propDpNameTop, propTop );

  // set registertab visibility, depending on activity
  setValue( AES_REGMAIN,
            "namedRegisterVisible", AES_TABNAME_TOP, activeTop,
            "namedRegisterVisible", AES_TABNAME_BOT, activeBot );


  aes_getPreApp4TabType( tabType, pre, app );

  // treat properties button
  setMultiValue( "pb_properties" + app, "enabled", myState,
                 "cb_screenType" + app, "enabled", myState,
                 "cb_config" + app, "enabled", myState );

  //aes_debug( __FUNCTION__+"() / tabType=" + tabType + " actTop=" + activeTop + " actBot=" + activeBot );


//aes_debug( __FUNCTION__+"() / aTop=" + activeTop + " aBot=" + activeBot, 5 );

  // if both were active, set split position and leave function
  if( activeTop && activeBot )
  {
    aes_setSplitPosition( g_top, g_bottom, propTop );

    aes_enableProportion( true );
  }
  else
  {
    aes_enableProportion( false );

    // if only one is active, set it to full size
    if( activeTop )
    {
      aes_setTopFullSize( g_top, g_bottom, true );
    }
    else
    {
      aes_setBottomFullSize( g_top, g_bottom, true );
    }
  }

}


/*
  Main property connection routine
  @param none
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/
void aes_doPropertiesConnect( int &ret )
{
  // propDP - scriptglobal variable
  const string cbName="aes_propertiesCB";
  const string ovl=":_online.._value";

  const string alerts =".Alerts.";
  const string events =".Events.";
  const string both   =".Both.";

  const string filter     ="Filter.";
  const string filterTypes="FilterTypes.";
  const string filterState="FilterState.";

  const string timerange="Timerange.";
  const string systems  ="Systems.";
  const string sorting  ="Sorting.";
  const string visible  ="Visible.";
  const string general  ="General.";

  ret=0;

  if( dpConnect( cbName, false,
        //////
        //alerts
        g_propDp + alerts + filter + "Shortcut" + AES_ONLVAL,
        g_propDp + alerts + filter + "Prio" + AES_ONLVAL,
        g_propDp + alerts + filter + "DpComment" + AES_ONLVAL,
        g_propDp + alerts + filter + "AlertText" + AES_ONLVAL,
        g_propDp + alerts + filter + "LogicalCombine" + AES_ONLVAL,
        g_propDp + alerts + filter + "DpList" + AES_ONLVAL,
        g_propDp + alerts + filter + "BLEComment" + AES_ONLVAL,         // new - BLE
        
        //////
        g_propDp + alerts + filterTypes + "Selections" + AES_ONLVAL,
        g_propDp + alerts + filterTypes + "AlertSummary" + AES_ONLVAL,
        //////
        g_propDp + alerts + filterState + "State" + AES_ONLVAL,
        g_propDp + alerts + filterState + "OneRowPerAlert" + AES_ONLVAL,
        g_propDp + alerts + filterState + "OpenClosedMode" + AES_ONLVAL,
        g_propDp + alerts + filterState + "Direction" + AES_ONLVAL,
        //////
        //events
        g_propDp + events + filter + "DpComment" + AES_ONLVAL,
        g_propDp + events + filter + "DpList" + AES_ONLVAL,
        g_propDp + events + filter + "Userbits" + AES_ONLVAL,
        g_propDp + events + filter + "BLEComment" + AES_ONLVAL,        // new - BLE
        //////
        g_propDp + events + filterTypes + "Selections" + AES_ONLVAL,
        //////
        //both
        g_propDp + both + timerange + "Type" + AES_ONLVAL,
        g_propDp + both + timerange + "Begin" + AES_ONLVAL,
        g_propDp + both + timerange + "End" + AES_ONLVAL,
        g_propDp + both + timerange + "CameWentSort" + AES_ONLVAL,
        g_propDp + both + timerange + "HistoricalData" + AES_ONLVAL,
        g_propDp + both + timerange + "MaxLines" + AES_ONLVAL,
        g_propDp + both + timerange + "Selection" + AES_ONLVAL,
        g_propDp + both + timerange + "Shift" + AES_ONLVAL,
        //////
        g_propDp + both + systems + "Selections" + AES_ONLVAL,
        g_propDp + both + systems + "CheckAllSystems" + AES_ONLVAL,
        //////
        g_propDp + both + sorting + "SortList" + AES_ONLVAL,
        //////
        g_propDp + both + visible + "VisibleColumns" + AES_ONLVAL,
        //////
        g_propDp + both + general + "Header" + AES_ONLVAL,
        //////
        //additional
//dpGet        "_Config.MinPrio" + AES_ONLVAL,
        g_propDp + both + systems + "Selections:_online.._stime",

        g_propDp + alerts + filter + ADD_VALUE_VALUE + AES_ONLVAL,
        g_propDp + alerts + filter + ADD_VALUE_COMBINE + AES_ONLVAL,
        g_propDp + alerts + filter + ADD_VALUE_COMPARE + AES_ONLVAL, 
        g_propDp + alerts + filter + ADD_VALUE_INDEX + AES_ONLVAL ) )
        
        // new
//dpGet        "_Config.ShowInternals" + AES_ONLVAL    /// aus as_initOld raus - hier damit onlinechange moeglich
//dpGet     // "_Config.HistoricalData" + AES_ONLVAL  // schreibt auf scriptglobale g_queryHLBlockedTime
//dpGet     // "_Config.QueryHLBlockedTime" + AES_ONLVAL  // schreibt auf scriptglobale g_queryHLBlockedTime
        
  {
    aes_message( AESMSG_DPCONNECT_FAILED, makeDynString( g_propDp ), 1, __FUNCTION__ );
    ret=-1;
    return;
  }

  return;
}


void  aes_initConfigSettings()
{
  dpGetCache(  "_Config.ShowInternalDPs.Alerts:_online.._value",   g_showInternalsA,
          "_Config.ShowInternalDPs.AlertRow:_online.._value", g_showInternalsAR,
          "_Config.ShowInternalDPs.Events:_online.._value",   g_showInternalsE,

          "_Config.MaxLines:_online.._value",                 g_maxClosedLines,

          "_Config.MaxLinesToDisplay:_online.._value",        g_asMaxLinesToDisplay,
          "_Config.MaxDpeToDisplay:_online.._value",          g_asMaxDpeToDisplay,
          "_Config.MaxDpeHourToDisplay:_online.._value",      g_asMaxDpeHourToDisplay );

}


/*
  Main property callback function 
  @param none
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/
void aes_propertiesCB(
  //alerts
  string dpShortcut,      string valShortcut,
  string dpPrio,          string valPrio,
  string dpADpComment,    string valADpComment,
  string dpAlertText,     string valAlertText,
  string dpLogicalCombine,unsigned valLogicalCombine,
  string dpADpList,       dyn_string valADpList,
  string dpBLECommentA,   dyn_langString valBLECommentA,      // new - BLE
  //////
  string dpAFTSelections, dyn_int valAFTSelections,
//  string dpAlertSummary,  bool valAlertSummary,
  string dpAlertSummary,  int valAlertSummary,
  //////
  string dpFSState,       unsigned valFSState,
  string dpOneRowPerAlert,bool valOneRowPerAlert,
  string dpOpenClosedMode,unsigned valOpenClosedMode,
  string dpDirection,     unsigned valDirection,
  //////
  //events
  string dpEDpComment,    string valEDpComment,
  string dpEDpList,       dyn_string valEDpList,  
  string dpUserbits,      bit32 valUserbits,
  string dpBLECommentE,   dyn_langString valBLECommentE,      // new - BLE
  //////
  string dpEFTSelections, dyn_int valEFTSelections,
  //////
  //both
  string dpType,          unsigned valType,
  string dpBegin,         time valBegin,
  string dpEnd,           time valEnd,
  string dpCameWentSort,  bool valCameWentSort,
  string dpHistoricalData,bool valHistoricalData,
  string dpMaxLines,      unsigned valMaxLines,
  string dpTRSelection,   unsigned valTRSelection,
  string dpShift,         unsigned valShift,
  //////
  string dpSysSelections, dyn_string valSysSelections,
  string dpCheckAllSystems,bool valCheckAllSystems,
  //////
  string dpSortList,      dyn_string valSortList,
  //////
  string dpVisibleColumns,dyn_string valVisibleColumns,
  //////
  string dpHeader,        langString valHeader,
  //////
  //additional
//dpGet  string dpMinPrio,       unsigned valMinPrio,  // +++ wird zusaetzlich benoetigt, siehe PropConn.
  string dpSystemSelectionsTime, time valTimeUpdate,   // +++ zusaetzlich, fuer reduswitch detect
  string dpAddVal,        dyn_string addValValue,
  string dpAddValComb,    dyn_string addValCombine,
  string dpAddValComp,    dyn_string addValCompare,
  string dynAddValIdx,    dyn_string addValIndex
  ) 

  // new
//dpGet  string dpShowInternals, bool valShowInternals )              ///////*************************************
//dpGet//string dpHistoricalData, int valHistoricalDataInterval,      ///////*************************************
//dpGet//string dpQueryHLBlockedTime, int valQueryHLBlockedTime )     /////// ACHTUNG triggert immer propertycallback
                                                               /////// dpget sinvoller ??????????
{
  unsigned screenType, runMode;
  dyn_string visibleColumns;
  string tableName;

  // saving values to scriptglobal variables
  unsigned valMinPrio;
  bool valShowInternals;
  bool valShowInternalsA;
  bool valShowInternalsAR;
  bool valShowInternalsE;
  int valHistoricalDataInterval;
  int valQueryHLBlockedTime;
  string desc;
  dyn_string dsBLE;
  dyn_string dsTmp;
  dyn_string dsDPEs;
  
  aes_debug( __FUNCTION__+"() / valCheckAllSystems=" + valCheckAllSystems );

  aes_initConfigSettings();

  // ATTENTION - disconnect must be called here ( before g_checkAll / g_systemSelections were set ) !!
  if(dynlen(g_counterConnectId) > 0)
  {
    DebugFTN("aesDist",__LINE__,__FUNCTION__,"call aes_queryDisconnect",g_counterConnectId);
    aes_queryDisconnect( g_counterConnectId );
  }
  
  // needed for distinfo
  g_systemSelections=valSysSelections;

  // setting scriptglobal variable for disttreating
  g_checkAll=valCheckAllSystems;

  //aes_debug(__FUNCTION__+"() / PROPERTIESCB !!!!!!!!!", 5 );

  // we use dpGet instead of the properties hotlink to suppress hotlink
  
dpGetCache(  "_Config.MinPrio" + AES_ONLVAL, valMinPrio,
        //"_Config.ShowInternals" + AES_ONLVAL, valShowInternals,    /// aus as_initOld raus - hier damit onlinechange moeglich
        "_Config.ShowInternalDPs.Alerts" + AES_ONLVAL, valShowInternalsA,
        "_Config.ShowInternalDPs.AlertRow" + AES_ONLVAL, valShowInternalsAR,
        "_Config.ShowInternalDPs.Events" + AES_ONLVAL, valShowInternalsE,
        "_Config.HistoricalDataInterval" + AES_ONLVAL, valHistoricalDataInterval,   // schreibt auf scriptglobale g_queryHLBlockedTime
        "_Config.QueryHLBlockedTime" + AES_ONLVAL, valQueryHLBlockedTime ); // schreibt auf scriptglobale g_queryHLBlockedTime


  if( valHistoricalDataInterval <= 0 ) valHistoricalDataInterval=AES_DEFVAL_HISTDATAINTERVAL;
  if( valQueryHLBlockedTime <= 0 ) valQueryHLBlockedTime=AES_DEFVAL_QUERYHLBLOCKEDTIME;

  g_historicalDataInterval=( valHistoricalDataInterval * 60 );    // sec !!!
  g_queryBlockedTime=valQueryHLBlockedTime;

  
//  g_showInternals   =valShowInternals;         // new with callback / if ok delete init section
  g_showInternalsA  =valShowInternalsA;
  g_showInternalsAR =valShowInternalsAR;
  g_showInternalsE  =valShowInternalsE;

//DebugN( "propertiesCB(A) =" + g_showInternalsA );
//DebugN( "propertiesCB(AR)=" + g_showInternalsAR );
//DebugN( "propertiesCB(E) =" + g_showInternalsE );

/*
DebugN(__FUNCTION__+"() / HistData=" + valHistoricalData );
DebugN(__FUNCTION__+"() / KamGing =" + valCameWentSort );
DebugN(__FUNCTION__+"() / modakt  =" + valFSState );
DebugN(__FUNCTION__+"() / oneline =" + valOneRowPerAlert );
DebugN(__FUNCTION__+"() / modopcl =" + valOpenClosedMode );
DebugN(__FUNCTION__+"() / dir     =" + valDirection );
DebugN(__FUNCTION__+"() / logicomb=" + valLogicalCombine );
DebugN(__FUNCTION__+"() / sumalert=" + valAlertSummary );

DebugN(__FUNCTION__+"() / internalDps      =" + g_showInternals );
DebugN(__FUNCTION__+"() / maxClosedLines   =" + g_maxClosedLines );
DebugN(__FUNCTION__+"() / minAlertPrio     =" + valMinPrio );
DebugN(__FUNCTION__+"() / queryBlockTime   =" + g_queryBlockedTime );
DebugN(__FUNCTION__+"() / historicalData   =" + valHistoricalData );
DebugN(__FUNCTION__+"() / historicalDataInt=" + g_historicalDataInterval );
*/

  // we treat this routine only if runmode was explicitly set to RUNNINGor
  aes_getRunMode( g_propDp, runMode, __FUNCTION__ );
  if( runMode != AES_RUNMODE_RUNNING )
  {
    return;
  }

doTimeStamp( "PROPSTART", true );

  aes_getScreenType( g_propDp, screenType );

  aes_debug( __FUNCTION__+"() / tabType="+g_tabType + " propMode=" + valType + " screenType=" + screenType );

  //IM 117712 dspitzer 22.04.2015 the function aes_getVisibleColumns needs to be called before aes_createAttributes
  aes_getVisibleColumns( g_propDp, visibleColumns );
  // 0 perparing attribute list ( depending on screenType ) / write back attributeinformation to global var g_attrList, needed for configMatrix
  aes_createAttributes( screenType, g_attrList );
  aes_debug(__FUNCTION__+"+++++++++++++++++++++++++++++ attrlist="+g_attrList );


  // 1 preparing config matrix - we need the following additional property parameters
  aes_createConfigMatrix( screenType, g_configMatrix );


  if( screenType == AESTYPE_ALERTS )
  {
    desc=valADpComment;
    dsBLE=valBLECommentA;
  }
  else
  {
    desc=valEDpComment;
    dsBLE=valBLECommentE;
  }

  // 2 preparing settings
  aes_createSettings( g_configSettings,
                      screenType,
                      valType,
                      valFSState,
                      desc,
                      valOneRowPerAlert,
                      this.backCol,
                      this.foreCol,
                      dsBLE,
                      valADpList );

  // 3 preparing table update/append/delete commands for evaluation
  aes_createTableCommands( screenType, AES_TABLECMD_UPDATE, g_tableCmdUpdate );

///////////////// in Zukunft nur mehr update aufrufen da evalScript nicht mehr verwendet wird
////////////////
  aes_createTableCommands( screenType, AES_TABLECMD_APPEND, g_tableCmdAppend );
  aes_createTableCommands( screenType, AES_TABLECMD_DELETE, g_tableCmdDelete );


  // 4 refresh table appearance - visible column list has possible changed
  tableName=this.name;
  //IM 117712 dspitzer 22.04.2015 the function aes_getVisibleColumns needs to be called before aes_createAttributes
//   aes_getVisibleColumns( g_propDp, visibleColumns );
  aes_initTable( tableName, screenType, visibleColumns );

  // 5 perparing old screen variables - depending on screenType
  aes_prepareOldScreenVariables( screenType, g_typeFilter, g_typeConst );
  
  // saving all values into scriptgloabl variables for fast execution in the callback routines
  // see table initialisation section !!!!


  // translate camWentSort to valChrono 
  if ( screenType == AESTYPE_EVENTS )
  {
    // not possible at events
    valCameWentSort=false;
  }
  

  if ( screenType == AESTYPE_EVENTS )
  {

    // calling old event routine 
    // we have to map espacially for events the variables
    // valADpComment, valADpList, valAFTSelections ( + valUserbits )
    aes_propertiesScreenCB(
      valFSState,
      valShortcut,
      valPrio,
      valEDpComment,        // !!! event mapping
      valAlertText,
      //valLogicalCombine,  // +++ zusaetzlich 
      valEDpList,           // !!! event mapping
      valMinPrio,           // ??? direkt nach _Config.MinPrio:_online connecten !!!!

      valSortList,

      valType,
      valBegin,
      valEnd,
      true,                 // valChrono,         // --- enfaellt in CB
      valCameWentSort,   // +++
      valHistoricalData, // +++
      valMaxLines,
      valTRSelection,
      valShift,
      
      "",                   // val currentConfig, // ??? in CB vorhanden pruefen / connect auf .name ??? - nur fuer setValue !!!

      valEFTSelections,     // !!! event mapping
      valAlertSummary,

      valSysSelections,
      valCheckAllSystems,
      valTimeUpdate,      // ??? connect auf Selections:_online.._stime !!!!!
      valUserbits,        // wird nur bei events verwendet !!!!
      false,              //valOneRowPerAlert,
      0,                  //valOpenClosedMode,
      0,                  //valDirection,
      0,                  //valLogicalCombine
      addValValue,
      addValCombine,
      addValCompare,
      addValIndex
      );
  }
  else    // alert/alertrow
  {
    // calling old alert routine - mapping parameters
    aes_propertiesScreenCB(
      valFSState,
      valShortcut,
      valPrio,
      valADpComment,
      valAlertText,
      //valLogicalCombine,  // +++ zusaetzlich 
      valADpList,
      valMinPrio,           // ??? direkt nach _Config.MinPrio:_online connecten !!!!

      valSortList,

      valType,
      valBegin,
      valEnd,
      true,                 // valChrono,         // --- enfaellt in CB
      valCameWentSort,   // +++
      valHistoricalData, // +++
      valMaxLines,
      valTRSelection,
      valShift,
      
      "",                   // val currentConfig, // ??? in CB vorhanden pruefen / connect auf .name ??? - nur fuer setValue !!!

      valAFTSelections,
      valAlertSummary,

      valSysSelections,
      valCheckAllSystems,
      valTimeUpdate,      // ??? connect auf Selections:_online.._stime !!!!!
      valUserbits,      // wird nur bei events verwendet !!!!
      //-----new
      valOneRowPerAlert,
      valOpenClosedMode,  // all or direction
      valDirection,
      valLogicalCombine,
      addValValue,
      addValCombine,
      addValCompare,
      addValIndex
      );
  }
  
  shape      table        = getShape(myModuleName() + "." + myPanelName() + ":" + this.name());
  int        iColumnCount = table.columnCount();
  
  for(int i=1; i<=iColumnCount; i++)
  {
    string sColumnName = table.columnToName(i-1);
    int iColumnWidth;
    getValue(table, "columnWidth", i-1, iColumnWidth);
    
    if(dynContains(valVisibleColumns, sColumnName) <= 0 ||
       iColumnWidth <= 0)
    {
      setValue(table, "namedColumnVisibility", sColumnName, FALSE);
    }
    else
    {
      setValue(table, "namedColumnVisibility", sColumnName, TRUE);
    }
  }
}


void aes_startAction( string screenConfig, int action )
{
  aes_initMainReg( screenConfig, action );
}

void aes_fixit()
{
  g_regGeneralInit = true;
}
/**
  Main table initialisation routine.
  @param none
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/
void aes_initMainTable( const int tabType, bool suppress = false )
{
  dyn_dyn_anytype dda;
  int n;

  const int d=0;
  int ret;
  unsigned changed;
  string tableTypeName="";
  string tablePropDp;
  string tableName;
  unsigned screenType;

  string configName;
  dyn_string visibleColumns;
  int action, colIdx;

  bool active;
  int activeTab;
  string fileName;

  string reg="reg_main";

  g_regGeneralInit=suppress;

  // we will suppress initialisation of alert row at bottom table
  if( tabType == AESTAB_BOT && g_alertRow )
  {
    return;
  }
  
  if( tabType != AESTAB_ALERTROW )
  {
    // wait until register has initialized - we are using the panelglobal variable as flag
    while( g_regInitReady == AES_INITSTATE_WAITING )
    {
      delay( 0, 10 );   //$$$ war 300
    }
  }
  else
  {
    // special treating for alertrow - because we have no register card with settings

  }

  if( g_regInitReady == AES_INITSTATE_FAILURE )
  {
    // terminate program - somethings wrong
    return;
  }


  // saving tabType to script global variable
  g_tabType=tabType;
  
  if( tabType == AESTAB_TOP )
  {
    g_propDp=g_propDpNameTop;
    g_regColumn=AES_TABNAME_TOP;
  }
  else if( tabType == AESTAB_BOT )
  {
    g_propDp=g_propDpNameBot;
    g_regColumn=AES_TABNAME_BOT;
  }
  else
  {
    // alert row
  }


  // get screentype and visualize table
  aes_getScreenType( g_propDp, screenType );

  // for g_maxClosedLines/ g_showInternals etc
  as_initOld( screenType );
  tableName=this.name;


  aes_debug(__FUNCTION__+" screenType=" + screenType +" tableName=" + tableName + " g_propDp="+g_propDp+" g_propDpNameTop="+g_propDpNameTop, d );
  // hier sollten auch gleich die visible columns (properies)beruecksichtigt werden!!!
  aes_getVisibleColumns( g_propDp, visibleColumns );

  // get the runtime propertyname - should already exist ( created and init. by initMainReg )

  // first connect - property control dpe elements
  // in this routine we also set the scriptglobal variable g_tabType to
  // identify in the general property cb function whether we are top or bot table
  aes_doPropControlConnect( ret );
  if( ret )
  {
    // abort program
    return;
  }

  if( tabType == AESTAB_TOP )
  {
    g_ctrlFlagTop=true;
  }
  else
  {
    g_ctrlFlagBot=true;
  }


  // second connect - poperty (base) settings elements - main routine
  aes_doPropertiesConnect( ret );
  if( ret != 0 )
  {
    // dialog abort program
    return;
  }
  
  // 118465
  // in a distributed system we make a connect for the _DistManager-datapoints
  // to get the information when a connection is established
  if(isDistributed())
  {
    if(isRedundant())
    {
      dpConnect("aes_checkDistSystemsRedu",1,"_DistManager.State.SystemNums",
                                             "_DistManager_2.State.SystemNums",
                                             "_Connections.Dist.HostNames",
                                             "_Connections_2.Dist.HostNames");
    }
    else
    {
      dpConnect("aes_checkDistSystems",1,"_DistManager.State.SystemNums",
                                         "_Connections.Dist.HostNames");
    }
  }
  else
  {
    // always the own system needs to be added in a non-distributed system
    string s_ownSystem;
    
    s_ownSystem = getSystemName();
    strreplace(s_ownSystem,":","");
         
    if(!dynContains(gds_connectedSystems,s_ownSystem))
      dynAppend(gds_connectedSystems,s_ownSystem);
  }

  // wait unitl register finished initialization
  while( !g_regGeneralInit )
  {
    delay(0, 10);   //$$$ war 300
   // g_regGeneralInit = true;
  }

  aes_getActivity( g_propDp, active ); 
  aes_debug( __FUNCTION__+"() / tabType=" + tabType + " g_alertRow=" + g_alertRow + " action=" + action + " active=" + active, d );

  // reading action from dp / even from p_action var possible
  dpGetCache( g_propDp + ".Settings.Action" + AES_ONLVAL, action );
  p_action=action;

  // only for the top table we support print and save action ???
  if( ( action == AES_ACTION_PRINT || action == AES_ACTION_SAVE ) && tabType==AESTAB_BOT )
  {
    // suppress propertyconnect for bottom table
    if( active )
    {
      aes_throwError( AES_TE_ACTIONONLYTOP );
    }
    //return;
  }
  
  // display register / initialisation should be finished right now
  // only if we are not in alert row mode
  if( !g_alertRow )
  { 
    setValue( reg, "visible", true); 
  }
  else
    active = TRUE;   // $$$ Alertrow is always active

  // only to set the right (active) register tab
  if( tabType == AESTAB_TOP )
  {
    if( active )
    {
      colIdx=0;   // top
    }
    else
    {
      colIdx=1;   // bottom
    }

    if( g_langSwitched )
      colIdx=g_lsActiveRegister;
    
    setValue( reg, "activeRegister", colIdx );
  }

  aes_runCmdStop( g_propDp, 7 );

  //if( g_alertRow || ( p_action != AES_ACTION_INTERACT ) ) // even with panelglobal p_action
  // at alertrow and action print and save we trigger start
  if( g_alertRow || ( action != AES_ACTION_INTERACT ) )
  {
    // trigger start
    if( active )
    {
      aes_doStart( g_propDp, 2 );
      //aes_debug(__FUNCTION__+"() / Start tabType="+tabType,5);
    }
  }
}

//@} Propertiesfunctionblock-end



/**@name RegisterFunctions*/ 
//@{
/**
  Main initialisation function.
  1) Create work runtime dp's ( _AESPropertiesRT_*_Top/Bot )
  2) Initialize all settings of _AESConfig and build structure objects for Alerts/Events/General settings
  3) Inits the panelglobal popupmenu structure
  4) Visualize the dynamic registercard
  5) Initialize the general registertab and write back information for tabel init ( _AESProperties DP e.g. screenType, config - even copies the properties settings to the runtime dp )
  6) Set the panelglobal variable g_regInitReady as flag for table initialization
  @param none
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/
void aes_initMainReg( string screenConfig="", int action=AES_ACTION_INTERACT )
{
  string fileName;
  bool ret, dispSlider;

  string propSourceDpNameTop, propSourceDpNameBot;

  // important for lang switch synchronization  
  g_ctrlFlagTop=false;
  g_ctrlFlagBot=false;

  g_regInitReady=AES_INITSTATE_WAITING;

 
  if( isDollarDefined( AESREGDOLLAR_SCREENTYPE ) && getDollarValue( AESREGDOLLAR_SCREENTYPE ) != "" )
  {
    screenConfig=getDollarValue( AESREGDOLLAR_SCREENTYPE );
    if( screenConfig == "" )
    {
      aes_panelOff();
    }
  }

  if( isDollarDefined( AESREGDOLLAR_ACTION ) &&  getDollarValue( AESREGDOLLAR_ACTION ) != "" )
  {
    action=getDollarValue( AESREGDOLLAR_ACTION );
  }

  if( isDollarDefined( AESREGDOLLAR_FILENAME ) && getDollarValue( AESREGDOLLAR_FILENAME ) != "")
  {
    fileName=getDollarValue( AESREGDOLLAR_FILENAME );
  }

  if( fileName=="" )
  {
    fileName=AES_DEFFILENAME;
  }
  aes_checkInitConditions( ret );
  if( !ret )
  {
    g_regInitReady=AES_INITSTATE_FAILURE;

    // Dialog - somethings missing
    aes_panelOff();
    return;
  }

  aes_reload();
  //aec_initMessageIds(); // for error treating  /// jetzt in reload

  // neu - aus panel init
  aes_osSettings();

  aes_initSplitPos( AES_TABLENAME_TOP, AES_TABLENAME_BOT );  

  dispSlider=aes_getGeneralSettingsValue( CHK_DISPSLIDER ); 

  p_dispSlider=dispSlider;
  if( ! dispSlider )
  {
    aes_disableSliderObjects();
  }

  // neu - fuer AS/ES_TYPE/FILTER/CONST
  aes_initOldScreenVariables();

  // create property dps
  aes_addPropertyDp( AESTAB_TOP, propSourceDpNameTop );
  aes_addPropertyDp( AESTAB_BOT, propSourceDpNameBot );

  while (!dpExists( propSourceDpNameTop ))
  {
    delay(0,100);
  }

  while (!dpExists( propSourceDpNameBot ))
  {
    delay(0,100);
  }
  if( g_alertRow )
  {
    // at alert row we set the autorun action explicitly
    action=AES_ACTION_AUTORUN;
  }


  dpSetCache(  propSourceDpNameTop + ".Settings.Action" + AES_ORIVAL, action,
                propSourceDpNameBot + ".Settings.Action" + AES_ORIVAL, action );
    
  // only for test without dptype changes
  p_fileName=fileName;

  aes_initGlobalShapes();

  // init menu struct - in the future, it should be panleglobal
  aes_initMenu();
  
  // set flag for table init

  g_regInitReady=AES_INITSTATE_OK; 

  // at alert row we only have the top table - we dont wait for bot table init
  // moreover it want be initialised
  if( g_alertRow )
  {
    g_ctrlFlagBot=true;
  }

  aes_initRegister( propSourceDpNameTop );

  // waiting for controlCB - we need callbacktreating in reggeneralinit !
  while( ( !g_ctrlFlagTop ) || ( !g_ctrlFlagBot ) )
  {
    delay( 0, 10 ); //$$$ war 100
  }

  // init main(general) register card - without name it will search for default aescreen
  // implicit call of aes_treatScreenConfigChange()
  if( ! aes_regGeneralInit( screenConfig ) )
  {
    // Dialog - explicit angegebene screenconfig wurde nicht gefunden !!!!!
    aes_panelOff();
    return;
  }

  if( ( action == AES_ACTION_PRINT ) ||
      ( action == AES_ACTION_SAVE ) ||
      ( ( action == AES_ACTION_AUTORUN ) && g_longTest ) )
  {
    int value;
    while( true )
    {
      delay( 1 );
      dpGetCache( propSourceDpNameTop + ".Settings.Action" + AES_ORIVAL, value );
      if( value == AES_ACTION_READY )
      {
        break;
      }
    }

    aes_panelOff();
  }



//  g_regInitReady=AES_INITSTATE_WAITING;   // necessary to prevent lang switch error !!!!
}


dyn_string aes_strsplit( string inp, string delim )
{
  int pos, l, start=0;
  bool found=false;
  dyn_string ds=makeDynString();

  l=strlen( delim );
  while( true )
  {
    // find first pos of delim
    pos=strpos( inp, delim );
    
    // if we didnt find delim
    if( pos < 0  )
    {
      if( found )
      {
        // append rest
        dynAppend( ds, inp );
        return ds;
      }
      else
      {
        // no deliminator found
        return ds;
      }
    }
    found=true;

    if( pos > 0 )
      dynAppend( ds, substr( inp, 0, pos ) );

    inp=substr( inp, pos+l );
  }
}


void aes_disableSliderObjects()
{
  bool val=false;

  setMultiValue("bt_topFull",  "visible", val,
                "bt_botFull",  "visible", val,
                "bt_topSplit", "visible", val,
                "bt_botSplit", "visible", val);
  
  if ( shapeExists("sl_gauge") )
    setValue("sl_gauge", "visible", val);
}


void aes_checkInitConditions( bool &ret )
{
  const int d=5;

  dyn_string allTypes;
  
  //const string dpAESConfig      =_AEC_DP_ROOT;
  const string dpAESConfig      =_AEC_DP_ROOTRESTORE;
  
  const string typeAESConfig    =_AEC_DPTYPE_CONFIG;
  const string typePropConfig   =_AES_DPTYPE_PROPERTIES;
  const string typeScreenConfig =_AES_DPTYPE_SCREEN;

  ret=false;

  // 1 - check for all needed type
  allTypes=dpTypes();

  if( ( dynContains( allTypes, typeAESConfig ) <= 0 ) ||
      ( dynContains( allTypes, typePropConfig ) <= 0 ) ||
      ( dynContains( allTypes, typeScreenConfig ) <= 0 ) )
  {
    aes_debug(__FUNCTION__+"() / Some datatypes are missing - abort program !", d );
    return;
  }

  // 2 - check for config dp / restore exists
  if( !dpExists( dpAESConfig ) )
  {
    aes_debug(__FUNCTION__+"() / Config dp is missing - abort program !", d );
    return;
  }

  aec_restoreConfig( true );


  // we even should check _Config DPE HistoricalDataInterval / QueryHLBlockedTime !!!!!!

  ret=true;
  return;
}


void aes_reload()
{
  bool initFromAES=true;

  aec_init( initFromAES );

  // load full configuration from db into vstn structure
  aes_readConfigurationFromDB();
  // build sorted column struct ddaRes[ALERTS] from vst

  aes_buildColumnStruct( AESTYPE_ALERTS );
  // build sorted column struct ddaRes[EVENTS] from vst
  if (!g_alertRow)
  aes_buildColumnStruct( AESTYPE_EVENTS );
}


void aes_initOldScreenVariables()
{
  // panelglobal variables / workvariables where scriptglobal see tableinit g_typeFilter, g_typeConst
  // alerts
  AS_TYPEFILTER = makeDynString( "bit",
                                 "bit32",
                                 "unsigned integer",
                                 "integer",
                                 "float",
                                 "bit64",
                                 "ulong",
                                 "long");

  AS_TYPECONST  = makeDynInt( DPEL_BOOL,
                              DPEL_BIT32,
                              DPEL_UINT,
                              DPEL_INT,
                              DPEL_FLOAT,
                              DPEL_BIT64,
                              DPEL_ULONG,
                              DPEL_LONG);

  // events
  ES_TYPEFILTER = makeDynString( "bit", "bit32", "unsigned integer", "integer", 
                                 "float", "bit64", "ulong", "long", "time", "string", "langstring", "dp identifier",
                                 "dyn bit", "dyn bit32", "dyn unsigned integer", "dyn integer", 
                                 "dyn float", "dyn bit64","dyn ulong","dyn long","dyn time", "dyn string",
                                 "dyn langstring", "dyn dp identifier" );

  ES_TYPECONST = makeDynInt( DPEL_BOOL,
                             DPEL_BIT32,
                             DPEL_UINT,
                             DPEL_INT,
                             DPEL_FLOAT,
                             DPEL_BIT64,
                             DPEL_ULONG,
                             DPEL_LONG,
                             DPEL_TIME,
                             DPEL_STRING,
                             DPEL_LANGSTRING,
                             DPEL_DPID,
                             DPEL_DYN_BOOL,
                             DPEL_DYN_BIT32,
                             DPEL_DYN_UINT,
                             DPEL_DYN_INT,
                             DPEL_DYN_FLOAT,
                             DPEL_DYN_BIT64,
                             DPEL_DYN_ULONG,
                             DPEL_DYN_LONG,
                             DPEL_DYN_TIME,
                             DPEL_DYN_STRING,
                             DPEL_DYN_LANGSTRING,
                             DPEL_DYN_DPID );



  // reading general settings - we are using panelglobal variables 
  // achtung - jetzt noch as ==> in Zukunft aes oder nur *_max* !!!!!!!!!
  dpGetCache("_Config.MaxLinesToDisplay:_online.._value",   g_asMaxLinesToDisplay,
        "_Config.MaxDpeToDisplay:_online.._value",     g_asMaxDpeToDisplay,
        "_Config.MaxDpeHourToDisplay:_online.._value", g_asMaxDpeHourToDisplay );




}


int aes_addPropertyDp( int tabType, string &propDp, bool configPanel=false )
{
  propDp=aes_getPropDpName( AES_DPTYPE_PROPERTIES, true, tabType, false, configPanel );

  if (!dpExists(propDp))
  {
    aesGenerateDp( propDp, _AES_DPTYPE_PROPERTIES);
    delay(1);
  }
  if( !dpExists(propDp) )
  {
    aes_message( AESMSG_DPCREATE_FAILED, makeDynString( propDp ), 1, __FUNCTION__ );
    return -1;
  }
  while ( !dpExists(propDp) )
  {
    delay(0,100);
  }

  //new feature userdepending alarm display IM #117931
  //when feature activated check internal datapoints of AESConfig whether up to date and update it if not
  if(isFunctionDefined("aes_checkInternalDPforUDA"))
    aes_checkInternalDPforUDA();

  // init panelglobal propertyname - important for all further routines
  // alertRow
  if( !configPanel )
  {
    if( tabType == AESTAB_TOP )
    {
      g_propDpNameTop=propDp;
    }
    else
    {
      g_propDpNameBot=propDp;
    }
  }

  // set tabType for aes_getTabType()
  dpSetCache( propDp + ".Settings.TabType" + AES_ORIVAL, tabType );

  return 0;
}


string aes_getPropDpName( const int dpType, bool runtime=false, int tabType=AESTAB_TOP, bool fromAROut=false, bool configPanel=false, bool localConfig=false )
{
  string name, sysName, format, tmp;
  dyn_string names;
  int count,pos;

  string strDpType;

  sysName=getSystemName();

  if( dpType == AES_DPTYPE_SCREEN )
  {
    strDpType=_AES_DPTYPE_SCREEN;
  }
  else
  {
    strDpType=_AES_DPTYPE_PROPERTIES;
  }

  if( runtime )
  {
    // IM 104645 - moduleName changed to "WinCC_OA" because of creating temporary DPs and DP names must not include "space"
    string moduleName = myModuleName();    
    if (moduleName == "WinCC OA")
       moduleName = "WinCC_OA";
    // we need this branch only for the setAESDpList() function call / we havent a scope to g_alertRow
    if( configPanel )
    {
      name=strDpType + "CfgPanel_" + myUiNumber() + "_" + moduleName;
    }
    else if( fromAROut )
    {
      name=strDpType + "RTRow_" + myUiNumber() + "_" + moduleName;
    }
    else
    { 
    
      if( g_alertRow )
      {
        name=strDpType + "RTRow_" + myUiNumber() + "_" + moduleName;
      }
      else
      {
        name=strDpType + "RT_" + myUiNumber() + "_" + moduleName;
      }
    }

    // only for runtime properties we have to identifiy the dp name with top/bot appendix
    if( dpType == AES_DPTYPE_PROPERTIES )
    {
      name=name + "_";
      if( tabType == AESTAB_TOP )
      {
        name=name + _AESTAB_TOP;
      }
      else
      {
        name=name + _AESTAB_BOT;
      }
    }
  }
  else
  {
    format="%s%s_%04d";
    names=dpNames("*", strDpType );
    count=1;
    if (localConfig)
      count = DISTSYNC_LOCAL_DP_START;

    sprintf( name, format, sysName, strDpType, count );

    while( dynContains( names, name ) > 0 )
    {
      count++;
      sprintf( name, format, sysName, strDpType, count );
    }

    //we need the name without the system description
    sprintf( name, format, "", strDpType, count );

  }

  return name;
}

/**
  Main registercard initialisation routine. 
  @param propDpTop name of DP on which to set the values (must be of DP-Type _ASConfig); with trailing "."
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/
void aes_initRegister( string propDpTop )
{
  int c=1;
  dyn_string keyNames, catNames;  
  dyn_dyn_anytype dda;

  aes_debug("initRegister() called" );
  

  keyNames[1]    =AES_TABNAME_TOP;
  keyNames[2]    =AES_TABNAME_BOT;
  keyNames[3]    =AES_TABNAME_GENERAL;

  // keep values in panelglobal var g_regHeaderNames for later use
  aes_getCatNames2( keyNames, g_regHeaderNames );

  aes_buildRegSettings( dda );

  aes_debug("regSettings" + dda );
  
  aes_setMainRegSettings( dda, propDpTop );

/// initialisierung - lese alle propSourceDps / default
/// fuelle comboboxen von screen und property types
/// und setze combotexte - fuer tableinitroutine
}


void aes_getCatNames2( const dyn_string &keyNames, dyn_string &catNames )
{
  int n, l;
  int first, last;
  string sTmp;

  first=1;
  last=dynlen(keyNames) + 1;

  for( n=first; n < last; n++ )
  {
    sTmp=keyNames[n];
    catNames[n]=aes_getCatStr( sTmp );
    aes_debug("key=" + sTmp + " val=" + catNames[n] );
  }
}


void aes_setMainRegSettings( const dyn_dyn_anytype &dda, string propDpTop )
{
  int n, l, colIdx, workIdx;
  string tabName, theTabType, panelPath, propDpName, balPropDpName;
  dyn_string dollar;
  string reg=AES_REGMAIN;


  aes_debug("Main reg/dda=" + dda );

  l=dynlen(dda);

  for( n=1; n <= l; n++ )
  {
    colIdx=n-1;

    tabName     =dda[n][AESREG_NAME];       // for set operations tab_top, tab_bot, tab_general
    theTabType  =dda[n][AESREG_TABTYPE];    // Top/Bot/General
    panelPath   =dda[n][AESREG_PANEL];      // panel to display

    if( colIdx == AESREGTAB_TOP )
    {
      propDpName=g_propDpNameTop;
      balPropDpName=g_propDpNameBot;
    }
    else if ( colIdx == AESREGTAB_BOT )
    {
      propDpName=g_propDpNameBot;
      balPropDpName=g_propDpNameTop;
    }
    else
    {
      propDpName="";
      balPropDpName="";
    }

    if( colIdx == AESREGTAB_TOP || colIdx == AESREGTAB_BOT )
    {
      dollar=makeDynString( 
       AESREGDOLLAR_TABTYPE + ":" + theTabType,
       AESREGDOLLAR_TABNAME + ":" + tabName,
       AESREGDOLLAR_PROPDP + ":" + propDpName,
       AESREGDOLLAR_BALPROPDP + ":" + balPropDpName );
    }
    else
    {
      dollar=makeDynString( 
       AESREGDOLLAR_TABTYPE + ":" + theTabType,
       AESREGDOLLAR_TABNAME + ":" + tabName,
       AESREGDOLLAR_PROPDPTOP + ":" + g_propDpNameTop,
       AESREGDOLLAR_PROPDPBOT + ":" + g_propDpNameBot );
    }
    
    setValue( reg, "registerPanel", colIdx, panelPath, dollar ); 
    setValue( reg, "namedColumnHeader", tabName, g_regHeaderNames[n] ); 

    // we want display the general tab
    if( colIdx == 2 )
    {
      setValue( reg, "registerVisible", colIdx, false );
    }

aes_debug("namedColumnHeader name="+tabName+" text=" + g_regHeaderNames[n] + " colIdx=" + colIdx , 0);
  }

  // show registercard
//  setValue( reg, "activeRegister", AESREGTAB_GENERAL );

  //setValue( reg, "visible", true );  // set register visible in table routine / ensure init is ready
}


void aes_buildRegSettings( dyn_dyn_anytype &dda )
{
  int c=0, i;
  const string sub="vision/aes/";
  const string ext=".pnl";

  i=1;     dda[i][AESREG_NAME]=AES_TABNAME_TOP;
  i=2;     dda[i][AESREG_NAME]=AES_TABNAME_BOT;
  i=3;     dda[i][AESREG_NAME]=AES_TABNAME_GENERAL;
  // testsettings for dollar parameters
  i=1;     dda[i][AESREG_TABTYPE]=_AESTAB_TOP;
  i=2;     dda[i][AESREG_TABTYPE]=_AESTAB_BOT;
  i=3;     dda[i][AESREG_TABTYPE]=_AESTAB_GENERAL;
  // testsettings for dollar parameters - panelnames
  i=1;     dda[i][AESREG_PANEL]=sub+"AEScreenRegBoth"+ext;
  i=2;     dda[i][AESREG_PANEL]=sub+"AEScreenRegBoth"+ext;
  i=3;     dda[i][AESREG_PANEL]=sub+"AEScreenRegGeneral"+ext;
  // testsettings for dollar parameters - propDP Name / _AESProperties for start
  i=1;     dda[i][AESREG_PROPDP]=g_propDpNameTop;
  i=2;     dda[i][AESREG_PROPDP]=g_propDpNameBot;
  i=3;     dda[i][AESREG_PROPDP]="";

}


int aes_queryDisconnect( dyn_string &identifiers )
{

  // disconnect all connected systems!!!
  
  const int d=5;
  int n, l;
  int errFlag=false;
  string identifier;
  bool fromProp;

  int tabType, mode, systemId;
  
  dyn_string ds_identifierList;

  ds_identifierList = identifiers;
  l=dynlen(ds_identifierList);

  if( l <= 0 )
  {
    return 0;
  }
  
  for( n=1; n <= l; n++ )
  {
    DebugFTN("aesDist",__LINE__,__FUNCTION__,n,l,ds_identifierList);
    identifier=ds_identifierList[n];

    DebugFTN("aesDist",__LINE__,__FUNCTION__,"identifier,g_checkAll",identifier,g_checkAll);
    if( g_checkAll )
    {
      aes_getInfoFromIdentifier( identifier, tabType, mode, systemId, fromProp );

      DebugFTN("aesDist",__LINE__,__FUNCTION__,identifier,systemId,b_remoteAllSingleQueries);

      // we only want to disconnect dummysysid in check all mode !!!
      // check if a connect to ALL systems was made
      if( systemId != AES_DUMMYSYSID && b_remoteAllSingleQueries == 0 )
      {
        continue;
      }
    }

    DebugFTN("aesDist",__LINE__,__FUNCTION__,"call dpQueryDisconnect",identifier);
    if( dpQueryDisconnect( AESQUERY_WORKFUNC, identifier ) == 0 )
    {
      dynRemove( g_counterConnectId, n );
    }
    else
    {
      errFlag=true;
      aes_debug( __FUNCTION__+"() / Error during disconnect for system="+identifiers[n], d );
    }
    DebugFTN("aesDist",__LINE__,__FUNCTION__,n,l,ds_identifierList);
  }

  dynClear( identifiers );

  // IM 118465 - AEScreen was stopped - no systems are connected
  dynClear(gds_queryConnectedSystems);
  b_remoteAllSingleQueries = 0;
  DebugFTN("aesDist",__LINE__,__FUNCTION__,"no systems are connected",gds_queryConnectedSystems);

  // new - set runmode to stopped in any case / even if disconnect failes
  if (!g_alertRow)
  dpSetCache( g_propDp + ".Settings.RunMode" + AES_ORIVAL, AES_RUNMODE_STOPPED );

  if( errFlag )
    return -1;
  else
    return 0;

}


dyn_string aes_resortConfigs( const dyn_string &realNames )
{
  int pos, n, ic=1;
  string val;
  dyn_string retConfigs;
  dyn_string protList=makeDynString( 
    AES_DEFPROT_SCREEN_DEFAULT,
    AES_DEFPROT_SCREEN_ALERTS,
    AES_DEFPROT_SCREEN_EVENTS,
    AES_DEFPROT_SCREEN_COMMAND,
    AES_DEFPROT_SCREEN_ALERTROW );  

  // make a coopy
  retConfigs=realNames;

  if( ( dynlen( protList ) <= 0 ) && ( dynlen(realNames) <= 0 ) )
  {
    return retConfigs;
  }

  for( n=1; n <= dynlen( protList ); n++ )
  {
    val=protList[n];

    pos=dynContains( retConfigs, val );
    if( pos > 0 )
    {
      dynRemove( retConfigs, pos );
      dynInsertAt( retConfigs, val, ic );
      ic++;
    }
  }

  return retConfigs;

}


bool aes_regGeneralInit( string screenConfig )
{

  string screenConfigName, defRealName;
  dyn_string g_realNames, g_dpNames;
  dyn_bool g_defaults;
  int arMode;

  // we will search only for alert row screentypes at alert row ;)
  if( g_alertRow )
  {
    arMode=AES_ARPROP_ONLY;
  }
  else
  {
    arMode=AES_ARPROP_EXCL;
  }

  // try to find default aescreen dpname
  // get all aescreen dpnames/realNames
  aes_getDpsPerType( g_realNames, g_dpNames, g_defaults, AES_DPTYPE_SCREEN, AESTYPE_GENERAL, false, arMode );
  // find the default (dp)names
  aes_getDefaultDpInfo( g_realNames, g_dpNames, g_defaults, defRealName, screenConfigName );


  // this routine should even work was alertrow screentypes -> see arMode
  {
    // if theres an screenConfig explicitly defined
    if( screenConfig != "" )
    {
      if( dynContains( g_realNames, screenConfig ) > 0 )
      {
        defRealName=screenConfig;
      }
      else
      {
        // dialog - alertrow default screenconfig missing !!!
        return false;
      }
    }
  }


  if( dynlen( g_realNames ) > 0 )
  {

    setValue( "cb_aesConfig", "items", aes_resortConfigs( g_realNames ) );

    if( defRealName == "" )
    {
      defRealName=g_realNames[1];
    }

    // if name exists - it will be selected instead of first position
    if( g_langSwitched )
      defRealName=g_lsActiveScreenConfig;
    
    setValue( "cb_aesConfig", "text", defRealName );  
  }

  if( !aes_operationPermission( defRealName, AES_OPERTYPE_PROPERTIES, AES_OPER_REMOVE ) )
  {
    setMultiValue(  "pb_saveScreenConfig", "enabled", false,
                    "pb_deleteScreenConfig", "enabled", false,
                    "pb_renameScreenConfig", "enabled", false );
  }
  else
  {
    setMultiValue(  "pb_saveScreenConfig", "enabled", true,
                    "pb_deleteScreenConfig", "enabled", true,
                    "pb_renameScreenConfig", "enabled", true );
  }


  // for both tables
  aes_treatScreenConfigChange( AESTAB_TOP, defRealName );
  if (!g_alertRow)
     aes_treatScreenConfigChange( AESTAB_BOT, defRealName );

  // set flag for init table
  g_regGeneralInit=true;

  return true;
}


void aes_setProportion( const int tabType, const string &propDpName, const int id, int &prop )
{

  float ft, fb;
  int res;

  switch( id )
  {
  case 0:
    ft=4.0;
    fb=1.0;
    break;

  case 1:
    ft=2.0;
    fb=1.0;
    break;

  case 2:
    ft=1.0;
    fb=1.0;
    break;

  case 3:
    ft=1.0;
    fb=2.0;
    break;

  case 4:
    ft=1.0;
    fb=4.0;
    break;

  default:
    ft=1.0;
    fb=1.0;
    break;
  }

  res=( 1.0 / ( ft + fb ) ) * ft * 100.0;

  prop=res;
  
}


void aes_treatActivityChange( const int tabType )
{
  string propDpName, pre, app, corpre, corapp;
  
  bool myState, corState, oldState, vis;


  if( tabType == AESTAB_TOP )
  {
    aes_getPreAppint4TabType( tabType, pre, app );
    aes_getPreApp4TabType( AESTAB_BOT, corpre, corapp );
    propDpName=g_propDpNameTop;
  }
  else
  {
    aes_getPreApp4TabType( tabType, pre, app );
    aes_getPreApp4TabType( AESTAB_TOP, corpre, corapp );
    propDpName=g_propDpNameBot;
  }
  
  // reading both values
  getValue( "chk_active" + app, "state", 0, myState );
  getValue( "chk_active" + corapp, "state", 0, corState );

  if( ( !myState ) && ( !corState ) )
  {
    // if both where deactivate - activate mystate
    this.state(0)=true;
    myState=true;

    // nothing changed - leave function
    return;
  }

  // reading "old" state from dp
  aes_getActivity( propDpName, oldState );

  // if state changed
  if( myState != oldState )
  {
    // write back value to dp
    dpSetCache( propDpName + ".Settings.Active" + AES_ORIVAL, myState );
    aes_changed( propDpName, AES_CHANGED_ACTIVITY );  
  }
  else
    return;

  // if only one is active => disable proportion
  if( myState != corState )
    vis=false;
  else
    vis=true;

  setMultiValue(  "te_proportionTop", "enabled", vis,
                  "te_proportionBot", "enabled", vis,
                  "cab_proportion",   "enabled", vis );
  
}


void aes_treatProportionChange( const string propDp, unsigned tabType, int value )
{

  int myValue, corValue, oldProp;
  string pre, app, myApp, corApp;

  // check whether value is within limits
  if( value > AES_TABLE_MAXPERCENT || value < AES_TABLE_MINPERCENT )
  {
    // restore old value - only from topDp
    aes_getProportion( propDp, value );
    if( tabType == AESTAB_BOT )
      value=100-value;
  }

  myValue=value;
  corValue=100-value;

  if( tabType == AESTAB_TOP )
  {
    myApp=_AESTAB_TOP;
    corApp=_AESTAB_BOT;
    dpSetCache( propDp + ".Settings.Proportion" + AES_ORIVAL, myValue );
  }
  else
  {
    myApp=_AESTAB_BOT;
    corApp=_AESTAB_TOP;
    // corValue because we only set the top proportion
    dpSetCache( propDp + ".Settings.Proportion" + AES_ORIVAL, corValue );
  }

  setMultiValue(  "te_proportion" + myApp, "text", myValue,
                  "te_proportion" + corApp, "text", corValue );

  // we set only the value of the current dp - we can treat scale of both tables performing it in one callback
        
  // trigge callback
  aes_changed( propDp, AES_CHANGED_PROPORTION );

}


int aes_getDefaultDpInfo( const dyn_string &realNames, const dyn_string &dsDpNames, const dyn_bool &dbDefault, string &defRealName, string &defDpName ) 
{
  int l, i;
  
  l=dynlen( realNames );
  if ( l <= 0 )
  {
    defRealName="";
    defDpName="";
    return 0;  
  }

  for( i=1; i <= l; i++ )
  {
    if( dbDefault[i] )
    {
      defRealName=realNames[i];
      defDpName=dsDpNames[i];
      return 0;
    }
  }  
  return 0;
}


void aes_treatScreenConfigChange( unsigned tabType, const string screenConfigName="" )
{
  const int d=0;
  string dpRoot, dpPath;
  string app;
  
  bool active;
  unsigned screenType, proportion, tmpProp;
  string config;

  dyn_string dsRealNames, dsDpNames;
  dyn_bool dbDefaults;

  string realName, dpName;
  string dpSource, dpTarget;
  string setDpName;
  string scDpName;  // screenConfigDpName

  bool useAsDefault=false;


  if( tabType == AESTAB_TOP )
    dpTarget=g_propDpNameTop;
  else
    dpTarget=g_propDpNameBot;

  // stop possible running query
  aes_doStop( dpTarget );


  // if an screenConfigName exitst - try to find the dp
  if( screenConfigName != "" )
  {
    // get the dpScreenConfigName / AESTYPE_GENERAL is only a dummy for AES_DPTYPE_SCREEN
    aes_getDpName4RealName( screenConfigName, AES_DPTYPE_SCREEN, AESTYPE_GENERAL, scDpName );
    if( scDpName == "" )
    {
      aes_debug( __FUNCTION__+"() no dp for name=" + screenConfigName );
      return;
    }
  }
  else
  {
    scDpName="";
  }

  aes_debug(__FUNCTION__+"() tabType="+tabType+" screenConfigName="+screenConfigName+" dp="+scDpName, d );

  if( scDpName == "" )
  {
    // if no defDpName was found, we use aesconfig settings !!!
    // we have only the top proportion info
    tmpProp=aes_getGeneralSettingsValue( TE_PROPORTION );

    if( tabType == AESTAB_TOP )
    {
      active    =aes_getGeneralSettingsValue( CHK_TOPACTIVE ); 
      screenType=aes_getGeneralSettingsValue( CB_TOPTYPE );
      config    =aes_getGeneralSettingsValue( CB_TOPINIT );
      proportion=tmpProp;

    }
    else
    {
      active    =aes_getGeneralSettingsValue( CHK_BOTACTIVE ); 
      screenType=aes_getGeneralSettingsValue( CB_BOTTYPE );
      config    =aes_getGeneralSettingsValue( CB_BOTINIT );
      proportion=( 100 - tmpProp );

    }
  }
  else
  {

    // if a aescreen dp was found, we use its settings
    if( tabType == AESTAB_TOP )
    {
      dpPath=scDpName + ".Top";
      app="Top";
      dpTarget=g_propDpNameTop;
    }
    else if ( tabType == AESTAB_BOT )
    {
      dpPath=scDpName + ".Bot";
      app="Bot";
      dpTarget=g_propDpNameBot;
    }
    
    // read aesconfig settings from dp
    dpGetCache( scDpName + ".UseAsDefault" + AES_ONLVAL, useAsDefault,
           dpPath + ".Active" + AES_ONLVAL, active,
           dpPath + ".ScreenType" + AES_ONLVAL, screenType,
           dpPath + ".Proportion" + AES_ONLVAL, proportion,
           dpPath + ".Config" + AES_ONLVAL, config );

    setValue( "chk_default", "state", 0, useAsDefault );
  }

  {
  string pre, app;

  aes_getPreApp4TabType( tabType, pre, app );

  //aes_debug(__FUNCTION__+"() / config="+config+" tabType="+tabType +" pre=" + pre, 5 );
  setValue( pre + "cb_config", "text", config );


  }

  // set values to runtime dp
  dpSetCache( dpTarget + ".Settings.Active"     + AES_ORIVAL, active,
             dpTarget + ".Settings.ScreenType" + AES_ORIVAL, screenType,
             dpTarget + ".Settings.Config"     + AES_ORIVAL, config,
             dpTarget + ".Settings.Proportion" + AES_ORIVAL, proportion );

  aes_debug(__FUNCTION__+"() tabType="+tabType+" screenConfigName="+screenConfigName+" dp="+scDpName + " screenType=" + screenType, d );

  // reading all available properties for screenType
  aes_getDpsPerType( dsRealNames, dsDpNames, dbDefaults, AES_DPTYPE_PROPERTIES, screenType, false );
  
  // do all settings for general tab - its accessible
  setMultiValue( "chk_active" + app,    "state", 0, active,
                 "cb_screenType" + app, "text", aes_getAEStrLang( screenType ),
                 "te_proportion" + app, "text", proportion,
                 "cb_config" + app,     "items", dsRealNames );


  // to set the first item if config verify fails
  if( dynlen( dsRealNames ) > 0 )
  {
    setValue( "cb_config" + app, "selectedPos", 1 );
  }

  // to ensure combo verify
  if( config != "" )
  {
    setValue( "cb_config" + app, "text", config );
  }

  // right know get properties name from combobox ( after verify etc. )
  getValue( "cb_config" + app, "text", realName );

  // get dp description for realName
  aes_getDpName4RealName( realName, AES_DPTYPE_PROPERTIES, screenType, dpSource );

  // copy all propertie values from saveDp to runtime Dp - if empty, we are using harcoded defaultvalues !!!!
  aes_copyProperties( dpSource, dpTarget, screenType );

  //aes_changed( dpTarget, AES_CHANGED_SCREENCONFIG );
  // send a screenType change message
  aes_changed( dpTarget, AES_CHANGED_SCREENTYPE );
}


void aes_treatPropConfigChange( const string &propDpName, const string propName )
{
  unsigned screenType;
  string dpSource;
  string dpTarget=propDpName;

  aes_getScreenType( propDpName, screenType );

  dpSetCache(  propDpName + ".Settings.Config" + AES_ORIVAL, propName,
              propDpName + ".Settings.RunMode" + AES_ORIVAL, AES_RUNMODE_STOPPED );

  // we only have to copy the properties
  // get dp description for realName
  aes_getDpName4RealName( propName, AES_DPTYPE_PROPERTIES, screenType, dpSource );

  // copy all propertie values from saveDp to runtime Dp - if empty, we are using harcoded defaultvalues !!!!
  
// ACHTUNG - jetzt in aes_changedPropConfig() - da wir hier keinen Acc auf ddaRes haben !
//  aes_copyProperties( dpSource, dpTarget, screenType );

  aes_changed( propDpName, AES_CHANGED_PROPCONFIG );
}


void aes_treatScreenTypeChange( const string &propDpName, const unsigned screenType, const unsigned tabType )
{

  dyn_string configList;
  string propCombo;
  string realName="";
  string dpSource="", dpTarget;

  dyn_string dsRealNames, dsDpNames;
  dyn_bool dbDefaults;
  int arMode;

  dpTarget=propDpName;

  if( g_alertRow )
  {
    arMode=AES_ARPROP_ONLY;
  }
  else
  {
    arMode=AES_ARPROP_EXCL;
  }


  // write back new screenType and reset runMode to STOPPED( we need it especially for initialization !!!)
  // we can't access this function on the surface until a query is running - we have to stopp it before
  dpSetCache(  propDpName + ".Settings.ScreenType" + AES_ORIVAL, screenType,
              propDpName + ".Settings.RunMode" + AES_ORIVAL, AES_RUNMODE_STOPPED );

  // now reading all available properties for specified screentype - activate the first one ( if exists )
  aes_getDpsPerType( dsRealNames, dsDpNames, dbDefaults, AES_DPTYPE_PROPERTIES, screenType, false, arMode );   


  if( tabType == AESTAB_TOP )
  {
    propCombo="cb_configTop";
  }
  else
  {
    propCombo="cb_configBot";
  }

  if( dynlen( dsRealNames ) > 0 )
  {
    realName=dsRealNames[1];
    dpSource=dsDpNames[1];
  }

  setValue( propCombo, "items", dsRealNames );
  setValue( propCombo, "text", realName );
   
  // copy all property values from saveDp to runtime Dp  
  aes_copyProperties( dpSource, dpTarget, screenType );

  // fire event
  aes_changed( propDpName, AES_CHANGED_SCREENTYPE );  

}


void aes_changed( const string &propDpName, const unsigned changed )
{
  while (!dpExists( propDpName ))
  {
    delay(0,100);
  }
  dpSetCache( propDpName + ".Settings.Changed" + AES_ORIVAL, changed );
}


void aes_getTabType( const string &propDpName, unsigned &tabType )
{
  while (!dpExists( propDpName ))
  {
    delay(0,100);
  }
  dpGetCache( propDpName + ".Settings.TabType" + AES_ONLVAL, tabType );
}


void aes_getBeginEnd( const string &propDpName, time &begin, time &end )
{
   while (!dpExists( propDpName ))
  {
    delay(0,100);
  }
  dpGetCache(  propDpName + ".Both.Timerange.Begin" + AES_ONLVAL, begin,
          propDpName + ".Both.Timerange.End" + AES_ONLVAL, end );
}


void aes_getMaxLines( const string &propDpName, int &maxLines )
{
  dpGetCache(  propDpName + ".Both.Timerange.MaxLines" + AES_ONLVAL, maxLines ); 
}


void aes_getSystemSelections( const string &propDpName, dyn_string &systems )
{
   while (!dpExists(propDpName))
  {
    delay(0,100);
  }
  dpGetCache( propDpName + ".Both.Systems.Selections" + AES_ONLVAL, systems );
}

void aes_getCheckAll( const string &propDpName, bool &checkAll )
{
   while (!dpExists(propDpName))
  {
    delay(0,100);
  }
  dpGetCache( propDpName + ".Both.Systems.CheckAllSystems" + AES_ONLVAL, checkAll );
}


void aes_getVisibleColumns( const string &propDpName, dyn_string &visibleColumns )
{
   while (!dpExists(propDpName))
  {
    delay(0,100);
  }
  dpGetCache( propDpName + ".Both.Visible.VisibleColumns" + AES_ONLVAL, visibleColumns );
  
  if(table_top.columnCount() < AES_MAX_COLUMNS) //Erweiterung auf 45 frei konfigurierbare Spalten
    aes_throwError(AES_TE_OLDVERSION,2,getCatStr("AES","00008"),getCatStr("AES","00009"));
  
  if(this.name == "table_top")
    g_visibleColumnsTop = visibleColumns;
  else if(this.name == "table_bot")
    g_visibleColumnsBot = visibleColumns;
}


void aes_getSortList( const string &propDpName, dyn_string &sortList, dyn_bool &sortAsc )
{
   while (!dpExists(propDpName))
  {
    delay(0,100);
  }
  dyn_string tmp_sortList;   
  
  dpGetCache( propDpName + ".Both.Sorting.SortList" + AES_ONLVAL, tmp_sortList);
  
  aes_splitSortList(tmp_sortList, sortList, sortAsc);

}


void aes_getScreenType( const string &propDpName, unsigned &screenType )
{
  while (!dpExists(propDpName))
  {
    delay(0,100);
  }
  dpGetCache( propDpName + ".Settings.ScreenType" + AES_ONLVAL, screenType );
}


void aes_getConfig( const string &propDpName, string &config )
{
  while (!dpExists(propDpName))
  {
    delay(0,100);
  }
  dpGetCache( propDpName + ".Settings.Config" + AES_ONLVAL, config );
}


bool aes_operationPermission( const string configName, const int type, const int operation )
{
  if( !AES_PROTECTION_ON )
  {
    return true;
  }

  // type == AES_OPERTYPE_SCREEN / AES_OPERTYPE_PROPERTIES 

  if( configName == AES_DEFPROT_SCREEN_DEFAULT ||
      configName == AES_DEFPROT_SCREEN_ALERTS ||
      configName == AES_DEFPROT_SCREEN_EVENTS ||
      configName == AES_DEFPROT_SCREEN_COMMAND ||
      configName == AES_DEFPROT_SCREEN_ALERTROW ||
      //////
      configName == AES_DEFPROT_PROP_ALERTS ||
      configName == AES_DEFPROT_PROP_EVENTS ||
      configName == AES_DEFPROT_PROP_COMMAND ||
      configName == AES_DEFPROT_PROP_ALERTROW )
  {
    return false;
  }

  return true;
}


void aes_addScreenConfig()
{
  const int d=0;

  dyn_string ds;
  dyn_float df;

  string screenConfigDp, configName;
  dyn_string configs;
  int ret=0;
  bool arVal;
  bool createLocal = false;

  aes_debug( "aesconfig text="+cb_aesConfig.text, d );

  getValue( "cb_aesConfig",
            "text", configName,
            "items", configs );

  if( ( configName=aec_inputDialog( AEC_INPUTID_NEWSCREENCONFIG ) ) == "" )
    return;
  
  if (distsync_isConfigured())
  {
      if (distsync_amIMasterSystem())
      createLocal = distsync_ShowLocalMessage(DISTSYNC_AESCREEN_MASTER);
    else
      createLocal = distsync_ShowLocalMessage(DISTSYNC_AESCREEN);
  }

  if( ! aes_operationPermission( configName, AES_OPERTYPE_SCREEN, AES_OPER_NEW ) )
  {
     ChildPanelOnCentralModal("vision/MessageWarning",
      getCatStr("para","warning"),
      makeDynString(getCatStr("general","permission")));
    return;
  }

  // name must be unique
  if( dynContains( configs, configName ) == 0 )
  {
    screenConfigDp=aes_getPropDpName( AES_DPTYPE_SCREEN, false, AESTAB_GENERAL, false, false, createLocal); 

    aes_debug(__FUNCTION__ + "() screenConfigDp="+screenConfigDp, d );

    if( !dpExists(screenConfigDp))
    {
      aesGenerateDp( screenConfigDp, _AES_DPTYPE_SCREEN );
      delay(1);
    }
    if( !dpExists(screenConfigDp) )
    {
       aes_message( AESMSG_DPCREATE_FAILED, makeDynString( screenConfigDp ), 1, __FUNCTION__ );
       ret=-1;
       return;
    }
  }
  else
  {
    ChildPanelOnCentralModal("vision/MessageWarning",
                             getCatStr("para","warning"),
                             makeDynString(getCatStr("general","existcfg")));

    return;
  }

  // a new config will not be the default one
  chk_default.state(0)=false;

  if( g_alertRow )
  {
    arVal=true;
  }
  else
  {
    arVal=false;
  }


  // set name for new screen config
  dpSetCache(  screenConfigDp + ".Name" + AES_ORIVAL, configName,
              screenConfigDp + ".AlertRow" + AES_ORIVAL, arVal );


  // saving values to dp
  aes_saveScreenConfig( configName, ret );

  if( ret == 0 )
  {
    dynAppend( configs, configName );
    dynSortAsc( configs );

    // write back new itemlist and set active item
    setValue( "cb_aesConfig", "items", aes_resortConfigs( configs ),
              "text", configName );

    //set local flag
    setValue( "chk_local", "state", 0, createLocal);
    
    aec_setGeneralTabEnabledState( configName );
  }
}


void aes_saveScreenConfig( const string &screenConfig, int &ret )
{
  const int d=0;
  
  bool activeTop, activeBot;
  string scTop, scBot;
  string propTop, propBot;
  string configTop, configBot;
  bool def; 
  string scDp;
  int screenTypeTop, screenTypeBot;
  int n, l;
  int iFilterType;
  string sFilterType; 
  
  dyn_string dsRealNames, dsDpNames;
  dyn_bool dbDefaults;

  ret=0;

  if( ! aes_operationPermission( screenConfig, AES_OPERTYPE_SCREEN, AES_OPER_SAVE ) )
  {
     ChildPanelOnCentralModal("vision/MessageWarning",
      getCatStr("para","warning"),
      makeDynString(getCatStr("general","permission")));
    return;
  }
  
  if (distsync_amIClientSystem() && !chk_local.state(0))
  {
    distsync_ShowLocalMessage(DISTSYNC_AESCREENWARNING);
  }

  // read all values from general tab
  getMultiValue(
    "chk_activeTop", "state", 0, activeTop,
    "chk_activeBot", "state", 0, activeBot,
    "cb_screenTypeTop", "text", scTop,
    "cb_screenTypeBot", "text", scBot,
    "te_proportionTop", "text", propTop,
    "te_proportionBot", "text", propBot,
    "cb_configTop", "text", configTop,
    "cb_configBot", "text", configBot,
    "rabo_FilterType", "number", iFilterType
    //"chk_default", "state", 0, def 
  );

  aes_getDpName4RealName( screenConfig, AES_DPTYPE_SCREEN, AESTYPE_GENERAL, scDp );

  if( scDp == "" )
  {
    aes_debug(__FUNCTION__+"() Empty screenconfigdatapointname !", d );
    ret=-1;
    return;
  }
 
  screenTypeTop=aes_getAENumLang( scTop );
  screenTypeBot=aes_getAENumLang( scBot );
  
  if ( getUserPermission(g_setAliasPermission) )
  {
    switch (iFilterType)
    {
      case 0: sFilterType = "NONE";break; 
      case 1: sFilterType = "GLOBAL";break; 
      case 2: sFilterType = "GROUP" + ":" + cb_FilterType.text ;break; 
      case 3: sFilterType = "USER"  + ":" + cb_FilterType.text;break; 
      default: sFilterType = "UNKNOWN";break; 
    }
    
    dpSetComment(scDp + ".Name", sFilterType);
  }
  
  
  // save values to dp
  if ( dpSetCache(
    scDp + ".Top.Active" + AES_ORIVAL, activeTop,
    scDp + ".Bot.Active" + AES_ORIVAL, activeBot,
    scDp + ".Top.ScreenType" + AES_ORIVAL, screenTypeTop,
    scDp + ".Bot.ScreenType" + AES_ORIVAL, screenTypeBot,
    scDp + ".Top.Proportion" + AES_ORIVAL, propTop,
    scDp + ".Bot.Proportion" + AES_ORIVAL, propBot,
    scDp + ".Top.Config" + AES_ORIVAL, configTop,
    scDp + ".Bot.Config" + AES_ORIVAL, configBot ) )
    //scDp + ".UseAsDefault" + AES_ORIVAL, def ) )
  {
    aes_debug(__FUNCTION__+"() dpSet for dp="+scDp+" failed !", d );
    ret=-1;
    return;
  }

}


void aes_setDefaultScreenConfig()
{
  string screenConfig, scDp;
  dyn_string dsRealNames, dsDpNames;
  dyn_bool dbDefaults;

  int l, n;
  bool defState;
  int arMode;

  if( g_alertRow )
  {
    arMode=AES_ARPROP_ONLY;
  }
  else
  {
    arMode=AES_ARPROP_EXCL;
  }

  // get defaultstate
  defState=chk_default.state(0);

  // get config name
  screenConfig=cb_aesConfig.text;

  // find config dp
  aes_getDpsPerType( dsRealNames, dsDpNames, dbDefaults, AES_DPTYPE_SCREEN, AESTYPE_GENERAL, false, arMode );

  l=dynlen( dsDpNames );
  if( l < 1 )
  {
    // message
    return;
  }
  
  for( n=1; n <= l; n++ )
  {
    if( scDp == dsDpNames[n] )
    {
      dpSetCache( dsDpNames[n] + ".UseAsDefault" + AES_ORIVAL, defState );
    }
    else
    {
      dpSetCache( dsDpNames[n] + ".UseAsDefault" + AES_ORIVAL, false );
    }
  }

}


void aes_removeScreenConfig( string screenConfig, int &ret )
{
  const int d=0;
  string scDp;
  dyn_string configs;
  int pos;
  ret=0;

  if( ! aes_operationPermission( screenConfig, AES_OPERTYPE_SCREEN, AES_OPER_REMOVE ) )
  {
     ChildPanelOnCentralModal("vision/MessageWarning",
      getCatStr("para","warning"),
      makeDynString(getCatStr("general","permission")));
    return;
  }

  aes_getDpName4RealName( screenConfig, AES_DPTYPE_SCREEN, AESTYPE_GENERAL, scDp );

  if( scDp != "" )
  {
    if( getUserPermission(4) )
    {
      dpRemoveCache( scDp );
      if ( dpDelete( scDp ) != 0 )
      {
        aes_debug(__FUNCTION__+"() dpDelete for dp="+scDp+" failed !", 10 ); 
        ret=-1;
      }
    }
  }
  else
  {
    aes_debug(__FUNCTION__+"() Empty dp name !", d );
    ret=-1;
  }

  configs=cb_aesConfig.items;

  if( ret==0 )
  {
    // if remove was successfull
    pos=dynContains( configs, screenConfig );
    dynRemove( configs, pos );  
    dynSortAsc( configs );
    
    // in this case we have to activate the first config
    if ( dynlen( configs ) > 0 )
    {
      screenConfig=configs[1];
    }
    else
    {
      screenConfig="";
    }

    setValue( "cb_aesConfig", "items", aes_resortConfigs( configs ),
              "text", screenConfig );

    // load new screenconfig settings
    aes_screenConfigChanged( screenConfig );
  }  

}


void aes_screenConfigChanged( const string screenConfigName )
{

  aec_setGeneralTabEnabledState( screenConfigName );
  
  // we have to call it twice - for top and bottom
  aes_treatScreenConfigChange( AESTAB_TOP, screenConfigName );   // jetzt in lib
  aes_treatScreenConfigChange( AESTAB_BOT, screenConfigName );   // jetzt in lib
}


void aes_renameScreenConfig( const string &oldScreenConfig )
{
  int pos, ret;
  string newScreenConfig;
  dyn_string configs, ds;
  dyn_float df;
  string scDp;

  ret=0;

  if (distsync_amIClientSystem() && !chk_local.state(0))
  {
    distsync_ShowLocalMessage(DISTSYNC_AESCREENWARNING);
  }  
  
  // dialog for config name
  ChildPanelOnCentralModalReturn("vision/MessageInput",
    getCatStr("profibus","conf"),
    makeDynString(getCatStr("dpeMonitor","dpeMon_please_enter"),"%s",""),
    df, ds);

  // nothing enterd
  if ( dynlen(ds) < 1 || ( newScreenConfig=strrtrim(strltrim(ds[1]))) == "" )
  {
    ret=-1;
    return;
  }


  if( ! aes_operationPermission( newScreenConfig, AES_OPERTYPE_SCREEN, AES_OPER_RENAME ) )
  {
     ChildPanelOnCentralModal("vision/MessageWarning",
      getCatStr("para","warning"),
      makeDynString(getCatStr("general","permission")));
    return;
  }


  // read exiting names
  configs=cb_aesConfig.items;

  // check whether new name already exists
  if( dynContains( configs, newScreenConfig ) > 0 )
  {
    // dialog - name already exists, try another one
    return;
  }

  aes_getDpName4RealName( oldScreenConfig, AES_DPTYPE_SCREEN, AESTYPE_GENERAL, scDp );

  // rename
  if( dpSetCache( scDp + ".Name" + AES_ORIVAL, newScreenConfig ) )
  {
    aes_debug(__FUNCTION__+"() dpSet failed !" );
    ret=-1;
  }

  if( ret==0 )
  {
    // find old name, remove it from list and add new name
    pos=dynContains( configs, oldScreenConfig );
    if( pos > 0 )
    {
      configs[pos]=newScreenConfig;
    }

    dynSortAsc( configs );
    // write back changes
    cb_aesConfig.items=aes_resortConfigs( configs );      
    cb_aesConfig.selectedPos=pos;
    //cb_aesConfig.selectedText=newScreenConfig;
  }

}


void aes_copyProperties( const string dpSource, const string dpTarget, const unsigned screenType=AESTYPE_ALERTS, bool configPanel=false )
{
  time begin, end, tmpTime;
  int mode; // entspricht type

  langString geHeader;
  string fiShortcut, fiPrio, fiDpComment, fiAlertText;
  dyn_string fiDpList, soList, sortList, visibleList, viList, colNames, colTitles;

  dyn_int fiTypeSelections;
  int fiAlertSummary;
  int fiState, fiLink, fiMode, fiDir;
  bool fiRow;

  uint uHistoricalDataInterval, uHistoricalDataInterval2;
  int tiType, tiMaxLines;
  bool tiChrono, tiSort, tiHist;
  int  tiSelection, tiShift;
  time tiBegin, tiEnd;

  dyn_string fiSelectedSystemNames, dsTmp;
  int i, ic;

  ///////////
  //// events
  bit32 b32;
  string fiEDpComment;
  dyn_string fiEDpList;
  dyn_int fiETypeSelections;
  bool bCheckSys;
  string theSysName;

  bool bUpdateLines;

  langString geHeader2;
  string fiShortcut2, fiPrio2, fiDpComment2, fiAlertText2;
  dyn_string fiDpList2, soList2, sortList2, visibleList2, viList2, colNames2, colTitles2;
  dyn_string sortListWithAsc, sortListWithAsc2;
  dyn_bool sortAsc, sortAsc2;

  dyn_int fiTypeSelections2;
  int fiAlertSummary2;
  int fiState2, fiLink2, fiMode2, fiDir2;
  bool fiRow2;

  int tiType2, tiMaxLines2;
  bool tiChrono2, tiSort2, tiHist2;
  int  tiSelection2, tiShift2;
  time tiBegin2, tiEnd2;

  dyn_string fiSelectedSystemNames2, dsTmp2;
  bit32 b322;
  string fiEDpComment2;
  dyn_string fiEDpList2;
  dyn_int fiETypeSelections2;
  bool bCheckSys2;
  string theSysName2;
 
  dyn_string dsABLEComment, dsEBLEComment;
  dyn_string dsABLEComment2, dsEBLEComment2;
  
  string originalConfigName, configName;
  
  // _add_values filters
  dyn_string fiAddVal_Val, fiAddVal_Comb, fiAddVal_Comp, fiAddVal_IDX;  
  
  // contextMenu
  dyn_bool dbAvailableItems;
  
  if( dpSource != "" )
  {
    dpGetCache(
    dpSource + ".Name"+AES_ONLVAL, originalConfigName,
    //dpSource + ".Settings.ScreenType"+AES_ONLVAL, screenType,
    //dpSource + ".Settings.User"+AES_ONLVAL, getUserId(),
    //propFilterGeneral
    dpSource + ".Both.General.Header"+AES_ONLVAL, geHeader,
    //propFilter
    dpSource + ".Alerts.Filter.Shortcut"+AES_ONLVAL, fiShortcut,
    dpSource + ".Alerts.Filter.Prio"+AES_ONLVAL, fiPrio,
    dpSource + ".Alerts.Filter.DpComment"+AES_ONLVAL, fiDpComment,
    dpSource + ".Alerts.Filter.AlertText"+AES_ONLVAL, fiAlertText,
    dpSource + ".Alerts.Filter.LogicalCombine"+AES_ONLVAL, fiLink,
    dpSource + ".Alerts.Filter.DpList"+AES_ONLVAL, fiDpList,
    dpSource + ".Alerts.Filter."+ADD_VALUE_VALUE+AES_ONLVAL, fiAddVal_Val,     
    dpSource + ".Alerts.Filter."+ADD_VALUE_COMBINE+AES_ONLVAL, fiAddVal_Comb,  
    dpSource + ".Alerts.Filter."+ADD_VALUE_COMPARE+AES_ONLVAL, fiAddVal_Comp,  
    dpSource + ".Alerts.Filter."+ADD_VALUE_INDEX+AES_ONLVAL, fiAddVal_IDX,     
    //propFilterTypes
    dpSource + ".Alerts.FilterTypes.Selections"+AES_ONLVAL, fiTypeSelections,
    //dpSource + ".Alerts.FilterTypes.AlertSummary"+AES_ONLVAL, fiAlertSummary,
    dpSource + ".Alerts.FilterTypes.AlertSummary"+AES_ONLVAL, fiAlertSummary,
    //propFilterState
    dpSource + ".Alerts.FilterState.State"+AES_ONLVAL, fiState,
    dpSource + ".Alerts.FilterState.OneRowPerAlert"+AES_ONLVAL, fiRow,
    dpSource + ".Alerts.FilterState.OpenClosedMode"+AES_ONLVAL, fiMode,
    dpSource + ".Alerts.FilterState.Direction"+AES_ONLVAL, fiDir,
    //propSort
    dpSource + ".Both.Sorting.SortList"+AES_ONLVAL, sortListWithAsc,
    //propSort
    dpSource + ".Both.Visible.VisibleColumns"+AES_ONLVAL, visibleList,
    //propTimerange
    dpSource + ".Both.Timerange.Type"+AES_ONLVAL, tiType,
    dpSource + ".Both.Timerange.MaxLines"+AES_ONLVAL, tiMaxLines,
    dpSource + ".Both.Timerange.CameWentSort"+AES_ONLVAL, tiSort,
    dpSource + ".Both.Timerange.HistoricalData"+AES_ONLVAL, tiHist,
    dpSource + ".Both.Timerange.Selection"+AES_ONLVAL, tiSelection,
    dpSource + ".Both.Timerange.Shift"+AES_ONLVAL, tiShift,
    dpSource + ".Both.Timerange.Begin"+AES_ONLVAL, tiBegin,
    dpSource + ".Both.Timerange.End"+AES_ONLVAL, tiEnd,
    dpSource + ".Both.Timerange.HistoricalDataInterval" + AES_ONLVAL, uHistoricalDataInterval,
    //propFilterSystems
    dpSource + ".Both.Systems.Selections"+AES_ONLVAL, fiSelectedSystemNames,
    dpSource + ".Both.Systems.CheckAllSystems"+AES_ONLVAL, bCheckSys,

    ///////////////
    /// + event dpe
    //propFilter
    dpSource + ".Events.Filter.DpComment"+AES_ONLVAL, fiEDpComment,
    dpSource + ".Events.Filter.Userbits"+AES_ONLVAL, b32,
    dpSource + ".Events.Filter.DpList"+AES_ONLVAL, fiEDpList,
    //propFilterTypes
    dpSource + ".Events.FilterTypes.Selections"+AES_ONLVAL, fiETypeSelections ,
    dpSource + ".Alerts.Filter.BLEComment"+AES_ONLVAL, dsABLEComment,
    dpSource + ".Events.Filter.BLEComment"+AES_ONLVAL, dsEBLEComment,

    dpTarget + ".Name" + AES_ONLVAL, configName,
    dpTarget + ".Both.General.Header", geHeader2,     
    dpTarget + ".Both.General.Header"+AES_ORIVAL, geHeader2,
    dpTarget + ".Alerts.Filter.Shortcut"+AES_ORIVAL, fiShortcut2,
    dpTarget + ".Alerts.Filter.Prio"+AES_ORIVAL, fiPrio2,
    dpTarget + ".Alerts.Filter.DpComment"+AES_ORIVAL, fiDpComment2,
    dpTarget + ".Alerts.Filter.AlertText"+AES_ORIVAL, fiAlertText2,
    dpTarget + ".Alerts.Filter.LogicalCombine"+AES_ORIVAL, fiLink2,
    dpTarget + ".Alerts.Filter.DpList"+AES_ORIVAL, fiDpList2,
    dpTarget + ".Alerts.FilterTypes.Selections"+AES_ORIVAL, fiTypeSelections2,
    dpTarget + ".Alerts.FilterTypes.AlertSummary"+AES_ORIVAL, fiAlertSummary2,
    dpTarget + ".Alerts.FilterState.State"+AES_ORIVAL, fiState2,
    dpTarget + ".Alerts.FilterState.OneRowPerAlert"+AES_ORIVAL, fiRow2,
    dpTarget + ".Alerts.FilterState.OpenClosedMode"+AES_ORIVAL, fiMode2,
    dpTarget + ".Alerts.FilterState.Direction"+AES_ORIVAL, fiDir2,
    dpTarget + ".Both.Sorting.SortList"+AES_ORIVAL, sortListWithAsc2,    
    dpTarget + ".Both.Visible.VisibleColumns"+AES_ORIVAL, visibleList2,
    dpTarget + ".Both.Timerange.Type"+AES_ORIVAL, tiType2,         
    dpTarget + ".Both.Timerange.MaxLines"+AES_ORIVAL, tiMaxLines2,
    dpTarget + ".Both.Timerange.CameWentSort"+AES_ORIVAL, tiSort2,
    dpTarget + ".Both.Timerange.HistoricalData"+AES_ORIVAL, tiHist2,
    dpTarget + ".Both.Timerange.Selection"+AES_ORIVAL, tiSelection2,
    dpTarget + ".Both.Timerange.Shift"+AES_ORIVAL, tiShift2,
    dpTarget + ".Both.Timerange.Begin"+AES_ORIVAL, tiBegin2,
    dpTarget + ".Both.Timerange.End"+AES_ORIVAL, tiEnd2,
    dpTarget + ".Both.Timerange.HistoricalDataInterval" + AES_ORIVAL, uHistoricalDataInterval2,
    dpTarget + ".Both.Systems.Selections"+AES_ORIVAL, fiSelectedSystemNames2,
    dpTarget + ".Both.Systems.CheckAllSystems"+AES_ORIVAL, bCheckSys2,
    dpTarget + ".Events.Filter.DpComment"+AES_ORIVAL, fiEDpComment2,
    dpTarget + ".Events.Filter.Userbits"+AES_ORIVAL, b322,
    dpTarget + ".Events.Filter.DpList"+AES_ORIVAL, fiEDpList2,
    dpTarget + ".Events.FilterTypes.Selections"+AES_ORIVAL, fiETypeSelections2,
    dpTarget + ".Alerts.Filter.BLEComment"+AES_ONLVAL, dsABLEComment2,
    dpTarget + ".Events.Filter.BLEComment"+AES_ONLVAL, dsEBLEComment2);
  }

  // update lists for possible configuration change
  aes_getVisibleColumnList( screenType, colNames, colTitles, true, configPanel );
  
  //split Sortlist
  aes_splitSortList(sortListWithAsc, sortList, sortAsc);
  aes_splitSortList(sortListWithAsc2, sortList2, sortAsc2);  
  
  aes_removeUnsatisfiedColumns( colNames, sortList, sortAsc, true );
  dyn_bool tmpdb;
  aes_removeUnsatisfiedColumns( colNames, visibleList, tmpdb, false );

  // correct timerange
  ////////////////////

  aes_getBeginEndTime( tiBegin, tiEnd, tiSelection, tiShift );

  theSysName=getSystemName();
  strreplace( theSysName, ":", "" );

  // remove illegal systems
  ic=1;
  for( i=1; i<=dynlen(fiSelectedSystemNames);i++)
  {
    if( fiSelectedSystemNames[i] != "" )
    {
      dsTmp[ic]=fiSelectedSystemNames[i];  
      ic++;
    }
  }

  dynClear( fiSelectedSystemNames );
  fiSelectedSystemNames=dsTmp;

  // new - if we have non system selected - select your own system
  if( dynlen( fiSelectedSystemNames ) <= 0 )
  {
    fiSelectedSystemNames=makeDynString( theSysName );
  }

  bUpdateLines = (geHeader2 !=     geHeader ||
                 fiShortcut2 !=    fiShortcut ||
                 fiPrio2 !=    fiPrio ||
                 fiDpComment2 !=     fiDpComment ||
                 fiAlertText2 !=     fiAlertText ||
                 fiLink2 !=    fiLink ||
                 fiDpList2 !=    fiDpList ||
                 fiTypeSelections2 !=    fiTypeSelections ||
                 fiAlertSummary2 !=    fiAlertSummary ||
                 fiState2 !=     fiState ||
                 fiRow2 !=     fiRow ||
                 fiMode2 !=    fiMode ||
                 fiDir2 !=     fiDir ||
                 sortList2 !=    sortList ||
                 visibleList2 !=     visibleList ||
                 tiType2 !=              tiType ||         
                 tiMaxLines2 !=    tiMaxLines ||
                 tiSort2 !=    tiSort ||
                 tiHist2 !=    tiHist ||
                 uHistoricalDataInterval2 != uHistoricalDataInterval || 
                 tiSelection2 !=     tiSelection ||
                 tiShift2 !=     tiShift ||
                 bCheckSys2 !=     bCheckSys ||
                 fiEDpComment2 !=    fiEDpComment ||
                 b322 !=     b32 ||
                 fiEDpList2 !=     fiEDpList ||
                 fiETypeSelections2 !=     fiETypeSelections  ||
                 dsABLEComment != dsABLEComment2 ||
                 dsEBLEComment != dsEBLEComment2 ||
                 originalConfigName != configName);

  if (!bUpdateLines)
     return;

  // know - copy values to runtime dp
  if( dpSetCache(
    dpTarget + ".Name"+AES_ORIVAL, originalConfigName,
    //dpTarget + ".Settings.ScreenType"+AES_ORIVAL, screenType,   // set happens in calling function, NOT here !!!
    //dpTarget + ".Settings.User"+AES_ORIVAL, getUserId(),
    //propFilterGeneral
    dpTarget + ".Both.General.Header"+AES_ORIVAL, geHeader,
    //propFilter
    dpTarget + ".Alerts.Filter.Shortcut"+AES_ORIVAL, fiShortcut,
    dpTarget + ".Alerts.Filter.Prio"+AES_ORIVAL, fiPrio,
    dpTarget + ".Alerts.Filter.DpComment"+AES_ORIVAL, fiDpComment,
    dpTarget + ".Alerts.Filter.AlertText"+AES_ORIVAL, fiAlertText,
    dpTarget + ".Alerts.Filter.LogicalCombine"+AES_ORIVAL, fiLink,
    dpTarget + ".Alerts.Filter.DpList"+AES_ORIVAL, fiDpList,
    dpTarget + ".Alerts.Filter."+ADD_VALUE_VALUE+AES_ORIVAL, fiAddVal_Val,     
    dpTarget + ".Alerts.Filter."+ADD_VALUE_COMBINE+AES_ORIVAL, fiAddVal_Comb,  
    dpTarget + ".Alerts.Filter."+ADD_VALUE_COMPARE+AES_ORIVAL, fiAddVal_Comp,  
    dpTarget + ".Alerts.Filter."+ADD_VALUE_INDEX+AES_ORIVAL, fiAddVal_IDX,     
    //propFilterTypes
    dpTarget + ".Alerts.FilterTypes.Selections"+AES_ORIVAL, fiTypeSelections,
//    dpTarget + ".Alerts.FilterTypes.AlertSummary"+AES_ORIVAL, fiAlertSummary,
    dpTarget + ".Alerts.FilterTypes.AlertSummary"+AES_ORIVAL, fiAlertSummary,
    //propFilterState
    dpTarget + ".Alerts.FilterState.State"+AES_ORIVAL, fiState,
    dpTarget + ".Alerts.FilterState.OneRowPerAlert"+AES_ORIVAL, fiRow,
    dpTarget + ".Alerts.FilterState.OpenClosedMode"+AES_ORIVAL, fiMode,
    dpTarget + ".Alerts.FilterState.Direction"+AES_ORIVAL, fiDir,
    //propSort
    dpTarget + ".Both.Sorting.SortList"+AES_ORIVAL, sortListWithAsc,  //sortList with including booleans (-> asc...true, desc...false)
    //propSort
    dpTarget + ".Both.Visible.VisibleColumns"+AES_ORIVAL, visibleList,
    //propTimerange
    dpTarget + ".Both.Timerange.Type"+AES_ORIVAL, tiType,          /// Achtung bei events!!! open=1, closed=2 !!!!
    dpTarget + ".Both.Timerange.MaxLines"+AES_ORIVAL, tiMaxLines,
    dpTarget + ".Both.Timerange.CameWentSort"+AES_ORIVAL, tiSort,
    dpTarget + ".Both.Timerange.HistoricalData"+AES_ORIVAL, tiHist,
    dpTarget + ".Both.Timerange.Selection"+AES_ORIVAL, tiSelection,
    dpTarget + ".Both.Timerange.Shift"+AES_ORIVAL, tiShift,
    dpTarget + ".Both.Timerange.Begin"+AES_ORIVAL, tiBegin,
    dpTarget + ".Both.Timerange.End"+AES_ORIVAL, tiEnd,
    dpTarget + ".Both.Timerange.HistoricalDataInterval", uHistoricalDataInterval,
    //propFilterSystems
    dpTarget + ".Both.Systems.Selections"+AES_ORIVAL, fiSelectedSystemNames,
    dpTarget + ".Both.Systems.CheckAllSystems"+AES_ORIVAL, bCheckSys,

    ///////////////
    /// + event dpe
    //propFilter
    dpTarget + ".Events.Filter.DpComment"+AES_ORIVAL, fiEDpComment,
    dpTarget + ".Events.Filter.Userbits"+AES_ORIVAL, b32,
    dpTarget + ".Events.Filter.DpList"+AES_ORIVAL, fiEDpList,
    //propFilterTypes
    dpTarget + ".Events.FilterTypes.Selections"+AES_ORIVAL, fiETypeSelections,
    dpTarget + ".Alerts.Filter.BLEComment"+AES_ORIVAL, dsABLEComment,
    dpTarget + ".Events.Filter.BLEComment"+AES_ORIVAL, dsEBLEComment) == -1 )
    {
      aes_debug(__FUNCTION__+"() dpSetWait() failed !" );
    }

    // activate when func ready
    //aes_setDefPropInitSettingsVal( dpTarget );
}


void aes_setDefPropInitSettingsVal( string dpTarget )
{
  dpSetCache(  dpTarget + ".Settings.TabType"+AES_ORIVAL,    0,
              dpTarget + ".Settings.Active"+AES_ORIVAL,     false,
              dpTarget + ".Settings.ScreenType"+AES_ORIVAL, 0,
              dpTarget + ".Settings.Proportion"+AES_ORIVAL, 0,
              dpTarget + ".Settings.Config"+AES_ORIVAL,     "",
              dpTarget + ".Settings.User"+AES_ORIVAL,       "",
              dpTarget + ".Settings.Changed"+AES_ORIVAL,    0,
              dpTarget + ".Settings.Cancel"+AES_ORIVAL,     0,
              dpTarget + ".Settings.RunCommand"+AES_ORIVAL, 0,
              dpTarget + ".Settings.RunMode"+AES_ORIVAL,    0,
              dpTarget + ".Settings.Action"+AES_ORIVAL,     0,
              dpTarget + ".Settings.AlertRow"+AES_ORIVAL,   0,
              dpTarget + ".Settings.FileName"+AES_ORIVAL,   "" );

}


void aes_getDpName4RealName( const string &realName, const unsigned dpType, const unsigned screenType, string &dpName )
{
  dyn_string dsRealNames, dsDpNames;
  dyn_bool dbDefaults;

  int i,l;
  int pos;

  addGlobal("gdsrealNameCache", DYN_STRING_VAR);
  addGlobal("gdsdpNameCache", DYN_STRING_VAR);

  pos = dynContains(gdsrealNameCache, realName+dpType+screenType);
  if ( pos > 0 && dpExists(gdsdpNameCache[pos]))
  {
    dpName = gdsdpNameCache[pos];
    return;
  }
  else
  {
    dpName="";
    dynClear(gdsrealNameCache);
    dynClear(gdsdpNameCache);
    // get all dpnames for specified dpType / screenType
    aes_getDpsPerType( dsRealNames, dsDpNames, dbDefaults, dpType, screenType, false , AES_ARPROP_INCL);  // IM 88068 incl AES_ROW

    for (i=1; i<= dynlen( dsRealNames); i++)
        dynAppend(gdsrealNameCache,dsRealNames[i]+dpType+screenType);
    
    dynAppend(gdsdpNameCache ,dsDpNames);

    pos = dynContains(gdsrealNameCache, realName+dpType+screenType);
    if ( pos > 0)
    {
      dpName = gdsdpNameCache[pos];
    }
  }
}


void aes_getDpsPerType( dyn_string &realNames, dyn_string &dps, dyn_bool &dbdef, int dpType, int screenType=AESTYPE_GENERAL, bool runtime=false, int alertRowMode=AES_ARPROP_EXCL )
{
  addGlobal("g_mgetDpsPerType_realNames", MAPPING_VAR);
  addGlobal("g_mgetDpsPerType_dps", MAPPING_VAR);
  addGlobal("g_mgetDpsPerType_dbdef", MAPPING_VAR);
  addGlobal("g_mgetDpsPerTypeKey_Screen", MAPPING_VAR);
  addGlobal("g_mgetDpsPerTypeKey_Properties", MAPPING_VAR);
  const string APP="_*";
  const string RT="RT";
  string DPAPP=".Name" + AES_ONLVAL;
  string DPSTAPP=".Settings.ScreenType" + AES_ONLVAL;
  string DEFAPP=".UseAsDefault" + AES_ONLVAL;
  string ALERTROW=".Settings.AlertRow" + AES_ONLVAL;
  int count;
  time t = getCurrentTime();
  dyn_string dsDpGetArray;
  dyn_anytype daDpGetAnswer;

  
  string sCheck =  dpType + "_"+screenType+"_"+runtime+"_"+alertRowMode;  

  int i,l;
  string realName, pattern, strType;
  dyn_string dpsTmp;
  bool alertRow;
  bool bMatching;

  dynClear( realNames );
  dynClear( dps );
  dynClear( dbdef );

  if( dpType == AES_DPTYPE_SCREEN )
  {
    strType=_AES_DPTYPE_SCREEN;
    pattern=_AES_DPTYPE_SCREEN + APP;
  }
  else if( dpType == AES_DPTYPE_PROPERTIES )
  {
    strType=_AES_DPTYPE_PROPERTIES;
    pattern=_AES_DPTYPE_PROPERTIES;
    if( runtime )
      pattern+=RT + APP;
    else
      pattern+=APP;
  }
  else
  {
    aes_debug( __FUNCTION__+"() / Unknown dpType="+dpType, 1 );
  }

  dpsTmp=dpNames( pattern, strType );

  if( dpType == AES_DPTYPE_SCREEN )                                                 // builed chache and use it if possible !! 
  {
   if (  mappingHasKey(g_mgetDpsPerTypeKey_Screen, sCheck))
   {
       bMatching = ( dpsTmp == g_mgetDpsPerTypeKey_Screen[sCheck]);   
   }
   g_mgetDpsPerTypeKey_Screen[sCheck] = dpsTmp;
  }
  else if( dpType == AES_DPTYPE_PROPERTIES )
  {
    if (  mappingHasKey(g_mgetDpsPerTypeKey_Properties, sCheck))
    {
      bMatching = ( dpsTmp == g_mgetDpsPerTypeKey_Properties[sCheck]);   
    }
    g_mgetDpsPerTypeKey_Properties[sCheck] = dpsTmp;
  }

  if (bMatching)  // check cache !!!!
  {
    if (mappingHasKey(g_mgetDpsPerType_realNames, sCheck))
    {
       realNames = g_mgetDpsPerType_realNames[sCheck];
       dps =       g_mgetDpsPerType_dps[sCheck];
       dbdef =     g_mgetDpsPerType_dbdef[sCheck];

       for (int i=dynlen(dps); i>0; i--)
         if (!aes_checkPermissionFilterType(dps[i]))
         {
           dynRemove(realNames, i); 
           dynRemove(dps, i); 
           dynRemove(dbdef, i);       
         }
       return; 
    }
  }

  l=dynlen(dpsTmp);

  for( i=1; i <= l; i++ )
  {    
    dynAppend( dsDpGetArray, dpsTmp[i]+DPAPP ); 

    if( dpType == AES_DPTYPE_SCREEN )
    {
      dynAppend( dsDpGetArray, dpsTmp[i]+DEFAPP ); 
      dynAppend( dsDpGetArray, dpsTmp[i]+".AlertRow" + AES_ONLVAL);
    }

    if( dpType == AES_DPTYPE_PROPERTIES && screenType != AESTYPE_GENERAL )
    {
      dynAppend( dsDpGetArray, dpsTmp[i]+DPSTAPP ); 
      dynAppend( dsDpGetArray, dpsTmp[i]+ALERTROW); 
      dynAppend( dsDpGetArray, dpsTmp[i]+DPSTAPP);
    }
  }

  dynUnique( dsDpGetArray) ; 

  dpGetCache( dsDpGetArray, daDpGetAnswer);

  for( i=1; i <= l; i++ )
  {    
    string sSearchDp = dpsTmp[i];    
    int pos;
    int scrType=0;
    bool bVal=false;
    bool alertRow;
    
   if( dpType == AES_DPTYPE_PROPERTIES && screenType != AESTYPE_GENERAL )
    {
      count++;    
      dpGetCache(  dpsTmp[i]+DPSTAPP, scrType,
              dpsTmp[i]+ALERTROW, alertRow );

      pos = dynContains( dsDpGetArray, dpsTmp[i]+DPSTAPP); 
      if ( pos > 0)
        scrType = daDpGetAnswer[pos];
      else
        continue;
        
      pos = dynContains( dsDpGetArray,  dpsTmp[i]+ALERTROW); 
      if ( pos > 0)
        alertRow = daDpGetAnswer[pos];
      else
        continue;

      pos = dynContains( dsDpGetArray,   dpsTmp[i]+DPAPP); 
      if ( pos > 0)
        realName = daDpGetAnswer[pos];
      else
        continue;

 
      // append these entries only when screenType is equal

      if( alertRowMode == AES_ARPROP_ONLY )     // only alertrow properties
      {
        if( alertRow )   // check even for screentype alerts ???
        {
          dynAppend( dps, dpsTmp[i] );
          dynAppend( realNames, realName );
          dynAppend( dbdef, bVal );
        }
      }
      else if( alertRowMode == AES_ARPROP_INCL )    // all properties  alert+alertRow/events dep on screentype
      {
        if( ( scrType == screenType ) || ( alertRow && ( screenType == AESTYPE_ALERTS ) ) )  // 2. cond to suppress row data at events
        {
          dynAppend( dps, dpsTmp[i] );
          dynAppend( realNames, realName );
          dynAppend( dbdef, bVal );
        }
      }
      else if( alertRowMode == AES_ARPROP_EXCL )
      {
        if( ( scrType == screenType ) && ( ! alertRow ) ) // alerts/events - old mode before alertrow
        {
          dynAppend( dps, dpsTmp[i] );
          dynAppend( realNames, realName );
          dynAppend( dbdef, bVal );
        }
      }
    }
    else //if ( dpType == AES_DPTYPE_SCREEN )
    {
            
      pos = dynContains( dsDpGetArray,   dpsTmp[i]+".AlertRow" + AES_ONLVAL); 
      if ( pos > 0)
        alertRow = daDpGetAnswer[pos];
      else
//        continue;
        alertRow = FALSE;

      pos = dynContains( dsDpGetArray,   dpsTmp[i]+DPAPP); 
      if ( pos > 0)
        realName = daDpGetAnswer[pos];
      else
//        continue;
      realName = "";


      pos = dynContains( dsDpGetArray,   dpsTmp[i]+DEFAPP); 
      if ( pos > 0)
        bVal = daDpGetAnswer[pos];
      else
//        continue;
      bVal = FALSE;
        
      if( alertRowMode == AES_ARPROP_ONLY )
      {
        if( alertRow )  // append only if type alertrow
        {
          dynAppend( dps, dpsTmp[i] );
          dynAppend( realNames, realName );
          dynAppend( dbdef, bVal );
        }
      }
      else if( alertRowMode == AES_ARPROP_INCL )
      {
        // append in any case
        dynAppend( dps, dpsTmp[i] );
        dynAppend( realNames, realName );
        dynAppend( dbdef, bVal );
      }
      else if( alertRowMode == AES_ARPROP_EXCL )
      {
        if( !alertRow ) // append only if type not alert row
        {
          dynAppend( dps, dpsTmp[i] );
          dynAppend( realNames, realName );
          dynAppend( dbdef, bVal );
        }
      }
    }
  }

  g_mgetDpsPerType_realNames[sCheck]= realNames ;     // unfiltered
  g_mgetDpsPerType_dps[sCheck]= dps ;          // unfiltered
  g_mgetDpsPerType_dbdef[sCheck] =dbdef;       // unfiltered

  // now check if it is in group
  
  for (int i=dynlen(dps); i>0; i--)
    if (!aes_checkPermissionFilterType(dps[i]))
    {
      dynRemove(realNames, i); 
      dynRemove(dps, i); 
      dynRemove(dbdef, i);       
    }
  return;
}

bool aes_checkUserLocksOutHimself(string &errMsg)
{
  string userName = getUserName();
  if ( userName == "root")   // root uses no filter
    return false;
  
  int filterType;
  dyn_mapping groups;
  getValue("rabo_FilterType", "number", filterType);
  
  switch ( filterType )
  {
    case 0:              //no filter
    case 1: return false; //for all users
    
    case 2:
      groups = getGroupsOfUserPVSS(getUserId());
      for (int i = dynlen(groups); i > 0; i--) //iterating all groups of current user
        if ( ((mapping)groups[i])["Name"] == cb_FilterType.text ) //checking if group is the selected one
          return false;
      
      sprintf(errMsg, getCatStr("sc", "youAreNotInThisGroup"), cb_FilterType.text);
      return true;
    case 3:
      if ( cb_FilterType.text == userName )
        return false;
      
      sprintf(errMsg, getCatStr("sc", "youAreNotThisUser"), cb_FilterType.text);      
      return true;
  }
  
  return true;
}

//
//  checks if permisson exists otherwide returns FALSE
//
bool aes_checkPermissionFilterType(string dp)
{    
   if (getUserName() == "root")   // root uses no filter
     return TRUE; 
  
   string sFilter = dpGetDescription(dp + ".Name", -2);
     
   if (sFilter == "" || sFilter == "NONE")   // no filter
     return TRUE;         
   else if (sFilter == "GLOBAL")  // for all users
     return TRUE;         
   else if (sFilter == "USER:"+getUserName())  // matches user
     return TRUE;
   else if (strpos (sFilter, "GROUP:") == 0)
   {
     addGlobal("g_aesUserGroupsCache", MAPPING_VAR); 
     dyn_string dsGroups; 
     if (!mappingHasKey(g_aesUserGroupsCache, getUserName()))  // get data from cache
     {
       dyn_mapping dmUserGroup; 
       dmUserGroup = getGroupsOfUserPVSS(getUserId()); 
       for (int i=1; i<=dynlen(dmUserGroup); i++)
          dsGroups[i] = dmUserGroup[i]["Name"];
       g_aesUserGroupsCache[getUserName()]= dsGroups;
     }
     else 
       dsGroups = g_aesUserGroupsCache[getUserName()];  
   
     strreplace(sFilter, "GROUP:", "");
     if (dynContains(dsGroups, sFilter) > 0)
       return TRUE;      
   }
   return FALSE; 
}

//@} RegisterFunctions-end


//@} Functions-end


/**
  Correct begin and end-time depending on range selection (today, yesterday, ...) and shift-selection. 
  @param tb begin time (in only for "any day", "any time")
  @param te end time
  @param pos selected range (1 = today, ...)
  @param shift selected shift (1= whole day, 2..n shifts)
  @author Martin Pallesch
  @version 1.0
  @return nothing
*/
void aes_getBeginEndTime(time &tb, time &te, int pos, int shift)
{
  int startHour;  // hour at which a working-day begins
  int numShifts;

  dpGetCache("_Config.StartHour:_online.._value", startHour,
        "_Config.NumShifts:_online.._value", numShifts);

  if ( (pos != 3) && (pos != 6) ) tb = getCurrentTime(); // on "any day", "any time", calculate from given begin-time
      
  switch ( pos )
  {
    case 1:  // today
    case 2:  // yesterday
    case 3:  // any day
    {
      // shift1 = whole day; shift2 .. shiftN real shifts

      int shiftLen;

      shiftLen = (numShifts > 1) ? (24 / numShifts) : 24;   // shift length in hours

      if ( hour(tb) < startHour ) tb -= 86400; // select correct day
      if ( pos == 2 ) tb -= 86400;  // subtract seconds of 1 day
      
      tb = makeTime(year(tb), month(tb), day(tb),
                    (shift <= 2) ? startHour : (startHour + ((shift - 2) * shiftLen)),
                    0, 0);

      if ( shift == 1 )   // whole day
        te = tb + 86400 - 1;    // one day
      else
        te = tb + shiftLen*3600 - 1;  // one shift

      break;
    }

    case 4:  // this week
    case 5:  // last week
    {
      int day = weekDay(tb);
      
      // select startHour of last monday
      tb = tb - daySecond(tb) - ((day-1)*86400) + (startHour*3600);

      if ( pos == 5 ) tb -= 7 * 86400;  // last week: substract seconds of 1 week 
      
      te = tb + 7*86400 - 1;
      break;
    }
    
    case 6: break;  // any timerange

    case 7:  // last 24 hours
    {
      te = tb;
      tb -= 86400;    // from now, 24 hours back

      break;
    }
    
    default: ;
  }
  
  setPeriod(tb, period(tb),   0);  // start at 0 milliSeconds 
  setPeriod(te, period(te), 999);  // end at 999 milliSeconds 
}
//@} OldFunctionblock-end




///////////////////////////////
//// from aes_peter.ctl - begin
//////////////////////////////{


void aes_mergeSL( const dyn_string &dsSource, const dyn_string dsTarget, dyn_string &dsResult )
{
  int l, n;
  
  dynClear( dsResult );

  // traverse all target items
  l=dynlen(dsTarget);
  if( l <= 0 )
    return;
  
  for( n=1; n <= l; n++ )
  {
    if( dynContains( dsSource, dsTarget[n] ) > 0 )
    {  
      dynAppend( dsResult, dsTarget[n] );
    }
  }  
}


void aes_filterSLItems( const dyn_string colTitles, const dyn_string colNames, dyn_string &dsTitles, dyn_string &dsNames )
{
  const int d=5;
  char c;
  int n,l, ic=1;

  dynClear( dsTitles );
  dynClear( dsNames );

  aes_debug( __FUNCTION__+"() / Called !" );

  // check whether len matches
  if( dynlen(dsTitles) != dynlen(dsNames) )
  {
    aes_debug( __FUNCTION__+"() / dynlen doesn't match !", d );
    return;
  }
  
  l=dynlen(colNames);
  if( l <= 0 )
    return;

  for( n=1; n <= l; n++ )
  {
    if( strltrim( strrtrim( colNames[n] ) ) == "" )
      continue;
    
    c=substr( colNames[n], 0, 1 );

    if( ( c >= 'a' && c <= 'z' ) ||
        ( c >= 'A' && c <= 'Z' ) ||
        ( colNames[n] == _ALERTPANEL_ ) ||   // exception for prop visible => _ALERTPANEL_
        ( colNames[n] == _DETAIL_ ) )        // exception for prop visible => _DETAIL_ 
    {
      dynAppend( dsTitles, colTitles[n] );
      dynAppend( dsNames, colNames[n] );
      
      ic++;
    }
  }
}


string aes_getStringFromLangString( langString ls )
{
  string returnValue = (string) ls;
  if( returnValue == "" )
  {
    // fallback - try to find meta lang
    int idx=getLangIdx( AES_LANG_META ) + 1; // because index starts at zero !!!

    // lang idx von en liefert 256 statt wie erwartet 0 / deshalb ">" statt "<"
    if( idx > getNoOfLangs() )
    {
      // index not found - we will use activeLang index
      idx=getActiveLang() + 1; 
    }

    dyn_string ds=ls;
    return (string)ds[idx];
  }
  else
  {
    return (returnValue);
  }
}


void aes_moveSLItem( const string object, bool up )
{
  string item;
  dyn_string items;
  int selPos, itemCount;

  bool down=(!up);
    
  getValue( object, "items", items,
            "selectedPos", selPos,
            "selectedText", item,
            "itemCount", itemCount );

  if( itemCount <= 1 || selPos <= 0 )
  {
    // nothing to do
    return;
  }

  if( ( selPos==1 && up ) || ( selPos==itemCount && down ) )
  {
    // nothing to do
    return;
  }

  if( up )
  {
    item=items[selPos-1];          // save item
    items[selPos-1]=items[selPos]; // copy item
    items[selPos]=item;
    selPos--;
  }
  else
  {
    item=items[selPos+1];          // save item
    items[selPos+1]=items[selPos]; // copy item
    items[selPos]=item;
    selPos++;
  }

  setValue( object, "items", items,
            "selectedPos", selPos );

}


string aes_getPropDP(bool screen)
{
  return ($CONFIG_NAME);
}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
/*
Used in the AES_Properties panel for getting the selected properties
and setting them onto the _ASProp_? datapoint
Parameters:
  dpProp  ... name of DP on which to set the values (must be of DP-Type _ASConfig); with trailing "."
  configName ... user-defined name of configuration

  screenType ... Alert/Event
  tabType    ... Top/Bottom    // not in use / not necessarry
*/

void aes_setProps(string dpProp, string configName, int screenType, int tabType, int &ret, bool newProperty=false, bool saveToOriginal = true)
{
  int fiState, i, j, chars, chars1, fiLink, fiMode, fiDir, count;
  bool fiPending, b1,b2,b3,b4,b5,b6,b7,b8;
  bit32 b32;
  string dpCheck, gName;
  string fiShortcut, fiPrio, fiDpComment, fiAlertText;
  dyn_string fiDpList, fiDpListDpe, fiDpListGroup, soList, sortList, visibleList, viList;
//  dyn_string colNames, colTitles;
  dyn_bool soAsc, sortAsc;
  dyn_string soListWithAsc;
  dyn_anytype dda;
  
  // propTime
  int tiType, tiMaxLines;
  int iHistDataIntervalMinutes, iHistDataIntervalNumber;
  int tibYear, tibMonth, tibDay, tibHour, tibMinute, tibSecond;
  int tieYear, tieMonth, tieDay, tieHour, tieMinute, tieSecond;
  time tiBegin, tiEnd;
  bool tiChrono, tiSort, tiHist;
  int  tiSelection, tiShift;
  
  langString geHeader;
  string geOneHeader;
  
  int n;
  int fiTypeTable;
  dyn_int fiTypeSelections;
  bool group;
//  bool fiAlertSummary,group;
  int fiAlertSummary;
  dyn_float  dfResult;
  dyn_string dsResult;
  string     msg;
  
  int        k;
  int        fiSystemTable;
  dyn_string fiSystemSelections;
  bool       bCheckSys;
  dyn_string fiAllSystemNames;
  dyn_string fiSelectedSystemNames;
  string     mySystemName;
  dyn_string geBLEComment;
  
  int iFilterType;
  string sFilterType;

  dyn_string dsAddVals;
  dyn_string dsAddValsOperator;
  dyn_string dsAddValsValue;
  dyn_string dsAddValsLink; 
  
  dyn_errClass err;
  
  // default is error !!!
  ret=-1;

  if ( screenType == AESTYPE_ALERTS )
  {
    getMultiValue(//propFilterState
                  "fi_state",      "number", fiState,
                  "fi_mode",       "number", fiMode,
                  "fi_pending",        "state",  0, fiPending,
                  "fi_dir",        "selectedPos", fiDir,
                  //propFilter
                  "fi_link",       "number", fiLink,
                  "fi_shortcut",   "text",   fiShortcut,
                  "fi_prio",       "text",   fiPrio,
                  "fi_dpComment",  "text",   fiDpComment,
                  "fi_alertText",  "text",   fiAlertText,
              //    "fi_dpList",     "items",  fiDpList,
                  "dpeList",       "items",  fiDpListDpe,
                  "groupList",     "items",  fiDpListGroup,
                  //propFilterTypes
//                  "fi_alertSummary", "state", 0, fiAlertSummary,
                  "fi_alertSummary", "number", fiAlertSummary,
                  //propTime
                  "ti_sort",      "state",  0, tiSort,
//                  "ti_hist",      "state",  0, tiHist,    // now at both
                  //propSort
                  "so_table",       "getColumnN", 0, soList,
                  "so_table",       "getColumnN", 2, soAsc,
                  //propVisible
                  "vi_list",      "items",  viList,
                  "tabAddVals", "getColumnN", 4, dsAddVals,
                  "tabAddVals", "getColumnN", 2, dsAddValsOperator,
                  "tabAddVals", "getColumnN", 3, dsAddValsValue,
                  "tabAddVals", "getColumnN", 0, dsAddValsLink
                  );
    if(isFunctionDefined("aes_prepareUserdefinedAlertDisplay"))//IM #117931
      aes_prepareUserdefinedAlertDisplay(fiShortcut,fiPrio);
  }
  else
  if ( screenType == AESTYPE_EVENTS )
  {
    getMultiValue(//propFilter
              //    "fi_dpList",     "items",  fiDpList,
                  "dpeList",       "items",  fiDpListDpe,
                  "groupList",     "items",  fiDpListGroup,
                  "fi_dpComment",  "text",   fiDpComment,
                  "fi_userbit1",   "state","0", b1,
                  "fi_userbit2",   "state","0", b2,
                  "fi_userbit3",   "state","0", b3,
                  "fi_userbit4",   "state","0", b4,
                  "fi_userbit5",   "state","0", b5,
                  "fi_userbit6",   "state","0", b6,
                  "fi_userbit7",   "state","0", b7,
                  "fi_userbit8",   "state","0", b8,
                  //propSort
                  "so_table",       "getColumnN", 0, soList,
                  "so_table",       "getColumnN", 2, soAsc,
                  //propVisible
                  "vi_list",      "items",  viList);
    setBit(b32,24,b1); setBit(b32,25,b2); setBit(b32,26,b3); setBit(b32,27,b4); 
    setBit(b32,28,b5); setBit(b32,29,b6); setBit(b32,30,b7); setBit(b32,31,b8); 
  }

  if ( dynlen( fiDpListDpe) > 0 && dynContains(fiDpListDpe,  "_Config" )< 1 )  // IM 63247 add dummy dp 
    dynAppend(fiDpListDpe, "_Config");
    

  getMultiValue(//propTime
                "ti_hist",      "state",  0, tiHist,        // now at both
                "ti_type",      "number", tiType,
                "ti_maxLines",  "text",   tiMaxLines,
                "ti_selection", "selectedPos", tiSelection,
                "ti_shift",     "selectedPos", tiShift,
                "ti_HistoricalDataInterval", "number", iHistDataIntervalNumber,
                "txtHistoricalDataInterval", "text", iHistDataIntervalMinutes,

                "tib_year",     "text",   tibYear,
                "tib_month",    "text",   tibMonth,
                "tib_day",      "text",   tibDay,
                "tib_hour",     "text",   tibHour,
                "tib_minute",   "text",   tibMinute,
                "tib_second",   "text",   tibSecond,

                "tie_year",     "text",   tieYear,
                "tie_month",    "text",   tieMonth,
                "tie_day",      "text",   tieDay,
                "tie_hour",     "text",   tieHour,
                "tie_minute",   "text",   tieMinute,
                "tie_second",   "text",   tieSecond,
                
                //propGeneral
                "ge_header",    "text",   geOneHeader,
                "ge_headerList","text",   geHeader,
                
                //propFilterTypes
                "fi_typeTable", "lineCount", fiTypeTable,
                
                //propFilterSystems
                "fi_systemTable", "lineCount", fiSystemTable,
                
                "rabo_FilterType", "number", iFilterType
                
                );
  if ( screenType == AESTYPE_ALERTS )
  {
    if (tiType== 0 || tiType == 2)
      tiMaxLines=1;        
  }
  
  if ( shapeExists("ge_BLEComment"))
         getValue("ge_BLEComment", "items", geBLEComment);

  // for events, we have to increment the type ( because we have no current mode )
  if ( screenType == AESTYPE_EVENTS )
  {
    tiType++;
  }

  if ( getNoOfLangs() == 1 ) geHeader = geOneHeader;

  if ( iHistDataIntervalNumber == 0 ) iHistDataIntervalMinutes = 0; //If the central setting for the historical data interval should be used 0 must be set to the internal DPE
  

// write back sort list in any case !!!!    
    for (i = 1; i <= dynlen(soList); i++)
    {
      int j = dynContains(g_colTitles, soList[i]);    // g_colTitles
      dynAppend(sortList, g_colNames[j]);             // g_colNames
      dynAppend(sortAsc, soAsc[i]);                   // sort asc or desc
      dynAppend(soListWithAsc, g_colNames[j]+","+((int)soAsc[i]));
    }
//  }

  // visibleList
  for (i = 1; i <= dynlen(viList); i++)
  {
    int j = dynContains(g_colTitles, viList[i]);      // g_colTiltes
    if ( j > 0 )
      dynAppend(visibleList, g_colNames[j]);          // g_colNames
  }

  // create begin and end time
  tiBegin = makeTime(tibYear, tibMonth, tibDay, tibHour, tibMinute, tibSecond);
  tiEnd   = makeTime(tieYear, tieMonth, tieDay, tieHour, tieMinute, tieSecond);

  aes_getBeginEndTime(tiBegin, tiEnd, tiSelection, tiShift);  // correct timerange

//we want to support the filter mode for ack states in all modes
//  if ( tiType != AES_MODE_CURRENT ) fiState = AES_MODECUR_ALL;  // in open or closed protocoll, we want all states
  if ( tiType != AES_MODE_CLOSED ) tiSort = false;
  if ( tiType != AES_MODE_OPEN ) tiHist = false;

  // now set the selections              
  dpCheck = dpProp;
 
   if (!dpExists(dpCheck))
   {
    aesGenerateDp( dpCheck, _AES_DPTYPE_PROPERTIES );
    delay(1);
   }
  if( !dpExists(dpCheck) )
  {
     aes_message( AESMSG_DPCREATE_FAILED, makeDynString( dpCheck ), 1, __FUNCTION__ );
     ret=-1;
     return;
  }

    while ( !dpExists(dpCheck) )
    {
      delay(0,100);
  }
  
  // reading type table
  fiTypeSelections[fiTypeTable] = 0;  // JavaUI: Ensure right size
  for( n = 1; n <= fiTypeTable; n++ )
    getValue( "fi_typeTable", "cellValueRC", n-1, "Selections", fiTypeSelections[n] );
    
  if( dynMin( fiTypeSelections ) != 0 )
  {
    msg = getCatStr("sc","noTypes");
    strreplace(msg, "\uA7", "\n");
    ChildPanelOnCentralModalReturn("vision/MessageWarning",getCatStr("sc","Attention"),
                                   makeDynString("$1:" + msg),
                                   dfResult, dsResult );
    // Get data from datapoint

////!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    if ( screenType == AESTYPE_ALERTS )
      dpGetCache( dpProp + ".Alerts.FilterTypes.Selections:_original.._value", fiTypeSelections );
    else
    if ( screenType == AESTYPE_EVENTS )
      dpGetCache( dpProp + ".Events.FilterTypes.Selections:_original.._value", fiTypeSelections );
  }
  
  
  // reading system table
  fiSelectedSystemNames = "";
  k = 0;
  fiAllSystemNames[fiSystemTable] = "";     // JavaUI: Ensure correct size
  fiSystemSelections[fiSystemTable] = "";   // dto.
  for( n = 1; n <= fiSystemTable; n++ )
  {
    getValue( "fi_systemTable", "cellValueRC", n-1, "Names",      fiAllSystemNames[n],
                                "cellValueRC", n-1, "Selections", fiSystemSelections[n] );
    if( fiSystemSelections[n] == "1" )
    {
      k++;
      fiSelectedSystemNames[k] = fiAllSystemNames[n];
    }
  }
  
  getValue( "chk_checkAllSystems", "state", 0, bCheckSys );


  if( ( k == 0 ) && ( !bCheckSys ) ) // No system was selected
  {
    msg = getCatStr("sc","noSystems");
    strreplace(msg, "\uA7", "\n");
    ChildPanelOnCentralModalReturn("vision/MessageWarning",getCatStr("sc","Attention"),
                                   makeDynString("$1:" + msg),
                                   dfResult, dsResult );
    // select own system
    mySystemName = substr( getSystemName(), 0, strpos( getSystemName(), ":" ) );
    fiSelectedSystemNames[1] = mySystemName;
  }

  
  
  // writing data
  /*if (group)
  {
    fiDpList=makeDynString("group:::"+gName);
  }
  */

  // we will only store the seleceted ( by radiobox ) type
  if( dpe_group.number==0 )
    dynAppend( fiDpList, fiDpListDpe );
  else
    dynAppend( fiDpList, fiDpListGroup );


  // if we add a new property, all visible config columns will be overparamed visible property columns
  if( newProperty )
  {
    dyn_string dsEmpty=makeDynString();
    dynClear( visibleList );

    //IM 117660
    dyn_string dsLeft,dsRight;
    getMultiValue( "vi_list","items",dsRight,"vi_columns","items",dsLeft);
    if(dynlen(dsRight) == 0)
    {
      dsRight = g_colTitles;
      dsLeft  = dsEmpty;
      visibleList=g_colNames;
    }
    else
    {
      for(int i = 1; i <= dynlen(dsRight); i++)
      {
        int j = dynContains(g_colTitles,dsRight[i]);
        
        if(j > 0)
         visibleList[i]=g_colNames[j];
      }
    }
    /////
    setMultiValue( "vi_list", "items", dsRight,
                   "vi_columns", "items", dsLeft );
  }

  if( tiMaxLines < AES_MIN_OPEN_LINES )
    tiMaxLines=AES_DEFAULT_OPEN_LINES;

  switch (iFilterType)
  {
    case 0: sFilterType = "NONE";break;
    case 1: sFilterType = "GLOBAL";break;
    case 2: sFilterType = "GROUP"+ ":" + cb_FilterType.text;break;
    case 3: sFilterType = "USER"+ ":" + cb_FilterType.text;break;
    default: sFilterType = "UNKNOWN";break;
  }
  
  if ( getUserPermission(g_setAliasPermission) && saveToOriginal )
    dpSetComment(dpProp + ".Name", sFilterType);
  
  if ( screenType == AESTYPE_ALERTS )
  {
    int stateFilter, modeFilter;
    bool oneRowFilter = false;
    
    switch(fiState)
    {
      case 1:  stateFilter = fiPending?AES_MODECUR_UNACKPEND:AES_MODECUR_UNACK; break;
      case 2:  stateFilter = fiPending?AES_MODECUR_ACKPEND:AES_MODECUR_ACK; break;
      case 3:  stateFilter = fiPending?AES_MODECUR_NOTACKABLEPEND:AES_MODECUR_NOTACKABLE; break;
      case 4:  stateFilter = AES_MODECUR_OLDESTUNACK; fiPending = false; break;
      default: stateFilter = fiPending?AES_MODECUR_PEND:AES_MODECUR_ALL; break;
    }
    
    switch(fiMode)
    {
      case 1:  modeFilter = AES_MODEOPCL_ALL; //oneRowFilter = true; break;
               if ( tiType == AES_MODE_CURRENT ) // IM 106796
                 oneRowFilter = true;
               else
                 oneRowFilter = false;
               break;
      case 2:  modeFilter = AES_MODEOPCL_DIR; break;
      default: modeFilter = AES_MODEOPCL_ALL; break;
    }
    
    dpSetCache(//general props
              dpProp + ".Name:_original.._value", configName,
              dpProp + ".Settings.ScreenType:_original.._value", screenType,
              dpProp + ".Settings.AlertRow:_original.._value", g_alertRow,    // new alertRow identifier
              dpProp + ".Settings.User:_original.._value", getUserId(),
              //propFilterGeneral
              dpProp + ".Both.General.Header:_original.._value", geHeader,
              //propFilter
              dpProp + ".Alerts.Filter.Shortcut:_original.._value", fiShortcut,
              dpProp + ".Alerts.Filter.Prio:_original.._value", fiPrio,
              dpProp + ".Alerts.Filter.DpComment:_original.._value", fiDpComment,
              dpProp + ".Alerts.Filter.AlertText:_original.._value", fiAlertText,
              dpProp + ".Alerts.Filter.LogicalCombine:_original.._value", fiLink+1,
              dpProp + ".Alerts.Filter.DpList:_original.._value", fiDpList,
              //propFilterTypes
              dpProp + ".Alerts.FilterTypes.Selections:_original.._value", fiTypeSelections,
              dpProp + ".Alerts.FilterTypes.AlertSummary:_original.._value", fiAlertSummary,
              //propFilterState
              dpProp + ".Alerts.FilterState.State:_original.._value", stateFilter,
              dpProp + ".Alerts.FilterState.OneRowPerAlert:_original.._value", oneRowFilter,
              dpProp + ".Alerts.FilterState.OpenClosedMode:_original.._value", modeFilter,
              dpProp + ".Alerts.FilterState.Direction:_original.._value", fiDir,
              //propSort
              dpProp + ".Both.Sorting.SortList:_original.._value", soListWithAsc,
              //propSort
              dpProp + ".Both.Visible.VisibleColumns:_original.._value", visibleList,
              //propTimerange
              dpProp + ".Both.Timerange.Type:_original.._value", tiType,
              dpProp + ".Both.Timerange.MaxLines:_original.._value", tiMaxLines,
              dpProp + ".Both.Timerange.CameWentSort:_original.._value", (ti_sort.enabled)?tiSort:false,
              dpProp + ".Both.Timerange.HistoricalData:_original.._value", (ti_hist.enabled)?tiHist:false,
              dpProp + ".Both.Timerange.Selection:_original.._value", tiSelection,
              dpProp + ".Both.Timerange.Shift:_original.._value", tiShift,
              dpProp + ".Both.Timerange.Begin:_original.._value", tiBegin,
              dpProp + ".Both.Timerange.End:_original.._value", tiEnd,
              dpProp + ".Both.Timerange.HistoricalDataInterval:_original.._value", iHistDataIntervalMinutes,
              //propFilterSystems
              dpProp + ".Both.Systems.Selections:_original.._value", fiSelectedSystemNames,
              dpProp + ".Both.Systems.CheckAllSystems:_original.._value", bCheckSys,
              dpProp + ".Alerts.Filter.BLEComment:_original.._value",geBLEComment,
              //propFilterAddValues
              dpProp + ".Alerts.Filter.Add_Value:_original.._value", dsAddValsValue,
              dpProp + ".Alerts.Filter.Add_Value_Combine:_original.._value", dsAddValsLink ,
              dpProp + ".Alerts.Filter.Add_Value_Compare:_original.._value",dsAddValsOperator,
              dpProp + ".Alerts.Filter.Add_Value_Index:_original.._value",dsAddVals);
    err = getLastError();
  }
  else if ( screenType == AESTYPE_EVENTS )
  {
    dpSetCache(//general props
              dpProp + ".Name:_original.._value", configName,
              dpProp + ".Settings.ScreenType:_original.._value", screenType,
              dpProp + ".Settings.User:_original.._value", getUserId(),
              //propFilterGeneral
              dpProp + ".Both.General.Header:_original.._value", geHeader,
              //propFilter
              dpProp + ".Events.Filter.DpComment:_original.._value", fiDpComment,
              dpProp + ".Events.Filter.Userbits:_original.._value", b32,
              dpProp + ".Events.Filter.DpList:_original.._value", fiDpList,
              //propFilterTypes
              dpProp + ".Events.FilterTypes.Selections:_original.._value", fiTypeSelections,
              //propSort
              dpProp + ".Both.Sorting.SortList:_original.._value", soListWithAsc,
              //propSort
              dpProp + ".Both.Visible.VisibleColumns:_original.._value", visibleList,
              //propTimerange
              dpProp + ".Both.Timerange.Type:_original.._value", tiType,
              dpProp + ".Both.Timerange.MaxLines:_original.._value", tiMaxLines,
              dpProp + ".Both.Timerange.HistoricalData:_original.._value", (ti_hist.enabled)?tiHist:false,
              dpProp + ".Both.Timerange.Selection:_original.._value", tiSelection,
              dpProp + ".Both.Timerange.Shift:_original.._value", tiShift,
              dpProp + ".Both.Timerange.Begin:_original.._value", tiBegin,
              dpProp + ".Both.Timerange.End:_original.._value", tiEnd,
              dpProp + ".Both.Timerange.HistoricalDataInterval:_original.._value", iHistDataIntervalMinutes,
              //propFilterSystems
              dpProp + ".Both.Systems.Selections:_original.._value", fiSelectedSystemNames,
              dpProp + ".Both.Systems.CheckAllSystems:_original.._value", bCheckSys,
              dpProp + ".Events.Filter.BLEComment:_original.._value",geBLEComment);
    err = getLastError();
  }
  
  //mt: additional filters
  if(isFunctionDefined("HOOK_aes_saveProperties"))
    HOOK_aes_saveProperties(dpProp);     
  
  if ( dynlen(err) )
  {
    errorDialog(err);
  }

  // if we did not leave the function until here, set no error
  ret=0;
}

//---------------------------------------------------------------------------
//--------------------------------------------------------------------------------
/*
Set the shapes of the timerange-tab to enabled/disabled depending on the current type
of protocoll
Also calculate the begin- and end-time on special time-selections (e.g. yesterday, ...)
Parameters:
  num ... 0=current alerts, 1=open protocoll, 2=closed protocoll
*/

aes_setTiPropsEnabled(int num, int screenType)
{
  if ( num == 1 )  // open
  {
    bool bHistDataState;
    getValue("ti_hist", "state", 0, bHistDataState);
    
    setMultiValue("ti_hist",        "enabled", true,
                  "ti_maxLines",    "enabled", true,
                  "ti_maxLinesTxt", "enabled", true,
                  "ti_maxLines",    "backCol", "_Window",
                  //"txtHistoricalDataInterval", "enabled", true,
                  //"txtHistoricalDataInterval", "backCol", "_Window",
                  "ti_maxLinesTxt", "visible", true,
                  "ti_maxLines", "visible", true,
                  "ti_hist", "visible", true);
    
    aes_changedPropsTimeHistDataDisplay(bHistDataState);  //Display the hist data interval shapes only if the historical data checkbox is activated
    
    /*
    if ( screenType == AESTYPE_ALERTS )
      setMultiValue("ti_hist",        "enabled", true,
                    "ti_maxLines",    "enabled", true,
                    "ti_maxLinesTxt", "enabled", true,
                    "ti_maxLines",    "backCol", "_Window");
    else
    if ( screenType == AESTYPE_EVENTS )
      setMultiValue("ti_maxLines",    "enabled", true,
                    "ti_maxLinesTxt", "enabled", true,
                    "ti_maxLines",    "backCol", "_Window");
    */
  }
  else
  {
    setMultiValue("ti_hist",        "enabled", false,
                  "ti_maxLines",    "enabled", false,
                  "ti_maxLinesTxt", "enabled", false,
                  "ti_maxLines",    "backCol", "_3DFace",
                  //"txtHistoricalDataInterval", "enabled", false,
                  //"txtHistoricalDataInterval", "backCol", "_3DFace",
                  "ti_maxLinesTxt", "visible", false,
                  "ti_maxLines", "visible", false,
                  "ti_hist", "visible", false);

    aes_changedPropsTimeHistDataDisplay(false);  //The hist data interval shapes can only be displayed in open mode
    
    /*
    if ( screenType == AESTYPE_ALERTS )
      setMultiValue("ti_hist",        "enabled", false,
                    "ti_maxLines",    "enabled", false,
                    "ti_maxLinesTxt", "enabled", false,
                    "ti_maxLines",    "backCol", "_3DFace");
    else
    if ( screenType == AESTYPE_EVENTS )
      setMultiValue("ti_maxLines",    "enabled", false,
                    "ti_maxLinesTxt", "enabled", false,
                    "ti_maxLines",    "backCol", "_3DFace");
    */
  }

  if ( num == 2 )  // closed
  {
    int pos, shift;

    getMultiValue("ti_selection", "selectedPos", pos,    // today, yesterday, ...
                  "ti_shift",     "selectedPos", shift);

    if ( screenType == AESTYPE_ALERTS )
      setValue("ti_sort",    "enabled", true);
    
    setValue("ti_selection", "visible", true);

    setMultiValue("ti_selection", "enabled", true,

                  "ti_shift",   "enabled", (pos <= 3),  // today, yesterday, any day

                  "tib_year",   "enabled", (pos == 3) || (pos == 6),
                  "tib_month",  "enabled", (pos == 3) || (pos == 6),
                  "tib_day",    "enabled", (pos == 3) || (pos == 6),
                  "tib_hour",   "enabled", (pos == 6),
                  "tib_minute", "enabled", (pos == 6),
                  "tib_second", "enabled", (pos == 6),
                  "tib_today",  "enabled", (pos == 3) || (pos == 6),
                  
                  "tie_year",   "enabled", (pos == 6),
                  "tie_month",  "enabled", (pos == 6),
                  "tie_day",    "enabled", (pos == 6),
                  "tie_hour",   "enabled", (pos == 6),
                  "tie_minute", "enabled", (pos == 6),
                  "tie_second", "enabled", (pos == 6),
                  "tie_today",  "enabled", (pos == 6) 
                  );

    if ( pos != 6 )   // not any period
    {
      time tb, te;  // time-begin, time-end
      
      if ( pos == 3 )  // any day
      {
        int tibYear, tibMonth, tibDay, tibHour, tibMinute, tibSecond;
      
        getMultiValue("tib_year",     "text",   tibYear,
                      "tib_month",    "text",   tibMonth,
                      "tib_day",      "text",   tibDay,
                      "tib_hour",     "text",   tibHour,
                      "tib_minute",   "text",   tibMinute,
                      "tib_second",   "text",   tibSecond);

        tb = makeTime(tibYear, tibMonth, tibDay, tibHour, tibMinute, tibSecond);
      }

      aes_getBeginEndTime(tb, te, pos, shift);

      setMultiValue("tib_year",   "text", year(tb),
                    "tib_month",  "text", month(tb),
                    "tib_day",    "text", day(tb),
                    "tib_hour",   "text", hour(tb),
                    "tib_minute", "text", minute(tb),
                    "tib_second", "text", second(tb),
                    
                    "tie_year",   "text", year(te),
                    "tie_month",  "text", month(te),
                    "tie_day",    "text", day(te),
                    "tie_hour",   "text", hour(te),
                    "tie_minute", "text", minute(te),
                    "tie_second", "text", second(te));
    }
  }
  else
  {
    if ( screenType == AESTYPE_ALERTS )
      setValue("ti_sort",     "enabled", false);
    
    setValue("ti_selection", "visible", false);

    setMultiValue("ti_selection","enabled", false,
                  "ti_shift",    "enabled", false,

                  "tib_year",   "enabled", false,
                  "tib_month",  "enabled", false,
                  "tib_day",    "enabled", false,
                  "tib_hour",   "enabled", false,
                  "tib_minute", "enabled", false,
                  "tib_second", "enabled", false,
                  "tib_today",  "enabled", false,
                  
                  "tie_year",   "enabled", false,
                  "tie_month",  "enabled", false,
                  "tie_day",    "enabled", false,
                  "tie_hour",   "enabled", false,
                  "tie_minute", "enabled", false,
                  "tie_second", "enabled", false,
                  "tie_today",  "enabled", false 
                  );
  }
}

//--------------------------------------------------------------------------------
void aes_getProps(string dpConfig, int screenType, int tabType=0)
{
  aes_getPropsFilter(dpConfig, screenType);
  aes_getPropsSort(dpConfig, screenType);
  aes_getPropsTime(dpConfig, screenType, true);  // do load start/stop time
  aes_getPropsGeneral(dpConfig);
  aes_getPropsFilterTypes(dpConfig, screenType);
  aes_getPropsFilterSystem(dpConfig);
  aes_getPropsVisible(dpConfig, screenType);

  //mt: additional filters
  if(isFunctionDefined("HOOK_aes_loadProperties"))
    HOOK_aes_loadProperties(dpConfig);  
}
//---------------------------------------------------------------------------
/*
Used in the AS_Properties panel for getting the selected properties from an _ASConfig DP
and setting them onto the shapes
Parameters:
  dpProp ... name of DP for properties (must be of DP-Type _ASConfig); with trailing "."
*/

aes_getPropsFilter(string dpProp, int screenType)
{
  int        i, state,gState=0, fiLink, fiMode, fiDir, tiType;
  bool       fiRow;
  bit32      uBits;
  string     shortcut, prio, comment, alertText, gName="";
  dyn_string dpList, sections;
  dyn_string dsGroup, dsDpe, dsBLEComment;
  dyn_string dsAddVals;
  dyn_string dsAddValsValues;
  dyn_string dsAddValsLinks;
  dyn_string dsAddValsOperators;

  // mp - warum
  //configName.text = dpProp;
  
  if ( screenType == AESTYPE_ALERTS )
    dpGetCache(dpProp + ".Both.Timerange.Type:_original.._value", tiType,
          dpProp + ".Alerts.FilterState.State:_online.._value", state,
          dpProp + ".Alerts.FilterState.OneRowPerAlert:_online.._value", fiRow,
          dpProp + ".Alerts.FilterState.OpenClosedMode:_online.._value", fiMode,
          dpProp + ".Alerts.FilterState.Direction:_online.._value", fiDir,
          dpProp + ".Alerts.Filter.Shortcut:_online.._value", shortcut,
          dpProp + ".Alerts.Filter.Prio:_online.._value", prio,
          dpProp + ".Alerts.Filter.DpComment:_online.._value", comment,
          dpProp + ".Alerts.Filter.AlertText:_online.._value", alertText,
          dpProp + ".Alerts.Filter.LogicalCombine:_online.._value", fiLink,
          dpProp + ".Alerts.Filter.DpList:_online.._value", dpList,
          dpProp + ".Alerts.Filter.BLEComment:_online.._value", dsBLEComment,
          dpProp + ".Alerts.Filter.Add_Value:_online.._value", dsAddValsValues,
          dpProp + ".Alerts.Filter.Add_Value_Combine:_online.._value", dsAddValsLinks,
          dpProp + ".Alerts.Filter.Add_Value_Compare:_online.._value", dsAddValsOperators,
          dpProp + ".Alerts.Filter.Add_Value_Index:_online.._value", dsAddVals          
          );
  else
  if ( screenType == AESTYPE_EVENTS )
    dpGetCache(dpProp + ".Events.Filter.DpComment:_online.._value", comment,
          dpProp + ".Events.Filter.Userbits:_online.._value", uBits,
          dpProp + ".Events.Filter.DpList:_online.._value", dpList,
          dpProp + ".Events.Filter.BLEComment:_online.._value", dsBLEComment);

  // TI 17752 - pallesch / if filter is empty, replace it with '*'
//    if (dynlen(dpList)<1) dpList=makeDynString("*");


  {
    int n,l;
    l=dynlen(dpList);
    if( l > 0 )
    {
      for( n=1; n<=l; n++ )
      {
        if( strpos( dpList[n], AES_GROUPIDF ) >= 0 )
        {
          // append group item
          dynAppend( dsGroup, dpList[n] );
        }
        else
        {
          // append dpe item
          dynAppend( dsDpe, dpList[n] );
        }
      }
    }
  }


  // set temp list
  groupList.items=dsGroup;
  dpeList.items=dsDpe;

  // fill combobox with all available groups
  fi_groups.items=groupGetNames();

  // check whether first item is a group item and set radiobox and visibility
  if (dynlen(dpList) > 0 && strpos(dpList[1], AES_GROUPIDF ) == 0 )
  {
//    gName=dpList[1];
//    strreplace(gName,"group:::","");
//    aesGetGroupFilter(dpList);
    dpselector.visible=false;
    append.visible=false;
    modify.visible=false;
//    delete.visible=false;
    fi_dpName.visible=false;
    fi_groups.visible=true;
    cmdAppend.visible=true;
//    fi_groups.text=gName;
    gState=1;

    //groupList.items = dpList;
    dpList=dsGroup;
  }
  else
  {
    // TI 17752 - pallesch / if filter is empty, replace it with '*'
//    if (dynlen(dpList)<1) dpList=makeDynString("*");
    dpselector.visible=true;
    append.visible=true;
    modify.visible=true;
    buDelete.visible=true;
    fi_dpName.visible=true;
    fi_groups.visible=false;

    //groupList.items = makeDynString();
    dpList=dsDpe;
  }


  if ( dynContains(  dpList, "_Config") > 0)      // IM 63247 remove Dummy 
    dynRemove(dpList, dynContains( dpList, "_Config")); 


  if ( screenType == AESTYPE_ALERTS )
  {
    bool pendingFilter, enableOneRowFilter, enableDirectionFilter;
    int stateFilter, modeFilter;    
    
    switch(state)
    {
      case AES_MODECUR_PEND:           stateFilter = 0; pendingFilter = true; break;
      case AES_MODECUR_UNACK:          stateFilter = 1; pendingFilter = false; break;
      case AES_MODECUR_UNACKPEND:      stateFilter = 1; pendingFilter = true; break;
      case AES_MODECUR_ACK:            stateFilter = 2; pendingFilter = false; break;
      case AES_MODECUR_ACKPEND:        stateFilter = 2; pendingFilter = true; break;
      case AES_MODECUR_NOTACKABLE:     stateFilter = 3; pendingFilter = false; break;
      case AES_MODECUR_NOTACKABLEPEND: stateFilter = 3; pendingFilter = true; break;
      case AES_MODECUR_OLDESTUNACK:    stateFilter = 4; pendingFilter = false; break;
      default:                         stateFilter = 0; pendingFilter = false; break;
    }
    
    switch(fiMode)
    {
      case AES_MODEOPCL_DIR: modeFilter = 2; break;
      default:               modeFilter = ((tiType == AES_MODE_CURRENT) && fiRow)?1:0; break; // IM 106796
    }
    
    
    enableOneRowFilter = (tiType == AES_MODE_CURRENT); //|| (tiType == AES_MODE_CLOSED)); // IM 106796
    enableDirectionFilter = ((tiType == AES_MODE_OPEN) || (tiType == AES_MODE_CLOSED));
    
    if(isFunctionDefined("aes_prepareUserdefinedAlertDisplay"))//IM #117931
      aes_prepareUserdefinedAlertDisplay(shortcut,prio,UDA_CFG_getFromDPE);

    setMultiValue("fi_state",      "number", stateFilter,
                  "fi_mode",       "number", modeFilter,
                  "fi_mode",       "itemEnabled", 1, enableOneRowFilter,
                  "fi_mode",       "itemEnabled", 2, enableDirectionFilter,
                  "fi_pending",    "state",  0, pendingFilter,
                  "fi_pending",    "enabled", (stateFilter != 4),
                  "fi_dir",        "selectedPos", fiDir,
                  "fi_dir",        "enabled", (modeFilter == 2),
                  "fi_link",       "number", fiLink-1,
                  "fi_shortcut",   "text",   shortcut,
                  "fi_prio",       "text",   prio,
                  "fi_dpComment",  "text",   comment,
                  "fi_alertText",  "text",   alertText,
                  "fi_dpList",     "items",  dpList,
                  "dpe_group",     "number", gState,
                  "dpListMatches", "visible", !((bool)gState), 
                  "te_useWild",    "visible", !((bool)gState), 
                  "bt_dpGroup",    "visible", (bool)gState
                  );
    
    for ( int i = 1; i <= dynlen(dsAddVals); i++ )
      setValue("tabAddVals","appendLine","ADD_VAL","_add_value_"+dsAddVals[i],"OPERATOR",dsAddValsOperators[i],
                                         "VALUE",dsAddValsValues[i],"LINK",dsAddValsLinks[i],"INDEX",dsAddVals[i]);
  }
  else
  if ( screenType == AESTYPE_EVENTS )
    setMultiValue(
                   "fi_dpList",     "items",  dpList,
                  "dpe_group",     "number", gState,
                  "dpListMatches", "visible", !((bool)gState), 
                  "te_useWild",    "visible", !((bool)gState), 
                  "bt_dpGroup",    "visible", (bool)gState, 
                  "fi_dpComment",  "text",   comment,
                  "fi_userbit1",   "state","0", getBit(uBits,24),
                  "fi_userbit2",   "state","0", getBit(uBits,25),                
                  "fi_userbit3",   "state","0", getBit(uBits,26),
                  "fi_userbit4",   "state","0", getBit(uBits,27),
                  "fi_userbit5",   "state","0", getBit(uBits,28),
                  "fi_userbit6",   "state","0", getBit(uBits,29),
                  "fi_userbit7",   "state","0", getBit(uBits,30),
                  "fi_userbit8",   "state","0", getBit(uBits,31));


 if (shapeExists("ge_BLEComment"))
 {
   ge_BLEComment.items = dsBLEComment;
 }

}
//--------------------------------------------------------------------------------
/*
Used in the AES_Properties panel for getting the selected properties from an _AESConfig DP
and setting them onto the shapes
Parameters:
  dpProp ... name of DP for properties (must be of DP-Type _AESProperties);//??? with trailing "."
*/

aes_getPropsGeneral(string dpProp)
{
  langString header;
 
  if (shapeExists("ge_header"))
  {
   
    if ( dpGetCache(dpProp + ".Both.General.Header:_online.._value", header) == -1 )
    {
      std_error("AES", ERR_SYSTEM, PRIO_SEVERE,
                 E_AS_FUNCTION, "aes_getPropsGeneral(): dpGet( ... Header ...)");
      return;
    }
  
    // we need the ge_headerList for storing all languages, because
    // the textfield does not store a langString but only a string
  
    setMultiValue("ge_header",     "text", header,
                  "ge_headerList", "text", header); 
  
 
  }
  string sFilterType;
  int   iFilterType;
  
  if ( strpos(dpProp, "PropertiesRT") != -1 )
  {
    string name;
    dpGetCache(dpProp + ".Name:_original.._value", name,
          "_System.Auth.DpAlias:_original.._value", g_setAliasPermission);
    aes_getDpName4RealName(name, AES_DPTYPE_PROPERTIES, g_screenType, dpProp);
  }
  else
    dpGetCache("_System.Auth.DpAlias:_original.._value", g_setAliasPermission);
  
    sFilterType = dpGetComment(dpProp + ".Name",-2);   // real comment
  
  aes_setFilterTypeInfo(sFilterType); 
}

//--------------------------------------------------------------------------------
aesGetGroupFilter(dyn_string &dps)
{
  int        i, k, overflow;
  string     gName;
  dyn_float  df;
  dyn_string dpcs=makeDynString(), ds, ds1, ds2,
             typeFilter=makeDynString(getCatStr("general","all")),
             dpeFilter=makeDynString("");
  
  for ( k = 1; k <= dynlen(dps); k++ )
  {
    gName = dps[k];
    strreplace(gName,"group:::","");
    groupGetFilterItemsRecursive(groupNameToDpName(gName),ds1,ds2,overflow);
    if (overflow==-1)
    {
      ChildPanelOnCentralModalReturn("vision/MessageWarning",
        getCatStr("para","warning"),
        makeDynString(getCatStr("groups","leveloverflow")),df,ds);
      return;
    }
//    dps=makeDynString();
    dynAppend(typeFilter,ds1);
    dynAppend(dpeFilter,ds2);
    for (i=2;i<=dynlen(typeFilter);i++)
    {
      groupGetFilteredDps(typeFilter[i],dpeFilter[i],ds,overflow);
      if (overflow==-1)
      {
        ChildPanelOnCentralModalReturn("vision/MessageWarning",
          getCatStr("para","warning"),
          makeDynString(getCatStr("groups","leveloverflow")),df,ds);
        return;
      }
      dynAppend(dpcs,ds);
    }
  }
  for ( i=dynlen(dpcs); i > 0; i-- )
  {
    dpcs[i]=dpSubStr(dpcs[i],DPSUB_DP_EL);
    if ( strpos(dpcs[i], "_mp_") == 0 )
      dynRemove(dpcs, i);
  }
  dynSortAsc(dpcs);
  dynUnique(dpcs);
  dps = dpcs;
}

//---------------------------------------------------------------------------
/*
Used in the AES_Properties panel for getting the selected properties from an _ASConfig DP
and setting them onto the shapes
Parameters:
  dpProp ... name of DP for properties (must be of DP-Type _ASConfig); with trailing "."
  strColTitles ... blank sep. list of table column-headers in current language
  strColNames ... blank sep. list of table column names (internal names)
  count ... number of columns
*/

aes_getPropsSort(string dpProp, int screenType)
{
  int i, j, columns, count;
  bool vis;
  dyn_string colTitles, colNames;
  dyn_string soList, selected, ds;
  dyn_string soListWithAsc;
  dyn_bool soAsc;
  string s, col, name, sShape = rootPanel();

  dpGetCache(dpProp + ".Both.Sorting.SortList:_online.._value", soListWithAsc);  //read Sortlist,asc
  
  //split sotlist and asc

  aes_splitSortList(soListWithAsc, soList, soAsc);

  // remove items from sort wich are not in the configuration !!!!!!!!!!!!!!!!!!!!

  // g_colNames - initialized from $param
  aes_removeUnsatisfiedColumns( g_colNames, soList, soAsc, true );

  colTitles=g_colTitles;
  colNames=g_colNames;

  // create dyn_string of column-titles which are selected for sorting
  dyn_int selectedIndex;
  dyn_bool selectedAsc; 
  int cnt=0;
  for (i = 1; i <= dynlen(soList); i++)
  {
    j=dynContains(colNames, soList[i]);     

    if( j > 0 )
    {
      dynAppend(selected, colTitles[j]);    
      colTitles[j] = "";                    
      dynAppend(selectedAsc, soAsc[i]);
      dynAppend(selectedIndex, ++cnt);
    }
  }
  
  // remove selected columns from list, so that we get the "rest"
  count = dynlen(colTitles);                          
  for (i = count; i > 0; i--)
  {
    int j = dynContains(colTitles, "");               
    if ( j > 0 )
      dynRemove(colTitles, j);                        
  }

  setMultiValue("so_columns", "items", colTitles,     
                "so_table",    "appendLines", dynlen(selected), "asc", selectedAsc, "sortorder", selected, "index", selectedIndex);
}

//---------------------------------------------------------------------------


// Paramter asc: return of dyn_bool for sorting asc or desc; it is ignorred if dynlen(asc)!=0
// <- this is a woraround because of problems with defaultparameters of type dyn_xx
void aes_removeUnsatisfiedColumns( dyn_string &configColumns, dyn_string &columns , dyn_bool &asc, bool useSortDirection=false)
{
  int i, count;
  dyn_string ds;
  dyn_bool db;

  count=dynlen( columns );
  
  for( i=1; i<=count; i++ )
  {
    if( dynContains( configColumns, columns[i] ) > 0 )
    {
      dynAppend( ds, columns[i] );
      if (useSortDirection)      
        dynAppend( db, asc[i]);
    }
  }
  columns = ds;
  if (useSortDirection)      
    asc = db;
  else
    asc = asc;
}



dyn_string aes_correctVisibleColumnSortOrder( dyn_string visColumns )
{
  int n, l;
  string col;
  dyn_string sortColumns;

  // travers all columns
  l=dynlen( g_colNames );
  for( n=1; n <= l; n++ )
  {
    col=g_colNames[n];
    if( dynContains( visColumns, col ) > 0 )
    {
      dynAppend( sortColumns, col );
    }
  }

  return sortColumns;

}

//---------------------------------------------------------------------------
/*
Used in the AES_Properties panel for getting the selected properties from an _ASConfig DP
and setting them onto the shapes
Parameters:
  dpProp ... name of DP for properties (must be of DP-Type _ASConfig); with trailing "."
  strColTitles ... blank sep. list of table column-headers in current language
  strColNames ... blank sep. list of table column names (internal names)
  count ... number of columns
*/

aes_getPropsVisible(string dpProp, int screenType)
{
  int i, j, k, columns, count;
  bool vis;
  dyn_string colTitles, colNames, dsTitles;
  dyn_string viList, selected, ds;
  string s, col, name, sShape = rootPanel();

  dpGetCache(dpProp + ".Both.Visible.VisibleColumns:_online.._value", viList);

  // remove items from sort wich are not in the configuration !!!!!!!!!!!!!!!!!!!!

  // g_colNames - initialised from $param
  dyn_bool tmpdb;
  aes_removeUnsatisfiedColumns( g_colNames, viList, tmpdb, false);

  //viList=aes_correctVisibleColumnSortOrder( viList );  //Wenn die Reihenfolge der sichtbaren Spalten auch die Reihenfolge der Spalten im AS definiert, darf hier nicht mehr umsortiert werden !!!
  colNames=g_colNames;
  colTitles=g_colTitles;

  for(i = 1; i <= dynlen(viList); i++)
  {
    int iPos = dynContains(colNames,viList[i]);
    if(iPos)
    {
      dynAppend(selected,colTitles[iPos]);// g_colTitles
      dynRemove(colNames,iPos);
      dynRemove(colTitles,iPos);
    }
  }

  setMultiValue("vi_columns", "items", colTitles,
                "vi_list",    "items", selected);
}

//---------------------------------------------------------------------------
/*
Used in the AES_Properties panel for getting the selected properties from an _AESProperties DP
and setting them onto the shapes
Parameters:
  dpProp ... name of DP for properties (must be of DP-Type _ASConfig); with trailing "."
  loadTi ... true=load start/stop time, false=don't
*/

aes_getPropsTime(string dpProp, int screenType, bool loadTi)
{
  int        type, maxLines, selection, shift, num, i;
  int        iHistDataIntervalConfig, iHistDataIntervalProp;
  bool       sort, hist;
  time       tib, tie;
  string     msgKey;
  dyn_string dsShift;
    
  // get shift-names
  dpGetCache("_Config.NumShifts:_online.._value", num,
             "_Config.HistoricalDataInterval", iHistDataIntervalConfig);

  for (i = 0; i <= num; i++)  // shift0 == whole day
  {
    sprintf(msgKey, "shift%1d", i);
    dsShift[i+1] = getCatStr("sc", msgKey);
  }
  setValue("ti_shift", "items", dsShift);

  if ( dpGetCache(dpProp + ".Both.Timerange.Type:_online.._value", type,
             dpProp + ".Both.Timerange.MaxLines:_online.._value", maxLines,
             dpProp + ".Both.Timerange.CameWentSort:_online.._value", sort,
             dpProp + ".Both.Timerange.HistoricalData:_online.._value", hist,
             dpProp + ".Both.Timerange.Selection:_online.._value", selection,
             dpProp + ".Both.Timerange.Shift:_online.._value", shift,
             dpProp + ".Both.Timerange.Begin:_online.._value", tib,
             dpProp + ".Both.Timerange.End:_online.._value", tie,
             dpProp + ".Both.Timerange.HistoricalDataInterval:_online.._value", iHistDataIntervalProp
             ) == -1 )
  {
    std_error("AES", ERR_SYSTEM, PRIO_SEVERE,
               E_AS_FUNCTION, "aes_getPropsTime(): dpGet( ... Timerange ...)");
    return;
  }
  if ( dynlen(getLastError()) )
  {
    dyn_errClass err = getLastError();
    errorDialog(err);
    return;
  }

  if( maxLines < AES_MIN_OPEN_LINES )
    maxLines=AES_DEFAULT_OPEN_LINES;


  if ( screenType == AESTYPE_ALERTS )
    setMultiValue("ti_type",      "number", type,
                  "ti_maxLines",  "text", maxLines,
                  "ti_sort",      "state", 0, sort,
                  "ti_hist",      "state", 0, hist,
                  "ti_selection", "selectedPos", selection,
                  "ti_shift",     "selectedPos", shift);
  else
  if ( screenType == AESTYPE_EVENTS )
    setMultiValue("ti_type",      "number", type-1,
                  "ti_maxLines",  "text", maxLines,
                  "ti_hist",      "state", 0, hist,
                  "ti_selection", "selectedPos", selection,
                  "ti_shift",     "selectedPos", shift);
  
  if(screenType == AESTYPE_ALERTS || screenType == AESTYPE_EVENTS)
  {
    if(iHistDataIntervalProp > 0)  //User defined interval for this configuration
      setMultiValue("ti_HistoricalDataInterval", "number", 1,
                    "txtHistoricalDataInterval", "enabled", true,
                    "txtHistoricalDataInterval", "text", iHistDataIntervalProp);
    else  //Interval from central setting for this configuration
      setMultiValue("ti_HistoricalDataInterval", "number", 0,
                    "txtHistoricalDataInterval", "enabled", false,
                    "txtHistoricalDataInterval", "text", iHistDataIntervalConfig);
  }

  if ( loadTi )
    setMultiValue("tib_year",   "text", year(tib),
                  "tib_month",  "text", month(tib),
                  "tib_day",    "text", day(tib),
                  "tib_hour",   "text", hour(tib),
                  "tib_minute", "text", minute(tib),
                  "tib_second", "text", second(tib),

                  "tie_year",   "text", year(tie),
                  "tie_month",  "text", month(tie),
                  "tie_day",    "text", day(tie),
                  "tie_hour",   "text", hour(tie),
                  "tie_minute", "text", minute(tie),
                  "tie_second", "text", second(tie));

  propTimeScreenType.text = screenType;
  aes_setTiPropsEnabled(type, screenType); 
}

//--------------------------------------------------------------------------------
/*
Used in the AS_Properties panel for getting the selected properties from an _AESProperties DP
and setting them onto the shapes
Parameters:
  dpProp ... name of DP for properties (must be of DP-Type _ASConfig); with trailing "."
*/

aes_getPropsFilterTypes(string dpProp, int screenType)
{
dyn_string dsTypeNames;
dyn_int    diTypeSelections;
int        n;
string     sFarbe;
string     sState;

//bool       bAlertSummary;
int       iAlertSummary;

  if ( screenType == AESTYPE_ALERTS )
  {
    if( dpGetCache( dpProp + ".Alerts.FilterTypes.Selections:_online.._value", diTypeSelections,
               dpProp + ".Alerts.FilterTypes.AlertSummary:_online.._value", iAlertSummary ) == -1 )
    {
      std_error("AES", ERR_SYSTEM, PRIO_SEVERE,
                E_AS_FUNCTION, "aes_getPropsFilterTypes(AS): dpGet( ... FilterTypes ...)");
      return;
    }
  }
  else
  if ( screenType == AESTYPE_EVENTS )
  {
    if( dpGetCache( dpProp + ".Events.FilterTypes.Selections:_online.._value", diTypeSelections ) == -1 )
    {
      std_error("AES", ERR_SYSTEM, PRIO_SEVERE,
                E_AS_FUNCTION, "aes_getPropsFilterTypes(ES): dpGet( ... FilterTypes ...)");
      return;
    }
  }
  if ( dynlen(getLastError()) )
  {
    dyn_errClass err = getLastError();
    errorDialog(err);
    return;
  }
  
  
  // Preparing table and filling with data
  if ( screenType == AESTYPE_ALERTS )
    dsTypeNames = AES_AS_TYPEFILTER;
  else
  if ( screenType == AESTYPE_EVENTS )
    dsTypeNames = AES_ES_TYPEFILTER;
  for( n = 1; n <= dynlen( dsTypeNames ); n++ )
  {
    if ( dynlen(diTypeSelections) < n ) diTypeSelections[n] = 0;
  }
  setValue( "fi_typeTable", "deleteAllLines" );
  setValue( "fi_typeTable", "appendLines", dynlen( dsTypeNames ), "Selections", diTypeSelections,
                                                                  "TypeNames", dsTypeNames );
  
  // sign the choosen Types
  for( n = 1; n <= dynlen( diTypeSelections ); n++ )
  {
    if( !diTypeSelections[n] )
    {
      sFarbe = "_3DText";
      sState = getCatStr( "sc", "display" );
    }
    else
    {
      sFarbe = "darkgrey";
      sState = getCatStr( "sc", "notDisplay" );
    }
    setValue( "fi_typeTable", "cellValueRC", n -1, "State", sState,
                              "cellForeColRC", n -1, "State", sFarbe,
                              "cellForeColRC", n -1, "TypeNames", sFarbe,
                              "lineVisible", 0 );
  }
  
  // preparing checkbox "alert summary"
  if ( screenType == AESTYPE_ALERTS )
  {
    int aesType;
    bool autoFilter=false;
    getValue(myModuleName()+"."+myPanelName()+":ti_type", "number", aesType);
    if ( aesType == 1 || aesType == 2 || !isAlertFilteringActive()) //if open, closed AesMode or AlertFiltering is deactivated and "automatic filtering" -> set "all Alerts"
    {
      if ( iAlertSummary == 3 )  
        iAlertSummary = 2;
    }
    else
      autoFilter = true;
    
    setMultiValue( "fi_alertSummary", "number", iAlertSummary,
                   "fi_alertSummary", "itemEnabled", 3, autoFilter && isAlertFilteringActive() );
  }
}

//--------------------------------------------------------------------------------
/*
Used in the AS_Properties panel for getting the selected properties from an _ASConfig DP
and setting them onto the shapes
Parameters:
  dpProp ... name of DP for properties (must be of DP-Type _ASConfig); with trailing "."
*/

aes_getPropsFilterSystem(string dpProp)
{
dyn_uint   duAllSystemIds;
dyn_string dsAllSystemNames;
int        iCheckSystemNames;
dyn_string dsSelectedSystemNames;
int        n;
int        iSystemPos;
string     sState;
string     sSelection;
string     sColor;
string     mySystemName;
bool       bCheckSys;
dyn_errClass err;

  // Read names of all systems
  iCheckSystemNames = getSystemNames( dsAllSystemNames, duAllSystemIds );
  err = getLastError();
  
  if( iCheckSystemNames == -1 )
  {
    std_error("AS", ERR_SYSTEM, PRIO_SEVERE,
               E_AS_FUNCTION, "aes_getPropsFilterSystem(): dpGet( ... FilterSystems ...)");
    return;
  }
  if ( dynlen(err) )
  {
    errorDialog(err);
    return;
  }
  
  // Preparing table and filling with data
  setValue( "fi_systemTable", "deleteAllLines" );
  setValue( "fi_systemTable", "appendLines", dynlen( dsAllSystemNames ), "Ids",   duAllSystemIds,
                                                                         "Names", dsAllSystemNames );
  
  // read selected system names
  if( dpGetCache(  dpProp + ".Both.Systems.Selections:_online.._value", dsSelectedSystemNames,
              dpProp + ".Both.Systems.CheckAllSystems:_online.._value", bCheckSys ) == -1 )
  {
    std_error("AS", ERR_SYSTEM, PRIO_SEVERE,
               E_AS_FUNCTION, "aes_getPropsFilterSystem(): dpGet( ... FilterSystems ...)");
    return;
  }
  if ( dynlen(getLastError()) )
  {
    dyn_errClass err = getLastError();
    errorDialog(err);
    return;
  }
  // find out the selected system names and sign the table
  for( n = 1; n <= dynlen( dsAllSystemNames ); n++ )
  {
    iSystemPos = dynContains( dsSelectedSystemNames, dsAllSystemNames[n] );
    if( iSystemPos > 0 )
    {
      sState     = getCatStr( "sc", "display" );
      sSelection = "1";
      sColor     = "_3DText";
    }
    else
    {
      sState     = getCatStr( "sc", "notDisplay" );
      sSelection = "0";
      sColor     = "darkgrey";
    }
    setValue( "fi_systemTable", "cellValueRC",   n -1, "State",      sState,
                                "cellValueRC",   n -1, "Selections", sSelection,
                                "cellForeColRC", n -1, "Ids",        sColor,
                                "cellForeColRC", n -1, "Names",      sColor,
                                "cellForeColRC", n -1, "State",      sColor,
                                "lineVisible", 0 );
  }
  // Find out my system at the table and sign it
  mySystemName = substr( getSystemName(), 0, strpos( getSystemName(), ":" ) );
  iSystemPos = dynContains( dsAllSystemNames, mySystemName );
  
  setValue( "fi_systemTable", "cellBackColRC", iSystemPos -1, "Ids",   "grey",
                              "cellBackColRC", iSystemPos -1, "Names", "grey",
                              "cellBackColRC", iSystemPos -1, "State", "grey" );
                              
  // Sort table by system-id
  setValue( "fi_systemTable", "sort", "Ids" );

  setValue( "chk_checkAllSystems", "state", 0, bCheckSys );

  // disable table if checkall mode
  if( bCheckSys )
    setValue( "fi_systemTable", "enabled", false );
  else
    setValue( "fi_systemTable", "enabled", true );
}

//--------------------------------------------------------------------------------
/*
 Get List of all configurations
Parameter:
  configNames (in/out) ... list of configurations (items are appended)
*/

aes_getConfigList(dyn_string &configDpNames, dyn_string &configNames, int screenType)
{
  int             i, type;
  string          sName;
  dyn_dyn_anytype configs;
  dyn_errClass err;
  
  dpQuery("SELECT '_online.._value' FROM '*.Name' WHERE _DPT = \"_AESProperties\"", configs);
  err = getLastError();
           
  if ( dynlen(err) ) 
  {
    errorDialog(err);
    return;
  }
  
  for (i = 2; i <= dynlen(configs); i++)
  {
    if ( strrtrim(strltrim(configs[i][2])) == "" ) continue;
    dpGetCache(configs[i][2] + ".Name:_online.._value", sName,
          configs[i][2] + ".ScreenType:_online.._value", type);
    if ( type == screenType )
    {
      dynAppend(configDpNames, configs[i][2]);
      if ( strrtrim(strltrim(sName)) == "" )
      {
        sName = configs[i][2];
        dpSetCache(configs[i][2] + ".Name:_original.._value", sName);
      }
      dynAppend(configNames, sName);
    }
  }
}
//-----------------------------------------------------------------------------
string aes_getConfigDp(string sConfigName, dyn_string configDpNames, dyn_string configNames)
{
  int     i = dynContains(configNames, sConfigName);

  return (configDpNames[i]);
}
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
string aes_getConfigName(string sConfigDp, dyn_string configDpNames, dyn_string configNames)
{
  int     i = dynContains(configDpNames, sConfigDp);

  return (configNames[i]);
}
//-----------------------------------------------------------------------------
/*
   open the properties window as a child panel
*/

aes_openAsPropWindow(string panel)
{
  int i, count = 0, columns;
  bool vis;
  string cols, colNames, name;
  
  getValue("table", "columnCount", columns);
  
  for (i = 1; i <= columns; i++)
  {
    getValue("table", "columnVisibility", i - 1, vis,
                      "columnToName", i - 1, name);

    if ( vis && (name != "detail") )
    {
      string nam;
      getValue("table", "namedColumnHeader", name, nam);
      strreplace(nam, " ", "_");
      cols += ' ' + nam;
      colNames += ' ' + name;
      count++;
    }
  }
  
  ChildPanelOnCentralModal(panel, "",
     makeDynString("$colTitles:"+cols, "$colNames:"+colNames, "$count:"+count));
}

//-----------------------------------------------------------------------------

/////////////////////////////
//// from aes_peter.ctl - end
////////////////////////////}


/////////////////////////////////////
// split treating - from panl / begin
////////////////////////////////////{

aes_initSplitPos( const string topName, const string botName )
{
  int top_x, top_y, bot_x, bot_y;
  float top_w, top_h, bot_w, bot_h;

  getMultiValue(  topName, "position", top_x, top_y,
                  topName, "size",     top_w, top_h,
                  botName, "position", bot_x, bot_y,
                  botName, "size",     bot_w, bot_h );

  g_total_h=top_h + bot_h;
  g_top_y=top_y;

  g_both_w=top_w;
  g_both_x=top_x;

  g_top   =getShape( topName );
  g_bottom=getShape( botName );

}


aes_resetSplitPosition( shape &top, shape &bottom )
{
  aes_setSplitPosition( top, bottom, g_percent );
}


void aes_checkPercent( int &percent )
{

  if( percent < AES_TABLE_MINPERCENT )
    percent=AES_TABLE_MINPERCENT;

  if( percent > AES_TABLE_MAXPERCENT )
    percent=AES_TABLE_MAXPERCENT;
}



void aes_setSplitPosition( shape &topShape, shape &botShape, int percent, bool fromSlider=false )
{
  float perc;
  float top_s, bot_s;
  int   savePercent;

  if( g_alertRow )
  {
    return;
  }

  aes_checkPercent( percent );

  // visualize both
  topShape.visible( true );
  botShape.visible( true );

  g_bottom.visible( true );

  if( p_dispSlider )
//------------- 
  {
    setMultiValue(
      "bt_topFull",  "visible", true,
      "bt_botFull",  "visible", true,
      "bt_topSplit", "visible", false,
      "sl_gauge",    "visible", true );
    if( ! fromSlider )
    {
      sl_gauge.value=percent;
    }
  }
//------------- 

  aes_adjustSnapValue( percent );

  if( percent > g_splitMax || percent < g_splitMin )
  {
    return;
  }
  else
  {
    g_percent=percent;
  }
    
  perc=percent/100.0;
  
  // calculate values
  top_s= 2.0 * perc;
  bot_s= 2.0 - top_s;

  // set value - top table
  topShape.scale( 1.0, top_s );

  // set value - bottom table
  botShape.scale( 1.0, bot_s );
}


aes_adjustSnapValue( int &percent )
{  
  return; // deactivated
//  percent= ( percent / g_snap ) * g_snap;
}


aes_setTopFullSize( shape &top, shape &bottom, bool fromActivate=false )
{

  if( g_alertRow )
  {
    return;
  }

  bottom.visible( false );
  top.scale( 1.0, 2.0 );
  bottom.scale( 0, 0 );
  top.visible( true );


  setMultiValue(
    "bt_topFull",  "visible", false,
    "bt_botFull",  "visible", false,
    "sl_gauge",    "visible", false,
    "bt_botSplit",  "visible", false );
//    AES_REGMAIN,   "namedActiveRegister", AES_TABNAME_TOP );

  if( fromActivate )
  {
    setValue( "bt_topSplit", "visible", false );
  }
  else
  {
    setValue( "bt_topSplit", "visible", true );
  }
}


aes_setBottomFullSize( shape &top, shape &bottom, bool fromActivate=false )
{
  top.visible( false );
  bottom.scale( 1.0, 2.0 );
  top.scale( 0, 0 );
  bottom.visible( true );


  // enable split button / activate register tab
  setMultiValue(
    "bt_topFull",  "visible", false,
    "bt_botFull",  "visible", false,
    "sl_gauge",    "visible", false,
    "bt_topSplit",  "visible", false );
//    AES_REGMAIN,    "namedActiveRegister", AES_TABNAME_BOT );

  if( fromActivate )
  {
    setValue( "bt_botSplit", "visible", false );
  }
  else
  {
    setValue( "bt_botSplit", "visible", true );
  }
}


int aes_incPercentage( bool inc )
{
  int save=g_percent;

  if( inc )
  {
    g_percent=g_percent+g_splitInc;
    if( g_percent > g_splitMax )
      g_percent=save;
  }
  else
  {
    g_percent=g_percent-g_splitInc;
    if( g_percent < g_splitMin )
      g_percent=save;
  }

  return g_percent;

}


aes_osSettings()
{
  if( g_alertRow )
  {
    return;
  }
}

///////////////////////////////////
// split treating - from panl / end
//////////////////////////////////}


///////////////////////////////////////////////
// new properties treating - from panel / begin
//////////////////////////////////////////////{
void aes_initRegConstants()
{
  int c=1;
  // alerts
  firstAlertReg=c;
  PREGA_TIMERANGE    =c++;
  PREGA_FILTER       =c++;
  PREGA_FILTERTYPES  =c++;
  PREGA_FILTERSTATE  =c++;
  PREGA_FILETERSYSTEM=c++;
  PREGA_SORT         =c++;
  PREGA_VISIBLE      =c++; 
  PREGA_GENERAL      =c++;
  lastAlertReg=c;

  // events
  firstEventReg=c;
  PREGE_TIMERANGE    =c++;
  PREGE_FILTER       =c++;
  PREGE_FILTERTYPES  =c++;
  PREGE_FILTERSTATE  =c++;
  PREGE_FILETERSYSTEM=c++;
  PREGE_SORT         =c++;
  PREGE_VISIBLE      =c++;
  PREGE_GENERAL      =c++;
  lastEventReg=c;
}

void aes_readCatNames( const dyn_string &keyNames, dyn_string &catNames )
{
  int i;
  string tmpKey;
  for( i=firstAlertReg; i < lastEventReg; i++ )
  {
    tmpKey=keyNames[i];
    catNames[i]=aes_getCatStr( tmpKey );      
//    aes_debug("key=" + keyNames[i] + " cat=" + catNames[i] ); 
  }
}

void aes_propInit( int screenType, int tabType, string configName, string dpAESProp )
{
  int             i, c=1, iCheckSystemNames;
  dyn_string      keyNames, catNames;  
  dyn_dyn_anytype dda;
  dyn_string      dsSystemNames;
  dyn_string      configNames, configDpNames;
  dyn_uint        duSystemIds;
  dyn_errClass    err;

  aes_initRegConstants();
  
  // get these values from catalogue
  // Alerts
  keyNames[PREGA_TIMERANGE]    ="prega_time";
  keyNames[PREGA_FILTER]       ="prega_filter";
  keyNames[PREGA_FILTERTYPES]  ="prega_types";
  keyNames[PREGA_FILTERSTATE]  ="prega_state";
  keyNames[PREGA_FILETERSYSTEM]="prega_system";
  keyNames[PREGA_SORT]         ="prega_sort";
  keyNames[PREGA_VISIBLE]      ="prega_visible";
  keyNames[PREGA_GENERAL]      ="prega_general";

  // Events
  keyNames[PREGE_TIMERANGE]    ="prege_time";
  keyNames[PREGE_FILTER]       ="prege_filter";
  keyNames[PREGE_FILTERTYPES]  ="prege_types";
  keyNames[PREGE_FILTERSTATE]  ="prege_state";
  keyNames[PREGE_FILETERSYSTEM]="prege_system";
  keyNames[PREGE_SORT]         ="prege_sort";
  keyNames[PREGE_VISIBLE]      ="prege_visible";
  keyNames[PREGE_GENERAL]      ="prege_general";

  aes_readCatNames( keyNames, catNames );

  aes_buildPropSettings( catNames, dda );
  
  aes_setPropRegSettings( screenType, dda );
  
  addGlobal("AES_AS_TYPEFILTER", DYN_STRING_VAR);
  addGlobal("AES_AS_TYPECONST", DYN_INT_VAR);
  AES_AS_TYPEFILTER = makeDynString( "bit",
                                     "bit32",
                                     "unsigned integer",
                                     "integer",
                                     "float",
                                     "bit64",
                                     "ulong",
                                     "long");
  AES_AS_TYPECONST  = makeDynInt( DPEL_BOOL,
                                  DPEL_BIT32,
                                  DPEL_UINT,
                                  DPEL_INT,
                                  DPEL_FLOAT,
                                  DPEL_BIT64,
                                  DPEL_ULONG,
                                  DPEL_LONG);

  addGlobal("AES_ES_TYPEFILTER", DYN_STRING_VAR);
  addGlobal("AES_ES_TYPECONST", DYN_INT_VAR);
  AES_ES_TYPEFILTER = makeDynString( "bit", "bit32", "unsigned integer", "integer", 
                                     "float", "bit64","ulong","long", "time", "string", "langstring", "dp identifier",
                                     "dyn bit", "dyn bit32", "dyn unsigned integer", "dyn integer", 
                                     "dyn float", "dyn bit64","dyn ulong","dyn long", "dyn time", "dyn string",
                                     "dyn langstring", "dyn dp identifier" );
  AES_ES_TYPECONST = makeDynInt( DPEL_BOOL,
                              DPEL_BIT32,
                              DPEL_UINT,
                              DPEL_INT,
                              DPEL_FLOAT,
                              DPEL_BIT64,
                              DPEL_ULONG,
                              DPEL_LONG,
                              DPEL_TIME,
                              DPEL_STRING,
                              DPEL_LANGSTRING,
                              DPEL_DPID,
                              DPEL_DYN_BOOL,
                              DPEL_DYN_BIT32,
                              DPEL_DYN_UINT,
                              DPEL_DYN_INT,
                              DPEL_DYN_FLOAT,
                              DPEL_DYN_BIT64,
                              DPEL_DYN_ULONG,
                              DPEL_DYN_LONG,
                              DPEL_DYN_TIME,
                              DPEL_DYN_STRING,
                              DPEL_DYN_LANGSTRING,
                              DPEL_DYN_DPID );
  // 1 Pruefe ob type _AEScreen existiert

  // dp mit type _AEScreen anlegen - name mannummer, module, panelname etc.


  // Checks if the Properties DP exists. If not, it creates it.
  
  // if Properties DP does not exist, create it
  if ( ! dpExists(dpAESProp) )
  {
    bool vis;
    dyn_string sortList;
    dyn_uint diTypeSelections;
      
    if( !dpExists(dpAESProp) )
    {
       aesGenerateDp( dpAESProp, _AES_DPTYPE_PROPERTIES );
       delay(1);
    } 
      
    if( !dpExists(dpAESProp) )
    {
       aes_message( AESMSG_DPCREATE_FAILED, makeDynString( dpAESProp ), 1, __FUNCTION__ );
       return;
    }

    while ( !dpExists(dpAESProp) )
    {
      delay(0,100);
    }
    sortList[1] = "timeStr";
    
    
    // Read names of all systems
    iCheckSystemNames = getSystemNames( dsSystemNames, duSystemIds );
    err = getLastError();
    
    if( iCheckSystemNames == -1 )
    {
      std_error("AES", ERR_SYSTEM, PRIO_SEVERE,
                 E_AS_FUNCTION, "aes_getPropsFilterTypes(): dpGet( ... FilterSystems ...)");
      return;
    }
    if ( dynlen(err) )
    {
      errorDialog(err);
      return;
    }
    
    // Default Values Filter Types
    if ( screenType == AESTYPE_ALERTS )
    {
      for( i = 1; i <= dynlen( AES_AS_TYPEFILTER ); i++ )
        dynAppend( diTypeSelections, 0 );
    }
    else
    {
      for( i = 1; i <= dynlen( AES_ES_TYPEFILTER ); i++ )
        dynAppend( diTypeSelections, 0 );
    }
    if ( dpSetCache(dpAESProp + ".Name:_original.._value", configName,
               dpAESProp + ".ScreenType:_original.._value", screenType,
               dpAESProp + ".User:_original.._value", DEFAULT_USERID,
               dpAESProp + ".Alerts.FilterState.State:_original.._value", 0,
               dpAESProp + ".Alerts.FilterTypes.Selections:_original.._value", diTypeSelections,
//               dpAESProp + ".Alerts.FilterTypes.AlertSummary:_original.._value", 0,
               dpAESProp + ".Alerts.FilterTypes.AlertSummary:_original.._value", AES_SUMALERTS_NO,
               dpAESProp + ".Events.FilterTypes.Selections:_original.._value", diTypeSelections,
               dpAESProp + ".Both.Sorting.SortList:_original.._value", sortList,
               dpAESProp + ".Both.Timerange.Type:_original.._value", 0,
               dpAESProp + ".Both.Timerange.MaxLines:_original.._value", 100,
               dpAESProp + ".Both.Timerange.HistoricalData:_original.._value", true,
               dpAESProp + ".Both.Systems.Selections:_original.._value", dsSystemNames
              ) == -1 )
    {
      std_error("AS", ERR_SYSTEM, PRIO_SEVERE,
                E_AS_FUNCTION, "main(): dpSet(... default values ...)");
      return;
    }
  }
  


// config combobox treating - begin
//  aes_getConfigList( configNames, g_screenType );
  {
    dyn_string dsRealNames, dsDpNames;
    dyn_bool dbDefaults;
    int arProp;
    int index;

    if( g_alertRow )
      arProp=AES_ARPROP_ONLY;
    else
      arProp=AES_ARPROP_EXCL;
    
    aes_getDpsPerType( dsRealNames, dsDpNames, dbDefaults, AES_DPTYPE_PROPERTIES, screenType, false, arProp ); 

//    setValue("configName", "items", configNames );
    setValue("configName", "items", dsRealNames );
    setValue("configName", "text", configName );

    index = dynContains(dsRealNames, configName);
    if (index > 0)
      localProperty.state(0, (int)(substr(dpSubStr(dsDpNames[index], DPSUB_DP),15,4)) >= DISTSYNC_LOCAL_DP_START);
  }
// config combobox treating - end

  // get datas from db and write them to screen
  aes_getProps(dpAESProp, screenType );
}


void aes_setPropRegSettings( const int screenType, const dyn_dyn_anytype &dda)
{
  int first, last;
  int i;

  string reg="reg_main";
  string propRegVis   ="registerVisible";
  string propRegHeader="namedColumnHeader";
  string propRegPanel ="registerPanel";
  
  if( screenType == AESTYPE_ALERTS )
  {
    first=firstAlertReg;
    last=lastAlertReg;
  }
  else
  {
    first=firstEventReg;
    last=lastEventReg;
  }

  for( i=first; i < last; i++ )
  {
    dyn_anytype da=dda[i];
    bool colVis=da[COLVIS];
    int colIdx=da[COLIDX];

    setValue( reg, propRegVis, colIdx, colVis ); 

    if( colVis )
    {
       string name="#"+da[COLIDX];
       string colName=da[COLNAME];
       string panel=da[PANEL];

       setValue( reg, propRegPanel, colIdx, panel, makeDynString("") ); 
       setValue( reg, propRegHeader, name, colName ); 

    }    

  }
}


void aes_buildPropSettings( const dyn_string &regNames, dyn_dyn_anytype &dda )
{
  int c=0, i;
  const string sub="vision/aes/";
  const string ext=".pnl";
  dyn_anytype da;
  int off=0;
  
  // alerts
  i=PREGA_TIMERANGE;     da[COLIDX]=c++; da[PANEL]=sub+"AS_propTime"+ext;          da[COLNAME]=regNames[i]; da[COLVIS]=true;  dda[i]=da; dynClear(da);
  i=PREGA_FILTER;        da[COLIDX]=c++; da[PANEL]=sub+"AS_propFilter"+ext;        da[COLNAME]=regNames[i]; da[COLVIS]=true;  dda[i]=da; dynClear(da);
  i=PREGA_FILTERTYPES;   da[COLIDX]=c++; da[PANEL]=sub+"AS_propFilterTypes"+ext;   da[COLNAME]=regNames[i]; da[COLVIS]=true;  dda[i]=da; dynClear(da);
  i=PREGA_FILTERSTATE;   da[COLIDX]=c++; da[PANEL]=sub+"AS_propFilterState"+ext;   da[COLNAME]=regNames[i]; da[COLVIS]=true;  dda[i]=da; dynClear(da);
  //i=PREGA_FILETERSYSTEM; da[COLIDX]=c++; da[PANEL]=sub+"AS_propFilterSystems"+ext; da[COLNAME]=regNames[i]; da[COLVIS]=true;  dda[i]=da; dynClear(da);
  i=PREGA_FILETERSYSTEM; da[COLIDX]=c++; da[PANEL]=sub+"XS_propFilterSystems"+ext; da[COLNAME]=regNames[i]; da[COLVIS]=true;  dda[i]=da; dynClear(da);
  //i=PREGA_SORT;          da[COLIDX]=c++; da[PANEL]=sub+"AS_propSort"+ext;          da[COLNAME]=regNames[i]; da[COLVIS]=true;  dda[i]=da; dynClear(da);
  i=PREGA_SORT;          da[COLIDX]=c++; da[PANEL]=sub+"XS_propSort"+ext;          da[COLNAME]=regNames[i]; da[COLVIS]=true;  dda[i]=da; dynClear(da);
  i=PREGA_VISIBLE;       da[COLIDX]=c++; da[PANEL]=sub+"XS_propVisibleColumns"+ext;da[COLNAME]=regNames[i]; da[COLVIS]=true;  dda[i]=da; dynClear(da);
  i=PREGA_GENERAL;       da[COLIDX]=c++; da[PANEL]=sub+"XS_propGeneral"+ext;       da[COLNAME]=regNames[i]; da[COLVIS]=true;  dda[i]=da; dynClear(da);

  // events
  c=0;
  i=PREGE_TIMERANGE;     da[COLIDX]=c++; da[PANEL]=sub+"ES_propTime"+ext;          da[COLNAME]=regNames[i]; da[COLVIS]=true;  dda[i]=da; dynClear(da);
  i=PREGE_FILTER;        da[COLIDX]=c++; da[PANEL]=sub+"ES_propFilter"+ext;        da[COLNAME]=regNames[i]; da[COLVIS]=true;  dda[i]=da; dynClear(da);
  i=PREGE_FILTERTYPES;   da[COLIDX]=c++; da[PANEL]=sub+"ES_propFilterTypes"+ext;   da[COLNAME]=regNames[i]; da[COLVIS]=true;  dda[i]=da; dynClear(da);
  i=PREGE_FILTERSTATE;   da[COLIDX]=c++; da[PANEL]=sub+""+ext;                     da[COLNAME]=regNames[i]; da[COLVIS]=false; dda[i]=da; dynClear(da);
  //i=PREGE_FILETERSYSTEM; da[COLIDX]=c++; da[PANEL]=sub+"ES_propFilterSystems"+ext; da[COLNAME]=regNames[i]; da[COLVIS]=true;  dda[i]=da; dynClear(da);
  i=PREGE_FILETERSYSTEM; da[COLIDX]=c++; da[PANEL]=sub+"XS_propFilterSystems"+ext; da[COLNAME]=regNames[i]; da[COLVIS]=true;  dda[i]=da; dynClear(da);
  //i=PREGE_SORT;          da[COLIDX]=c++; da[PANEL]=sub+"ES_propSort"+ext;          da[COLNAME]=regNames[i]; da[COLVIS]=true;  dda[i]=da; dynClear(da);
  i=PREGE_SORT;          da[COLIDX]=c++; da[PANEL]=sub+"XS_propSort"+ext;          da[COLNAME]=regNames[i]; da[COLVIS]=true;  dda[i]=da; dynClear(da);
  i=PREGE_VISIBLE;       da[COLIDX]=c++; da[PANEL]=sub+"XS_propVisibleColumns"+ext;da[COLNAME]=regNames[i]; da[COLVIS]=true;  dda[i]=da; dynClear(da);
  i=PREGE_GENERAL;       da[COLIDX]=c++; da[PANEL]=sub+"XS_propGeneral"+ext;       da[COLNAME]=regNames[i]; da[COLVIS]=true;  dda[i]=da; dynClear(da);

}

//**********************************
// BUTTON ACTIONS
//**********************************

bool aes_copyDp( string sourceDp, string targetDp, int copyMode=AES_CPM_ALL )
{
  dyn_string ds, dsRes;
  dyn_anytype da, daRes;
  int i, l, ic=1, err;
  string search, pattern;

  if( !dpExists( targetDp ) )
  {
    dpCopy( sourceDp, targetDp, err );
    if( err != 0 )
    {
      // dialog dp not found
      return false;
    }
  }

  // read structure information from source dp
  ds=dpNames( sourceDp+".**"+ AES_ORIVAL );

  // reading values from source dp
  dpGet(ds, da);

  l=dynlen(ds);
  // replace path info / from source to target 
  for(i= 1; i<=l; i++)
    strreplace( ds[i], sourceDp, targetDp );

  for(i= 1; i<=l; i++)
  {
    if( copyMode == AES_CPM_ALL )
    {
      // will copy full dpe
      //dynAppend( dsRes, ds[i] );
      //dynAppend( daRes, da[i] );
      dsRes[ic]=ds[i];
      daRes[ic]=da[i];
      ic++;
    }
    else if( copyMode == AES_CPM_RESTORE )
    {
      search=ds[i];
      pattern=dpSubStr( search, DPSUB_SYS_DP ) + ".functions";

      // copy all datas explicitly function parts
      /*if( strpos( search, pattern ) == 0 )IM 109240
      {
        // dont copy
      }
      else*/
      {
        // copy only if we didnt find the string on position 0
        //dynAppend( dsRes, ds[i] );
        //dynAppend( daRes, da[i] );
        dsRes[ic]=ds[i];
        daRes[ic]=da[i];
        ic++;
      }
    }
  }

// workaround !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//**********************************************
//**********************************************
  delay( 2 );
  // setting restore values to work struct
  if( dpSetCache(dsRes, daRes) == 0 )
  {
    return true;
  }
  else
  {
    return false;
  }
}


void aes_addPropertyConfig()
{
  string     sConfig, configDp, propDpConfigName;
  dyn_float  df;
  dyn_string ds, configDpNames, configNames, configList, dsDpNames;
  dyn_bool dbDefaults;
  bool runtime=false;
  bool createLocal=false;
  int ret=0, arProp;
  
  // dialog for config name
  ChildPanelOnCentralModalReturn("vision/MessageInput",
    getCatStr("profibus","conf"),
    makeDynString(getCatStr("dpeMonitor","dpeMon_please_enter"),"%s",""),
    df, ds);

  // nothing enterd
  if ( dynlen(ds) < 1 || (sConfig=strrtrim(strltrim(ds[1]))) == "" )
    return;
  
  // replace with aec_inputDialog() !!!!!
  // check name
/*  if ( !dpNameCheck(sConfig) && false )  // IM 106396 disabled this messages
  {
    ChildPanelOnCentralModal("vision/MessageWarning",
      getCatStr("para","warning"),
      makeDynString(getCatStr("sim","forbidden_chars")));
    return;
  }*/
  
  if( ! aes_operationPermission( sConfig, AES_OPERTYPE_PROPERTIES, AES_OPER_NEW ) )
  {
     ChildPanelOnCentralModal("vision/MessageWarning",
      getCatStr("para","warning"),
      makeDynString(getCatStr("general","permission")));
    return;
  }

  setMultiValue(  "pb_saveConfig", "enabled", true,
                  "pb_deleteConfig", "enabled", true );

  // check whether name already exists
  configList=configName.items;
  if ( dynContains( configList, sConfig ) > 0 )
  {
    ChildPanelOnCentralModal("vision/MessageWarning",
      getCatStr("para","warning"),
      makeDynString(getCatStr("ac","dpexists") + "\n" + sConfig));
    return;
  }

  if (distsync_isConfigured())
  {
    if (distsync_amIMasterSystem())
      createLocal = distsync_ShowLocalMessage(DISTSYNC_AESPROPERTY_MASTER);
    else
      createLocal = distsync_ShowLocalMessage(DISTSYNC_AESPROPERTY);
  }

  // getting automatic generated propdpname
  propDpConfigName=aes_getPropDpName( AES_DPTYPE_PROPERTIES, runtime, AESTAB_TOP, false, false, createLocal);


  aes_setProps( propDpConfigName, sConfig, g_screenType, g_tabType, ret, true );

  if( ret != 0 )
  {
    // dont update the combobox
    return;
  }

  if( g_alertRow )
    arProp=AES_ARPROP_ONLY;
  else
    arProp=AES_ARPROP_EXCL;

  // get all propconfigs
  aes_getDpsPerType( configList, dsDpNames, dbDefaults, AES_DPTYPE_PROPERTIES, g_screenType, false, arProp ); 
  // append name to comboboxtext/list
  //dynAppend( configList, sConfig);
  configName.items = configList;
  configName.text = sConfig;

  localProperty.state(0, createLocal);
}


void aes_savePropertyConfig()
{
  string     sConfig, configDp;
  string     errMsg;
  dyn_float  df;
  dyn_string ds, configDpNames, configNames;
  int ret;
  
  sConfig = configName.text;
  
  if ( sConfig == "" )
  {
    ChildPanelOnCentralModal("vision/MessageWarning",
      getCatStr("para","warning"),
      makeDynString(getCatStr("dpeMonitor","dpeMon_please_enter")));
    return;
  }
  
  aes_getDpName4RealName( sConfig, AES_DPTYPE_PROPERTIES, g_screenType, configDp );

  if ( configDp == "" )
  {
    ChildPanelOnCentralModal("vision/MessageWarning", "",
      makeDynString("$1:" + getCatStr("sc", "unknownConfig")));
    return;
  }

  if( ! aes_operationPermission( configDp, AES_OPERTYPE_PROPERTIES, AES_OPER_SAVE ) )
  {
     ChildPanelOnCentralModal("vision/MessageWarning",
      getCatStr("para","warning"),
      makeDynString(getCatStr("general","permission")));
    return;
  }
  
  if (distsync_amIClientSystem() && !localProperty.state(0))
  {
    distsync_ShowLocalMessage(DISTSYNC_AESPROPERTYWARNING);
  }
  
  if( aes_checkUserLocksOutHimself(errMsg) ) //Test if the user locks out himself of this configuration when saving.
  {
    ChildPanelOnCentralModalReturn("vision/MessageWarning2", "warning",
                             makeDynString("$1:" + errMsg,
                                           "$2:" + getCatStr("sc","yes"),
                                           "$3:" + getCatStr("sc","no")), df, ds);
    
    if ( !dynlen(df) || !df[1] ) // User said no, he doesn't want to save.
      return;
  }
  
  aes_setProps(configDp, sConfig, g_screenType, g_tabType, ret );
  if( ret != 0 )
  {
    // dialog - save failed
  }

}


void aes_loadPropertyConfig( string inpConfig="" )
{
  setValue("so_table", "deleteAllLines");
  string configName, configDp;
   
  if( inpConfig == "" )
  {
    configName=this.text;
  }
  else
  {
    configName=inpConfig;
  }

  if ( configName == "" )
  {
    ChildPanelOnCentralModal("vision/MessageWarning", "",
      makeDynString("$1:" + getCatStr("sc", "unknownConfig")));
    return;
  }

  if( !aes_operationPermission( configName, AES_OPERTYPE_PROPERTIES, AES_OPER_REMOVE ) )
  {
    setMultiValue(  "pb_saveConfig", "enabled", false,
                    "pb_deleteConfig", "enabled", false );
  }
  else
  {
    int deletePermission; //contains the permission to delete a DP
    dpGetCache("_System.Auth.Dp:_original.._value", deletePermission); // Querie the userpermission which is needed to delete a DP
    
    setMultiValue(  "pb_saveConfig", "enabled", true,
                    "pb_deleteConfig", "enabled", getUserPermission(deletePermission)); // set enabled if user is allowed to delete a DP
  }

  // write config info to runtime dp
  dpSetCache( g_propDpName + ".Settings.Config" + AES_ORIVAL, configName );
  

  // getting dp name
  aes_getDpName4RealName( configName, AES_DPTYPE_PROPERTIES, g_screenType, configDp );

  if ( configDp == "" )
  {
    ChildPanelOnCentralModal("vision/MessageWarning", "",
      makeDynString("$1:" + getCatStr("sc", "unknownConfig")));
    return;
  }

  aes_getProps( configDp, g_screenType, g_tabType );

  localProperty.state(0, (int)(substr(dpSubStr(configDp, DPSUB_DP),15,4)) >= DISTSYNC_LOCAL_DP_START);
}


void aes_removePropertyConfig()
{
  string cfgName, configDp, config, newConfig;
  dyn_string configList, dsDpNames;
  dyn_bool dbDefaults;
  int arProp;
  int pos, newPos, listLen;
  dyn_float df;
  dyn_string ds;
  
  if (distsync_amIClientSystem() && !localProperty.state(0))
  {
    distsync_ShowLocalMessage(DISTSYNC_AESPROPERTYWARNING);
  }

  ChildPanelOnCentralModalReturn("vision/MessageInfo", "question",
                             makeDynString("$1:" + getCatStr("sc", "realyWantToDelete"),
                                           "$2:" + getCatStr("sc", "yes"),
                                           "$3:" + getCatStr("sc", "no")), df, ds);

  if ( !dynlen(df) || !df[1] ) // User said no, he doesn't want to delete.
    return;
  
  getValue("configName", "text", cfgName,
            "items", configList );

  if ( cfgName == "" )
  {
    ChildPanelOnCentralModal("vision/MessageWarning", "",
      makeDynString("$1:" + getCatStr("sc", "unknownConfig")));
    return;
  }

  pos=dynContains( configList, cfgName );
  listLen=dynlen( configList );

  if( pos == listLen )
    newPos=pos-1;
  else
    newPos=pos+1;

  newConfig=configList[newPos];
  dynRemove( configList, pos );

  // getting dp name
  aes_getDpName4RealName( cfgName, AES_DPTYPE_PROPERTIES, g_screenType, configDp );

  if ( configDp == "" )
  {
    ChildPanelOnCentralModal("vision/MessageWarning", "",
      makeDynString("$1:" + getCatStr("sc", "unknownConfig")));
    return;
  }

  if( ! aes_operationPermission( configDp, AES_OPERTYPE_PROPERTIES, AES_OPER_REMOVE ) )
  {
     ChildPanelOnCentralModal("vision/MessageWarning",
      getCatStr("para","warning"),
      makeDynString(getCatStr("general","permission")));

    return;
  }

  if( getUserPermission(4) )
  {
    dpRemoveCache( configDp );
    if (dpDelete( configDp ) != 0)
    {
      ChildPanelOnCentralModal("vision/MessageWarning", "",
        makeDynString("$1:" + getCatStr("sc", "unknownConfig")));
      return;
    }
  }

  if( g_alertRow )
    arProp=AES_ARPROP_ONLY;
  else
    arProp=AES_ARPROP_EXCL;


  configName.items = configList;
  configName.text = newConfig;

  if( !aes_operationPermission( newConfig, AES_OPERTYPE_PROPERTIES, AES_OPER_REMOVE ) )
  {
    setMultiValue(  "pb_saveConfig", "enabled", false,
                    "pb_deleteConfig", "enabled", false );
  }
  else
  {
    setMultiValue(  "pb_saveConfig", "enabled", true,
                    "pb_deleteConfig", "enabled", true );
  }

  aes_loadPropertyConfig( newConfig );
}


void aes_doAEConfigChild()
{
  bool activeTop, activeBot;
  dyn_string ds;
  dyn_float df;

  bool AECRunning=false;

  string fileName, panelName, screenConfigName;  
  panelName="AESConfig";
  fileName="vision/aes/AESConfig.pnl";

  /// pruefe ob panel schon offen ist !!!!!!!!!!!!
  /// direkt mit flag in aeconfig dp !!!!!!!!!!!!!
  /// + Berechtigungscheck !!!!!!!
  //dpGet( _AEC_DP_ROOT + ".Running" + AES_ONLVAL ,AECRunning );
  
  if( ! AECRunning )
  {
    if( aes_checkPermission( AES_PERM_ALLOWAECONFIG ) == AES_PERM_OK )
    { 
      // we have to set this variable to false to ensure that AEConfig will use the right variable (vst/vstn)
      g_initFromAES=false;
      ChildPanelOnModalReturn( fileName, aes_getCatStr( "mid_aeconfigcap" ), makeDynString("$from:fromaes"), 1, 1, df, ds );
    }
    else
    {
      // message missing permission
    }
  }
  else
  {
    // message aeconfig currently running 
  }

  // important for proper use of global variable vst/vstn
  g_initFromAES=true;

  if( df[1] == AES_CONF_OK )
  {
    // we can't reload settings here because we have no access to panelglobal variable vstn
    // it happens in controlCB and we only trigger it here - we use the topDp
    dpSetCache( g_propDpNameTop + ".Settings.Changed" + AES_ORIVAL, AES_CHANGED_AECONFIG );

  }
  else
  {
    //AES_CONF_CANCEL )
    // nothing to do
  }

}


int aes_checkPermission( int permFor )
{

  if( permFor == AES_PERM_ALLOWAECONFIG )
  {
    // check permission !!!
    return AES_PERM_OK;
  }
  else
  {
    return AES_PERM_NOK;
  }

  return AES_PERM_NOK;
}


void aes_runBoth()
{
  bool actTop, actBot;
  bool topFinished=false;
  unsigned runMode;

  // important - both runModes have to be initialized with runMode == AES_RUNMODE_STOPPED !!!
  
  // check activity and trigger start
  aes_getActivity( g_propDpNameTop, actTop );
  aes_getActivity( g_propDpNameBot, actBot );


  if( actTop )
  {  
    aes_doStart( g_propDpNameTop, 3 );
  }

  // start second table only if first is not active ore query start finished
  if( actBot )
  {
    while( ( !topFinished ) && ( actTop ) )
    {
      aes_getRunMode( g_propDpNameTop, runMode, __FUNCTION__ );

      if( runMode == AES_RUNMODE_RUNNING )
      {
        topFinished=true;
      }
      else
      {
        topFinished=false;
      }
      delay( 0, 300 );
    }

    aes_doStart( g_propDpNameBot, 4 );
  }

}


///////////////////////////////////////////////
// new properties treating - from panel / begin
//////////////////////////////////////////////}


int openAES( string screenConfig="aes_default", string module="WinCC_OA-AES", int action=AES_ACTION_INTERACT, string fileName="" , int xPos = 0, int yPos = 0)
{
  const string aesPanel="vision/aes/AEScreen.pnl";
  dyn_string param;
  string scDpName="";
  bool bStayOnTop;
  dyn_string ds;
  dyn_float df;

  if (module != "FALSE" && module != "TRUE")                                             // module is used for stayOnTop Parameter
  {
     dpGetCache("_Config.SysMgmStayOnTop:_online.._value", bStayOnTop);
  }
  else
  {
     bStayOnTop = module;
     module = "WinCC_OA-AES";
  }



  // check whether screen config exists
  aes_getDpName4RealName( screenConfig, AES_DPTYPE_SCREEN, AESTYPE_GENERAL, scDpName );
  if( scDpName == "" )
  {
    //dialog - configuraion not found !!!
    return -1;
  }
  
  if( screenConfig != "" )
  {
    param=makeDynString(  AESREGDOLLAR_SCREENTYPE + ":" + screenConfig,
                          AESREGDOLLAR_ACTION + ":" + action, 
                          AESREGDOLLAR_FILENAME + ":" + fileName );
  }
  //TODO FIX HERE!!!!
  // only for long time test
  if( g_longTest )
  {
    //RootPanelOn(aesPanel,"AES LongTime",param);
    ChildPanelOnModalReturn( aesPanel, "AES LongTime", param, 0, 0, df, ds );
    return 0;
  }
  if( ! isModuleOpen( module ) )
  {
  RootPanelOn(aesPanel,"AES LongTime",param);
    //ModuleOnWithPanel( module, xPos,yPos,0,0,0,0, "", aesPanel, "", param );
    if ( bStayOnTop)
    {
      stayOnTop ( TRUE, module);
    }
  }
  else
  {
    RootPanelOnModule(aesPanel, "", module,  param );
    //RootPanelOn(aesPanel,"AES LongTime",param);
    if ( bStayOnTop)
    {
      stayOnTop (TRUE, module);
    }
  }


  return 0;  // OK
}


void setAESDpList( dyn_string dpList )
{
  string propDp;
  
  propDp=aes_getPropDpName( AES_DPTYPE_PROPERTIES, true, AESTAB_TOP, true );

  aes_doStop( propDp );

  dpSetCache( propDp + ".Alerts.Filter.DpList" + AES_ORIVAL, dpList );

  aes_doStart( propDp, 5 );
}


bool aesGenerateDp(string dp, string dpType)
{
  bool ret;
  int timeout = 1000;  // 10 seconds
  int iCounter;
  
//  if (getUserPermission(4))
//     ret = dpCreate(dp, dpType);
 
  dpSet("_CtrlCommandInterface_1.Command:_original.._value", "aesGenerateDp "+dp+" "+dpType); // TFS 7166 rework of Command Interface
  
  while ( !ret && !dpExists(dp) && iCounter <= timeout )
  {
    iCounter++;
    delay(0,10);
  }
 
  if ( iCounter >= timeout)
    ret = FALSE;
  else
    ret = TRUE;
    
  return(ret);
}

// ============================================================================
// Function:    bool aes_getFiltered_and_ForceFiltered_Attribute( string dpe, string dpeDetail, time ti, int count, bool &filtered, bool &force_filtered )
// -> writes the filtered-bit and the force_filtered-bit on given Parameters for a dpe, detail and Detail-Range
// Parameters:  dpe
//              dpeDetail...Detail e.g. "_alert_hdl.",
//              ti    ...the Time of an Alert
//              count ...the Count of an Alert
//              &filtered, &force_filtered
// return:      false if the attributes are not found
// ============================================================================
bool aes_getFiltered_and_ForceFiltered_Attribute( string dpe, string dpDetail, time ti, int count, bool &filtered, bool &force_filtered )
{
  string select;
  int iType;
    
  dpGet( dpSubStr(dpe, DPSUB_SYS_DP_EL) + ":_alert_hdl.._type", iType);   

  if (iType != DPCONFIG_SUM_ALERT )
  {
    select =  "SELECT ALERT "+
              "'"+dpDetail+"._filtered', '"+dpDetail+"._force_filtered' " + 
              " FROM " + "'"+dpSubStr(dpe, DPSUB_DP_EL) +"'";
  }
  else  // sum alert
  {
    strreplace(dpe, "._class", "");
    select =  "SELECT ALERT "+
              "'"+dpDetail+"._filter_active', '"+dpDetail+"._force_filter_active' " + 
              " FROM " + "'"+dpSubStr(dpe, DPSUB_DP_EL) +"'";
  }
    
  select += getSystemName()!=dpSubStr(dpe, DPSUB_SYS)?(" REMOTE '"+dpSubStr(dpe, DPSUB_SYS)+"'"):"";
  dyn_dyn_anytype tab;
  int theRange;
  
  dpQuery( select, tab ); 
  theRange = aes_getRangeOfTab(tab, dpe, ti, count);  

  if ( dynlen( tab ) > 1 && theRange>=0 )
  {
    filtered = tab[theRange][3];
    force_filtered = tab[theRange][4];    
  }
  else
  {
    return false;
  }
  return true;
}
// ============================================================================
// Function:    void aes_splitSortList(dyn_string sortListWithAsc, dyn_string &sortList, dyn_bool &sortAsc)
// <- splits the sortlist(containing string Name of Column and bool ascending) to dyn_string Names and dyn_bool ascending
// Parameters:  sortListWithAsc ...sortlist(containing string Name of Column and commaseperated bool ascending) 
//                e.g. "Time,1", &sortList ...return of the ColumnNames, &sortAsc ...return of ascending for every Column
// ============================================================================
void aes_splitSortList(dyn_string sortListWithAsc, dyn_string &sortList, dyn_bool &sortAsc)
{
  int posOfSeparator;
  string tmp_string, s;
  bool tmp_bool;
  for (int i=1; i<=dynlen(sortListWithAsc); i++)
  {
    s = sortListWithAsc[i];
    if (strlen(s)>=3 && (s[strlen(s)-2] == "," && ( s[strlen(s)-1] == "0" || s[strlen(s)-1] == "1" )))
    {
      tmp_string = substr(s, 0, strlen(s)-2);
      tmp_bool = (s[strlen(s)-1]=='1'? true:false);
    }
    else
    {
      tmp_string = s;
      tmp_bool = true;
    }
    dynAppend(sortList, tmp_string);
    dynAppend(sortAsc, tmp_bool);
  }
}
// ============================================================================
// Function:    string aes_getDpDetail(string dpe)
// <- workaround for getting out the detail of a DP
// Parameters:  dpe ...the DP
// return:      the Detail or "" if no Detail is given
// ============================================================================
string aes_getDpDetail(string dpe)
{
  string dpInclDetail = dpSubStr(dpe, DPSUB_CONF_DET), dpWithoutDetail = dpSubStr(dpe, DPSUB_CONF);
  return substr(dpInclDetail, strlen(dpWithoutDetail)+1);
}
// ============================================================================
// Function:    int aes_getRangeOfTab(dyn_dyn_anytype tab, string dpe, time ti, int count)
// <- get the index of a table which the given alert contains
// Parameters:  tab   ...the table which is a result of a query
//              dpe   ...the Identifier of an Alert
//              ti    ...the Time of an Alert
//              count ...the Count of an Alert
// return:      the index of the searched alert
//              -1 if it isn't found in the table
// ============================================================================
int aes_getRangeOfTab(dyn_dyn_anytype tab, string dpe, time ti, int count)
{
  string detail = aes_getDpDetail(dpe);
  atime tmpATime;
  int therange=-1;  //return -1 if it isn't found
  string tmpDpe=dpSubStr(dpe,DPSUB_SYS_DP_EL_CONF_DET);
  
  
  for (int i=2; i<=dynlen(tab); i++)  //start at 2
  {
    tmpATime = tab[i][2];
    if (dpSubStr(getAIdentifier(tmpATime),DPSUB_SYS_DP_EL_CONF_DET)==tmpDpe && getACount(tmpATime)==count && ((time)tmpATime)==ti)
    {
      therange=i;
      break;
    }
  }
  return therange;
}
// ============================================================================
// Function:    bool isAlertFilteringActive()
// <- check if AlertReduction is set in Configfile
bool isAlertFilteringActive()
{
  int activeAlertFiltering=0, ret;
  ret = paCfgReadValue(PROJ_PATH+"config/config", "general", "activateAlertFiltering", activeAlertFiltering);
  if ( ret == -1 )  //ConfigEntry not found
    return TRUE;    //default since 3.7 is active alertReduction
  return ((activeAlertFiltering>0 ? true : false));
}

aes_setFilterTypeInfo(anytype at)
{
  string sSelectText;  
  int iFilterType;
  dyn_string ds;
  
  if (getType(at) == STRING_VAR)
  {
    string sFilterType;
    ds = strsplit(at, ":"); 
    if (dynlen(ds) > 1)
    {
      sFilterType = ds[1]; 
      sSelectText = ds[2]; 
    }
    else
      sFilterType = at; 
    
    
    switch (sFilterType)
    {
      case "NONE": 
      case "":      iFilterType = 0 ;break; 
      case "GLOBAL":iFilterType = 1 ;break; 
      case "GROUP": iFilterType = 2 ;break; 
      case "USER":  iFilterType = 3 ;break; 
      default:      iFilterType = 0 ;break; 
    } 
  }  
  else
     iFilterType = at;  
     
  if (iFilterType == 2)
  {
    dyn_mapping dmGroups; 
    dyn_string dsGroups;
    //   dmGroups = getGroupsOfUserPVSS(getUserId ());   
    dmGroups = getAllGroupsPVSS();  
  
    for (int i=1; i<= dynlen(dmGroups); i++)
      dsGroups[i] = dmGroups[i]["Name"];
    setValue("cb_FilterType","items",dsGroups,
             "visible", TRUE,
             "selectedPos", 1);
    if (sSelectText != "")
      setValue("cb_FilterType","selectedPos",dynContains(dsGroups,sSelectText));
    else
      setValue("cb_FilterType","selectedPos", 1);
  }
  else if (iFilterType == 3)
  {
    dyn_mapping dmUsers; 
    dyn_string dsUsers;
    dmUsers = getAllUsersPVSS();   
    for (int i=1; i<= dynlen(dmUsers); i++)
       dsUsers[i] = dmUsers[i]["Name"];
    setValue("cb_FilterType","items",dsUsers,
             "visible", TRUE,
             "selectedPos", 1);
    if (sSelectText != "")
      setValue("cb_FilterType","selectedPos",dynContains(dsUsers,sSelectText));
    else
      setValue("cb_FilterType","selectedPos", dynContains(dsUsers,getUserName()));
   } 
   else 
      setValue("cb_FilterType","deleteAllItems",
               "visible",FALSE); 

   bool hasPermissionSetAlias = getUserPermission(g_setAliasPermission);
   bool hasPermission2 = getUserPermission(2);
   setValue( "rabo_FilterType", "number", iFilterType,
                               "itemEnabled", 1, getUserPermission(4),  // alle
                               "itemEnabled", 2, getUserPermission(3),  // gruppe
                               "itemEnabled", 0, hasPermission2,  // Bedienberechtigung
                               "itemEnabled", 3, hasPermission2); // Bedienberechtigung

   setMultiValue("rabo_FilterType", "enabled", hasPermissionSetAlias,
                 "frm_FilterType", "enabled", hasPermissionSetAlias,
                 "cb_FilterType", "enabled", hasPermissionSetAlias);
}

aes_prepareForTableAcknowledge(int action, int tabType, mapping &mTableMultipleRows)
{
  int i, j, row, column, start, stop, length;
  string tableName;
  dyn_anytype alertRow;
  mapping mTableRow;
  
  if( tabType == AESTAB_TOP )
    tableName=AES_TABLENAME_TOP;
  else
    tableName=AES_TABLENAME_BOT;
  
  switch(action)
  {
    case AES_CHANGED_ACKSINGLE:
      getValue( tableName, "currentCell", row, column );
      start = stop = row;
      break;
    case AES_CHANGED_ACKALLVIS:
      getValue( tableName, "lineRangeVisible", start, stop); 
      break;
    case AES_CHANGED_ACKALL:
      getValue( tableName, "lineCount", stop);
      start = 0;
      stop--;
      break;
    default:
      start = 0;
      stop = 0;
      break;
  }


  setValue( tableName, "updatesEnabled", false );
  
  //sort to enable correct ACK'ing order
  if ( start != stop || (start == 0 && stop == 0) ) // IM 113997, 114102
  {
    if ( stop < start )
      setValue( tableName, "sortPart", stop, start, _TIME_, _COUNT_);
    else
      setValue( tableName, "sortPart", start, stop, _TIME_, _COUNT_);
  
    for(i=start; i<=stop; i++)
    {
      getValue( tableName, "getLineN", i, alertRow);
      length = dynlen(alertRow);
      for(j=1; j<=length; j++)
      {
        string columnTitle;
        getValue( tableName, "columnName", j-1, columnTitle);
        mTableRow[columnTitle] = alertRow[j];
        mTableMultipleRows[i] = mTableRow;
      }
    }
  }
  
  if ( start != stop )
    setValue( tableName, "sortUndo", 0);
  
  setValue( tableName, "updatesEnabled", true );

  if ( start >= 0 )
    setValue( tableName, "lineVisible", start);
}

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
//
//  Autor: Markus Trummer 2009
//  Function calls ep_acknowledgeTableFunction for mapping
//  sObjectName... string 
//  iType = 0..... only sColumn_DPE
//  iType = 1..... sColumn_DPE, sColumn_Time, Column_Index, sColumn_Confirmable   eg used in alertscreen
//
//
void aes_acknowledgeTableFunction( string sObjectName, int iType,
                                   mapping mTableMultipleRows, int iForcedMode = 0)
{
//modified to accept data of row in table in functions arguments
//avoids timing issue when reading from the table some time after the original event

  ep_acknowledgeTableFunction( sObjectName, iType, 
                                  "", 
                                  "", 
                                  "",
                                  "",
                                  0,
                                  -1,
                                  iForcedMode, 
                                  mTableMultipleRows);
}

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
//
//  Autor: Markus Trummer 2009
//  Function for getting rdb compessed DPEs of From-Clause
//  sFrom        ... string with the original From Clause e.g. "'{testInt.:_offline._1min_avg,testInt.:_offline._5min_avg,testInt.,testInt.:_offline._1min_sum,testFloat.:_offline._5min_avg,testFloat.}'"
//  sAttributes  ... string with the original Attribues of the Select statement
//  dsFrom       ... dyn_string return of different From Clauses for the RDB compression
//  dsAttributes ... dyn_string return of different Attriubtes for the RDB compression
//
private void aes_getRdbComprDpes(const string &sFrom, const string &sAttributes, dyn_string &dsFrom, dyn_string &dsAttributes)
{
  string sTmp = substr(sFrom, 2, strlen(sFrom)-4);
  dyn_string dsNoCompr;
  mapping mCompressions;

  dyn_string dsDpes = strsplit(sTmp, ','); 
  
  //search for all RDB compressed DPEs
  dyn_string dsTmp;
  string sDpeConfig, sDpeConfigDetail;
  string sCompr;  

  for (int i=1; i<=dynlen(dsDpes); i++)
  {
    sDpeConfig = dpSubStr(dsDpes[i], DPSUB_DP_EL_CONF);
    sDpeConfigDetail = dpSubStr(dsDpes[i], DPSUB_DP_EL_CONF_DET);

    //no RDB compression
    if (strlen(sDpeConfig)+1==strlen(sDpeConfigDetail) || sDpeConfig=="")  //also if dpSubStr has "" als result e.g. for '*'
    {
      dynAppend(dsNoCompr, dsDpes[i]);
    }
    else //rdb compression
    {
      sCompr = substr(sDpeConfigDetail, strlen(sDpeConfig)+1); //get compression level
      if (!mappingHasKey(mCompressions, sCompr))  //group dpes to compression levels
      {
        mCompressions[sCompr]=makeDynString(dpSubStr(dsDpes[i], DPSUB_DP_EL));
      }
      else
      {
        dsTmp = mCompressions[sCompr];
        dynAppend(dsTmp, dpSubStr(dsDpes[i], DPSUB_DP_EL));
        mCompressions[sCompr] = dsTmp;
      }
    }
  }
  
  dyn_string dsSingleComprAttributes = mappingKeys(mCompressions);

  for (int i=1; i<=dynlen(dsSingleComprAttributes); i++) //build from clause for every compression level (with it's dpes)
  {
    dynAppend(dsFrom, aes_buildFromClauseOfDynString(mCompressions[dsSingleComprAttributes[i]]));
    sTmp = sAttributes;
    strreplace(sTmp, "'_offline.", "'_offline."+dsSingleComprAttributes[i]);
    dynAppend(dsAttributes, sTmp);
  }

  //add FROM clause and attributes without RDB compression at first position
  string tmpFrom;
  if (dynlen(dsNoCompr)>0)
  {
    dynInsertAt(dsFrom, aes_buildFromClauseOfDynString(dsNoCompr), 1);
    dynInsertAt(dsAttributes, sAttributes, 1);
  } 
}

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
//
//  Autor: Markus Trummer 2009
//  Function for building From Clause for SelectStatemten from dyn_string of DPEs
//  dsFrom ... dyn_string Elements for the From Clause
//  return ... string the Elementstring in right format
private string aes_buildFromClauseOfDynString(const dyn_string &dsFrom)
{
  string tmpFrom = "'{";
  for (int i=1; i<=dynlen(dsFrom); i++)
  {
    if (i!=1)
      tmpFrom+=",";
    tmpFrom+=dsFrom[i];
  }
  tmpFrom += "}'";
  return tmpFrom;
}
//
// Thread for blocking acknowledge  IM 116619
//
void aes_blockAcknowledeThread()
{
   g_bBlockAcknowledge = TRUE;  // block

   int valQueryHLBlockedTime;
   dpGetCache( "_Config.QueryHLBlockedTime" + AES_ONLVAL, valQueryHLBlockedTime );   //  get bocking time [ms] from dp
   if( valQueryHLBlockedTime <= 0 ) valQueryHLBlockedTime=AES_DEFVAL_QUERYHLBLOCKEDTIME; // check if correct
   delay(valQueryHLBlockedTime/1000);   //  delay 

   g_bBlockAcknowledge  = FALSE;  // release   
} 


aes_createFromSys(string s_from, string s_system, string &s_resultFrom, int &i_return)
{
  // in a distributed system we need a FROM statement without system names
  // also in a single system the FROM statement cannot contain system names
  dyn_string ds_fromDPEs;
  dyn_string ds_resultDPEs;
  string s_fromTMP;
  
  if(isSmallPanel)
  {
      //int currentFurnace;
      //dpGet(getSystemName()+"CurrentFurnace.",currentFurnace);
      Filter = "'{*F-"+selectedFurnace+".Alarms.TemperatureController1.Alarms.*}'";
  }
  int i;
  

  //System1:Furnace3.Alarms.TemperatureController1.Alarms.FurnaceOverTemperature
  
    
  DebugFTN("aesDist",__LINE__,__FUNCTION__,s_system,s_from);

  // check if a dpe filter is defined and if it contains system names
  if(s_from == "'{*}'" || strpos(s_from,":",0) == -1)
  {
    // nothing to do - statement is okay
    s_resultFrom = s_from;
    s_resultFrom = Filter;
    i_return = 1;
    DebugFTN("aesDist",__LINE__,__FUNCTION__,"nothing to do - statement is okay",s_system,s_resultFrom);
  }
  else
  {
    // remove the brackets { } and the ' character
    s_fromTMP = s_from;
    strreplace(s_fromTMP,"'{","");
    strreplace(s_fromTMP,"}'","");

    strreplace(s_system,"'","");
    strreplace(s_system,":","");
        
    ds_fromDPEs = strsplit(s_fromTMP,",");
  
    for(i=1;i<=dynlen(ds_fromDPEs);i++)
    {
      string s_systemDPE;
      string s_dpe;
      dyn_string ds_dpeParts;
    
      s_dpe = ds_fromDPEs[i];
    
      // no system name defined
      if(strpos(s_dpe,":",0) == -1)
        dynAppend(ds_resultDPEs,s_dpe);
      else
      {
        // strsplit needs to be used because the FROM-statement can also contain wildcards
        ds_dpeParts = strsplit(s_dpe,":");
    
        // dpe oder search pattern is for the own system
        if(ds_dpeParts[1] == s_system)
          dynAppend(ds_resultDPEs,ds_dpeParts[2]);
      }
    }

    if(dynlen(ds_resultDPEs) > 0)
    {
      s_resultFrom = "'{" + ds_resultDPEs[1];
  
      for(i=2;i<=dynlen(ds_resultDPEs);i++)
      {
        s_resultFrom = s_resultFrom + "," + ds_resultDPEs[i];
      }
      s_resultFrom = s_resultFrom + "}'";
      i_return = 2;
      s_resultFrom = Filter;
    }
    else
    {
      DebugFTN("aesDist",__LINE__,__FUNCTION__,"no matching DPEs found");
      s_resultFrom = "";
      i_return = -1;
      s_resultFrom = Filter;
    }
  }
  DebugFTN("aesDist",__LINE__,__FUNCTION__,s_resultFrom);
}



aes_checkDistSystemsRedu(string s_dpH1, dyn_int di_systemsH1,
                         string s_dpH2, dyn_int di_systemsH2,
                         string s_dpConnH1, dyn_string ds_connH1,
                         string s_dpConnH2, dyn_string ds_connH2)
{
  string s_propDp;
  unsigned u_runMode, u_propMode;
  dyn_string ds_connectedSystems;
  
  int i_evManIdH1,i_evManIdH2;
  int i_reduActive;
  bool b_splitActive;
  string s_ownSystem;

  // check if the system is running in split mode
  isSplitModeActive(b_splitActive,getSystemName());

  if(b_splitActive)
  {
    // check if there is an active connection to host 1
    i_evManIdH1 = convManIdToInt(EVENT_MAN,0,0,1);
    if(isConnActive(i_evManIdH1))
    {
      // check if the dist manager is already running
      if(dynlen(ds_connH1) > 0)
      {
        aes_getSystemNames(di_systemsH1,ds_connectedSystems);
        DebugFTN("aesDist",__LINE__,__FUNCTION__,"split mode - host 1",ds_connectedSystems);
      }
    }
    else
    {
      // check if the dist manager is already running
      if(dynlen(ds_connH2) > 0)
      {
        aes_getSystemNames(di_systemsH2,ds_connectedSystems);
        DebugFTN("aesDist",__LINE__,__FUNCTION__,"split mode - host 2",ds_connectedSystems);
      }
    }
  }
  else
  {
    i_evManIdH1 = convManIdToInt(EVENT_MAN,0,0,1);
    i_evManIdH2 = convManIdToInt(EVENT_MAN,0,0,2);

    // check which server is active and if the connection is established
    reduActive(i_reduActive);

    if(i_reduActive == 1 && isConnOpen(i_evManIdH1) == 1)
    {
      // check if the dist manager is already running
      if(dynlen(ds_connH1) > 0)
      {
        aes_getSystemNames(di_systemsH1,ds_connectedSystems);
        DebugFTN("aesDist",__LINE__,__FUNCTION__,"active host 1",ds_connectedSystems);
      }
    }
    else if(i_reduActive == 2 && isConnOpen(i_evManIdH2) == 1)
    {
      // check if the dist manager is already running
      if(dynlen(ds_connH2) > 0)
      {
        aes_getSystemNames(di_systemsH2,ds_connectedSystems);
        DebugFTN("aesDist",__LINE__,__FUNCTION__,"active host 2",ds_connectedSystems);
      }
    }
    else
    {
      // connection to active server not established
      dyn_anytype da_panelParams, da_panelResult;
      int i_panelWidth, i_panelHeight, i_xPos, i_yPos;
      float f_zoomFactor, f_initZoomFactor;
      dyn_int di_panelSize;
      string s_fileName;

      DebugFTN("aesDist",__LINE__,__FUNCTION__,"no connection to active server",i_reduActive);
   
      s_fileName = "vision/aes/AESReduMessageWarning.pnl";
      di_panelSize = getPanelSize(s_fileName);
      panelSize(myPanelName(), i_panelWidth, i_panelHeight);
      getZoomFactor(f_zoomFactor, myModuleName());
      getInitialZoomFactor(f_initZoomFactor);
   
      i_xPos = ((i_panelWidth) - (di_panelSize[1] * f_initZoomFactor / f_zoomFactor)) / 2;
      i_yPos = ((i_panelHeight) - (di_panelSize[2] * f_initZoomFactor / f_zoomFactor) - 20) / 2;

      da_panelParams[ 1] = myModuleName();
      da_panelParams[ 2] = s_fileName;
      da_panelParams[ 3] = myPanelName();
      da_panelParams[ 4] = "";
      da_panelParams[ 5] = i_xPos;
      da_panelParams[ 6] = i_yPos;
      da_panelParams[ 7] = 1.0;
      da_panelParams[ 8] = false;
      da_panelParams[ 9] = makeDynString();
      da_panelParams[10] = true;  // modal

      childPanel(da_panelParams, da_panelResult);

      return;
    }
  }
  
  gds_connectedSystems = ds_connectedSystems;

  // always the own system needs to be added if it is not part of the systems list
  s_ownSystem = getSystemName();
  strreplace(s_ownSystem,":","");
         
  if(!dynContains(gds_connectedSystems,s_ownSystem))
    dynAppend(gds_connectedSystems,s_ownSystem);
  
  aes_getPropDpName4TabType(g_tabType,s_propDp);
  aes_getRunMode(s_propDp,u_runMode);
  aes_getPropMode(s_propDp,u_propMode);

  DebugFTN("aesDist",__LINE__,__FUNCTION__,"connected systems",gds_connectedSystems,s_propDp,u_runMode);
  
  // if the AEScreen is already running call the function to connect to new systems
  if(u_runMode == AES_RUNMODE_RUNNING && u_propMode != AES_MODE_CLOSED)
  {
    // do this only when connection shall be established to all systems and single queries are needed
    if(b_remoteAllSingleQueries == 1)
    {
      DebugFTN("aesDist",__LINE__,__FUNCTION__,"connect new systems",gds_connectedSystems);
      aes_connectAllDistributedSystems();
    }
    else
    {
      DebugFTN("aesDist",__LINE__,__FUNCTION__,"connect new systems",gds_connectedSystems);
      aes_connectNewDistributedSystems();
    }
  }
}

aes_checkDistSystems(string s_dpH1, dyn_int di_systemsH1,
                     string s_dpConnH1, dyn_string ds_connH1)
{
  string s_propDp;
  unsigned u_runMode, u_propMode;
  dyn_string ds_connectedSystems;

  string s_ownSystem;
  
  // check if the dist manager is already running
  if(dynlen(ds_connH1) > 0)
  {
    // set the global variable with the list of connected systems
    aes_getSystemNames(di_systemsH1,ds_connectedSystems);
  }

  gds_connectedSystems = ds_connectedSystems;
  
  // always the own system needs to be added if it is not part of the systems list
  s_ownSystem = getSystemName();
  strreplace(s_ownSystem,":","");
         
  if(!dynContains(gds_connectedSystems,s_ownSystem))
    dynAppend(gds_connectedSystems,s_ownSystem);

  aes_getPropDpName4TabType(g_tabType,s_propDp);
  aes_getRunMode(s_propDp,u_runMode);
  aes_getPropMode(s_propDp,u_propMode);

  DebugFTN("aesDist",__LINE__,__FUNCTION__,"connected systems",gds_connectedSystems,s_propDp,u_runMode,b_remoteAllSingleQueries);
  
  // if the AEScreen is already running call the function to connect to new systems
  if(u_runMode == AES_RUNMODE_RUNNING && u_propMode != AES_MODE_CLOSED)
  {
    // check if all systems shall be connected
    if(gb_showAllSystems == 1)
    {
      // do this only when connection shall be established to all systems and single queries are needed
      if(b_remoteAllSingleQueries == 1)
      {
        DebugFTN("aesDist",__LINE__,__FUNCTION__,"connect new systems",gds_connectedSystems);
        aes_connectAllDistributedSystems();
      }
      // add new systems to the list of connected systems
      else
      {
        dyn_string ds_newSystems;
        
        ds_newSystems = gds_connectedSystems;
        dynAppend(gds_queryConnectedSystems,ds_newSystems);
        dynUnique(gds_queryConnectedSystems);
        
        // refresh the information for connected distributed systems
        aes_createDistInfo();
      }
    }
    else
    {
      DebugFTN("aesDist",__LINE__,__FUNCTION__,"connect new systems",gds_connectedSystems);
      aes_connectNewDistributedSystems();
    }
  }
}

aes_getSystemNames(dyn_int di_systemNums,dyn_string &ds_systemNames)
{
  int i;
  
  if(dynlen(di_systemNums) > 0)
  {
    for(i=1;i<=dynlen(di_systemNums);i++)
    {
      ds_systemNames[i]=getSystemName(di_systemNums[i]);
      strreplace(ds_systemNames[i],":","");
    }
  }
}

aes_connectAllDistributedSystems()
{
  int i_loopSystems;
  string s_ownSystem;
  dyn_string ds_systemsToConnect;
  
  // variables for the AES settings
  int screenType;
  int valType;
  dyn_string dsAttr;
  string from;
  string c_where;
  dyn_string valSystemSelections;
  bool valCheckAllSystems;
  bool valTypeAlertSummary;
  
  dyn_string ds_valDpList;
  bool b_showAllSystems;

  DebugFTN("aesDist",__LINE__,__FUNCTION__,gds_connectedSystems,gds_queryConnectedSystems);

  // always the own system needs to be added if it is not part of the systems list
  s_ownSystem = getSystemName();
  strreplace(s_ownSystem,":","");
         
  if(!dynContains(gds_connectedSystems,s_ownSystem))
    dynAppend(gds_connectedSystems,s_ownSystem);

  for(i_loopSystems=1;i_loopSystems<=dynlen(gds_connectedSystems);i_loopSystems++)
  {
    if(!dynContains(gds_queryConnectedSystems,gds_connectedSystems[i_loopSystems]))
    {
      dynAppend(ds_systemsToConnect,gds_connectedSystems[i_loopSystems]);
    }
  }
         
  DebugFTN("aesDist",__LINE__,__FUNCTION__,"systems to connect",ds_systemsToConnect);

  screenType = da_screenSettings[1];
  valType = da_screenSettings[2];
  dsAttr = da_screenSettings[3];
  
  // IM 118465 - the from STATEMENT needs to be resolved again if new identifications are known
  ds_valDpList = gds_valDpList;
  b_showAllSystems = gb_showAllSystems;

  DebugFTN("aesDist",__LINE__,__FUNCTION__,"call aes_getQueryGroupClause",ds_valDpList,gds_valSystemSelections,b_showAllSystems);
  from=aes_getQueryGroupClause(ds_valDpList,gds_valSystemSelections,b_showAllSystems);
  DebugFTN("aesDist",__LINE__,__FUNCTION__,"result of call aes_getQueryGroupClause",from);
  
  c_where = da_screenSettings[5];
  valSystemSelections = ds_systemsToConnect;
  valCheckAllSystems = 0;
  valTypeAlertSummary = da_screenSettings[8];
  
  aes_doQueryConnect(screenType,valType,dsAttr,from,c_where,ds_systemsToConnect,valCheckAllSystems,valTypeAlertSummary);
}

aes_connectNewDistributedSystems()
{
  int i_loopSystems;
  string s_ownSystem;
  dyn_string ds_systemsToConnect;
  
  // variables for the AES settings
  int screenType;
  int valType;
  dyn_string dsAttr;
  string from;
  string c_where;
  dyn_string valSystemSelections;
  bool valCheckAllSystems;
  bool valTypeAlertSummary;

  dyn_string ds_valDpList;
  bool b_showAllSystems;

  DebugFTN("aesDist",__LINE__,__FUNCTION__,gds_connectedSystems,gds_queryConnectedSystems,gds_valSystemSelections);

  // always the own system needs to be added if it is not part of the systems list
  s_ownSystem = getSystemName();
  strreplace(s_ownSystem,":","");
         
  if(!dynContains(gds_connectedSystems,s_ownSystem))
    dynAppend(gds_connectedSystems,s_ownSystem);

  for(i_loopSystems=1;i_loopSystems<=dynlen(gds_connectedSystems);i_loopSystems++)
  {
    // check if the system was selected in the configuration of systems to be displayed
    if(dynContains(gds_valSystemSelections,gds_connectedSystems[i_loopSystems]))
    {
      // check if the connect was already made
      if(!dynContains(gds_queryConnectedSystems,gds_connectedSystems[i_loopSystems]))
      {
        dynAppend(ds_systemsToConnect,gds_connectedSystems[i_loopSystems]);
      }
    }
  }
         
  DebugFTN("aesDist",__LINE__,__FUNCTION__,"systems to connect",ds_systemsToConnect);

  screenType = da_screenSettings[1];
  valType = da_screenSettings[2];
  dsAttr = da_screenSettings[3];

  // IM 118465 - the from STATEMENT needs to be resolved again if new identifications are known
  ds_valDpList = gds_valDpList;
  b_showAllSystems = gb_showAllSystems;

  DebugFTN("aesDist",__LINE__,__FUNCTION__,"call aes_getQueryGroupClause",ds_valDpList,gds_valSystemSelections,b_showAllSystems);
  from=aes_getQueryGroupClause(ds_valDpList,gds_valSystemSelections,b_showAllSystems);
  DebugFTN("aesDist",__LINE__,__FUNCTION__,"result of call aes_getQueryGroupClause",from);

  c_where = da_screenSettings[5];
  valSystemSelections = ds_systemsToConnect;
  valCheckAllSystems = 0;
  valTypeAlertSummary = da_screenSettings[8];
  
  aes_doQueryConnect(screenType,valType,dsAttr,from,c_where,ds_systemsToConnect,valCheckAllSystems,valTypeAlertSummary);
}
