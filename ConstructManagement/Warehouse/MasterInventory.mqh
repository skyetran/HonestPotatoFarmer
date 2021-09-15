#ifndef MASTER_INVENTORY_H
#define MASTER_INVENTORY_H

#include <Generic\HashMap.mqh>

#include "../Construct/Construct.mqh"
#include "Inventory.mqh"

class MasterInventory
{
public:   
   //--- Destructor
   ~MasterInventory(void);

   //--- Get Singleton Instance
   static MasterInventory *GetInstance(void);
   
   //--- Add New Construct To The Master Inventory
   void Insert(Construct *NewConstruct);
   
   //--- Retrieve Construct With The Corresponding Key
   Construct *RetrieveConstruct(ConstructKey *RetrievedKey);
   
   //--- Retrieve Construct Multiplier With The Corresponding Key
   int RetrieveMultiplier(ConstructKey *RetrieveKey);
   
   //--- Clear All Construct
   void Clear(void);

private:
   //--- Main Constructor --- Singleton
   MasterInventory(void);
   
   //--- Singleton Instance
   static MasterInventory* Instance;
   
   //--- Map From The Entry Position ID To The Right Inventory
   CHashMap<int, Inventory*> ConstructMasterInventory;
};

MasterInventory* MasterInventory::Instance = NULL;

#endif