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
   Inventory(int EntryPositionID);
   
   //--- Destructor
   ~Inventory(void);
   
   //--- Add New Construct To The Inventory
   void Add(Construct *NewConstruct);
   
   //--- Retrieve Construct With The Corresponding Type
   Construct *RetrieveConstruct(ConstructType *Type);
   
   //--- Retrieve Construct Multiplier With The Corresponding Type
   int RetrieveMultiplier(ConstructType *Type);
   
   //--- Clear All Inventory
   void Clear(void);
   
private:
   //--- Map The Construct Type To The Corresponding Container
   CHashMap<ConstructType*, Container*> ConstructInventory;
   
   //--- Inventory Attributes
   int InventoryType;
};

#endif