#ifndef MASTER_INVENTORY_H
#define MASTER_INVENTORY_H

#include <Generic\HashMap.mqh>

#include "../Construct/Construct.mqh"
#include "Inventory.mqh"

class MasterInventory
{
public:   
   //--- Main Constructor
   MasterInventory(void);
   
   //--- Destructor
   ~MasterInventory(void);

   //--- Clear All Master Inventory
   void Clear(void);
   
   //--- Add New Construct To The Master Inventory
   void Add(Construct *InputConstruct);
   
   //--- Retrieve Construct With The Corresponding Key
   Construct *RetrieveConstruct(ConstructKey *InputKey);

private:
   //--- Map From The Entry Position ID To The Right Inventory
   CHashMap<int, Inventory*> *ConstructMasterInventory;
   
   //--- Helper Functions: Add
   void CheckAndHandleNewEntryPositionID(Construct *InputConstruct);
   void LocateInventoryAndAddConstruct(Construct *InputConstruct);
};

#endif