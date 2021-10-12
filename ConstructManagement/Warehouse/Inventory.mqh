#ifndef INVENTORY_H
#define INVENTORY_H

#include <Generic\HashMap.mqh>

#include "../Construct/Construct.mqh"
#include "../Construct/Attributes/Type.mqh"
#include "Container.mqh"

class Inventory
{
public:
   //--- Default Constructor
   Inventory(void);
   
   //--- Main Constructor
   Inventory(int InputEntryPositionID);
   
   //--- Destructor
   ~Inventory(void);
   
   //--- Clear All Inventory
   void Clear(void);
   
   //--- Add New Construct To The Inventory
   void Add(Construct *InputConstruct);
   
   //--- Retrieve Construct With The Corresponding Type
   Construct *RetrieveConstruct(ConstructType *InputType, ConstructParameters *InputParameters);
   
private:
   //--- Map The Construct Type To The Corresponding Container
   CHashMap<ConstructType*, Container*> *ConstructInventory;
   
   //--- Inventory Attributes
   int InventoryType;
   
   //--- Helper Functions: Add
   void CheckAndHandleNewConstructType(Construct *InputConstruct);
   void LocateContainerAndAddConstruct(Construct *InputConstruct);
};

#endif