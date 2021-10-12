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

   //--- Clear All Master Inventory
   void Clear(void);
   
   //--- Get Singleton Instance
   static MasterInventory *GetInstance(void);
   
   //--- Add New Construct To The Master Inventory
   void Add(Construct *InputConstruct);
   
   //--- Retrieve Construct With The Corresponding Key
   Construct *RetrieveConstruct(ConstructKey *InputKey);

private:
   //--- Main Constructor --- Singleton
   MasterInventory(void);
   
   //--- Singleton Instance
   static MasterInventory* Instance;
   
   //--- Map From The Entry Position ID To The Right Inventory
   CHashMap<int, Inventory*> *ConstructMasterInventory;
   
   //--- Helper Functions: Add
   void CheckAndHandleNewEntryPositionID(Construct *InputConstruct);
   void LocateInventoryAndAddConstruct(Construct *InputConstruct);
};

MasterInventory* MasterInventory::Instance = NULL;

#endif