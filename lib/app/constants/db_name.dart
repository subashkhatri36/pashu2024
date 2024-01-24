class Dbname {
  static const List<String> tableNameList = [
    SETTING_Table_CREATE,
    MEDICINE_Table_CREATE,
    LABOR_Table_CREATE,
    CHALLRECORD_TABLE_CREATE,
    Bhush_TABLE_CREATE,
    ChallDead_TABLE_CREATE,
    ChickenSelling_TABLE_CREATE,
    DANACONSUMPTION_TABLE_CREATE,
    DANA_TABLE_CREATE,
    Ele_Table_CREATE,
    OTHER_Table_CREATE,
    Egg_Table_CREATE,
    MOL_Table_CREATE,
    Note_Table_CREATE,
    Balance_TABLE_CREATE,
  ];

  static const List<String> deletetableList = [
    Bhush_TABLE,
    ChallDEAD_TABLE,
    ChickenSelling_TABLE,
    DANACONSUMPTION_TABLE,
    DANA_TABLE,
    LABOR_TABLE,
    MEDICINE_TABLE,   
    Ele_TABLE,
    Other_TABLE,
    Egg_TABLE,
    Mol_TABLE,
  ];

//List of Tables
  // static const String USER_TABLE = 'User';
  // static const String USERDETAIL_TABLE = 'UserDetail';
  static const String CHALLRECORD_TABLE = 'ChallRecord';
  static const String Bhush_TABLE = 'Bhush';
  static const String ChallDEAD_TABLE = 'ChallDead';
  static const String ChickenSelling_TABLE = 'ChickenSelling';
  static const String DANACONSUMPTION_TABLE = 'DanaConsumption';
  static const String DANA_TABLE = 'Dana';
  static const String LABOR_TABLE = 'Labor';
  static const String MEDICINE_TABLE = 'Medicine';
  // static const String PaymentHistory_TABLE = 'Payment';
  
  static const String Ele_TABLE = 'Electricity';
  static const String Other_TABLE = 'Other';
  static const String Egg_TABLE = 'Egg';
  static const String Mol_TABLE = 'Mol';
  static const String Note_TABLE = 'Notes';

  static const String SETTING_TABLE = 'Settings';
  static const String Balance_TABLE = 'Balance';

  //List of Tables

  //Columns
  //common
  static const String Id = 'id';
  static const String Title = 'title';
  static const String DateJoined = 'date_joined';
  static const String UserId = 'userid';
  static const String BillNo = 'billno';
  static const String Qty = 'qty';
  static const String Rate = 'rate';
  static const String Remark = 'remarks';
  // static const String Finished = 'finished';
  static const String Egg = 'eggs';
  static const String Total = 'total';
  static const String EnterDate = 'enterdate';
  static const String ChallId = 'challid';
  static const String Price = 'price';
  static const String Piece = 'piece';
  static const String Kg = 'kg';
  static const String Travel = 'travel';
  static const String Dana = 'dana';
  static const String Dreturn = 'dreturn';
  static const String Todate = 'todate';
  static const String Fromdate = 'fromdate';
  static const String PaymentStatus = 'paymentstatus';
  static const String Sellid = 'sellid';
  static const String Inout = 'inout';
  static const String Rent = 'rent';
  static const String Electricity = 'electricity';
  static const String Water = 'water';

//user details
  static const String PhoneNo = 'phoneno';
  static const String Address = 'address';
  static const String Photo = 'photo';
  static const String Payment = 'payment';

  static const String Categoryid = 'categoryid';

  //userInfo
  static const String Email = 'email';
  static const String Username = 'username';
  static const String Active = 'is_active';
  static const String Passwod = 'password';
  static const String LastLogin = 'last_login';

//settings
  static const String NepaliDate = 'datetypeNepali';
  static const String Language = 'languageNepali';
  static const String ThemeChange = 'themelight';
  static const String AutoBackup = 'autobackup';

  static const String Note_Table_CREATE = """CREATE TABLE $Note_TABLE (
            $Id INTEGER PRIMARY KEY,    
             $Title TEXT,       
            $Remark TEXT,        
           $EnterDate DATETIME      
          )""";

           static const String Balance_TABLE_CREATE = """CREATE TABLE $Balance_TABLE (
            $Id INTEGER PRIMARY KEY,    
             $Total INTEGER,       
            $Remark TEXT,        
           $EnterDate DATETIME      
          )""";

  static const String MOL_Table_CREATE = """CREATE TABLE $Mol_TABLE (
          $Id INTEGER PRIMARY KEY,    
             $ChallId INTEGER,       
              $Qty INTEGER,
              $Rate INTEGER,       
            $EnterDate DATETIME      
          )""";

  static const String Egg_Table_CREATE = """CREATE TABLE $Egg_TABLE (
          $Id INTEGER PRIMARY KEY,    
             $ChallId INTEGER,       
          $Qty INTEGER,
          $Rate INTEGER,       
            $EnterDate DATETIME      
          )""";

  static const String Ele_Table_CREATE = """CREATE TABLE $Ele_TABLE (
          $Id INTEGER PRIMARY KEY,    
             $ChallId INTEGER,       
          $Rent INTEGER,
          $Electricity INTEGER,
           $Water INTEGER,
            $EnterDate DATETIME      
          )""";

  static const String OTHER_Table_CREATE = """CREATE TABLE $Other_TABLE (
          $Id INTEGER PRIMARY KEY,
          $ChallId INTEGER,      
          $Total NUMERIC,
          $Remark TEXT,
           $Inout BOOLEAN,
          $EnterDate DATETIME      
          )""";

  static const String SETTING_Table_CREATE = """CREATE TABLE $SETTING_TABLE (
          $Id INTEGER PRIMARY KEY,       
          $NepaliDate BOOLEAN,
          $Language BOOLEAN,
           $ThemeChange BOOLEAN,
          $AutoBackup BOOLEAN
          )""";

  
  static const String MEDICINE_Table_CREATE = """CREATE TABLE $MEDICINE_TABLE (
          $Id INTEGER PRIMARY KEY,
          $ChallId INTEGER,      
          $Total NUMERIC,
          $Remark TEXT,
          $EnterDate DATETIME      
          )""";

  

  static const String LABOR_Table_CREATE = """CREATE TABLE $LABOR_TABLE (
          $Id INTEGER PRIMARY KEY,
          $ChallId INTEGER,
          $Total NUMERIC,
          $Remark TEXT,
          $EnterDate DATETIME      
          )""";


  static const String CHALLRECORD_TABLE_CREATE =
      """CREATE TABLE $CHALLRECORD_TABLE (
          $Id INTEGER PRIMARY KEY,
          $BillNo TEXT,       
          $Categoryid INTEGER,
          $Qty INTEGER,
          $Rate INTEGER,        
          $Egg BOOLEAN,
          $Total NUMERIC,
          $EnterDate DATETIME            
          )""";

  static const String Bhush_TABLE_CREATE = """CREATE TABLE $Bhush_TABLE (
          $Id INTEGER PRIMARY KEY,
          $ChallId INTEGER,         
          $Qty NUMERIC,
          $Rate NUMERIC,        
         
          $Remark TEXT,
          $EnterDate DATETIME            
          )""";

  static const String ChallDead_TABLE_CREATE =
      """CREATE TABLE $ChallDEAD_TABLE (
          $Id INTEGER PRIMARY KEY,
          $ChallId INTEGER,      
          $Qty NUMERIC,
          $Price NUMERIC,         
          $Remark TEXT,
          $EnterDate DATETIME            
          )""";

  static const String ChickenSelling_TABLE_CREATE =
      """CREATE TABLE $ChickenSelling_TABLE (
          $Id INTEGER PRIMARY KEY,
          $ChallId INTEGER,       
          $BillNo TEXT,  
          $Piece INTEGER,
          $Kg NUMERIC,  
          $Rate NUMERIC,  
          $Travel NUMERIC,   
          $Remark TEXT,
          $EnterDate DATETIME            
          )""";

  static const String DANACONSUMPTION_TABLE_CREATE =
      """CREATE TABLE $DANACONSUMPTION_TABLE (
          $Id INTEGER PRIMARY KEY,
            $ChallId INTEGER,       
          $Dana INTEGER,                 
          $Qty NUMERIC,           
          $EnterDate DATETIME            
          )""";

  static const String DANA_TABLE_CREATE = """CREATE TABLE $DANA_TABLE (
          $Id INTEGER PRIMARY KEY,
          $Dana TEXT,
          $ChallId INTEGER, 
          $BillNo TEXT,  
          $Qty INTEGER,        
          $Rate NUMERIC,         
          $Dreturn INTEGER,
          $EnterDate DATETIME            
          )""";

  //Columns
}
