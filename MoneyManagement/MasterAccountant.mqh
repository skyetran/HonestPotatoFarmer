#ifndef MASTER_ACCOUNTANT_H
#define MASTER_ACCOUNTANT_H

#include <Generic\HashMap.mqh>

#include "../ConstructManagement/Construct/Construct.mqh"
#include "Accountant.mqh"

class MasterAccountant
{
public:
   //--- Destructor
   ~MasterAccountant(void);

   //--- Get Singleton Instance
   static MasterAccountant *GetInstance(void);
   
   //--- Log Trading Result
   void LogTradingResult(Construct *construct);
   
private:
   //--- Main Constructor --- Singleton
   MasterAccountant(void);
   
   //--- Singleton Instance
   static MasterAccountant* Instance;
   
   //--- Map From The Entry Position ID To The Right Accountant
   CHashMap<int, Accountant*> ConstructMasterInventory;
};

MasterAccountant* MasterAccountant::Instance = NULL;

#endif