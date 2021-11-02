#property strict

#include "../../ConstructManagement/Warehouse/Inventory.mqh"

//--- Default Constructor
Inventory::Inventory(void) { }

//--- Main Constructor
Inventory::Inventory(int InputEntryPositionID) {
   ConstructInventory = new CHashMap<ConstructType*, Container*>();
   InventoryType = InputEntryPositionID;
}

//--- Destructor
Inventory::~Inventory(void) {
   Clear();
   delete ConstructInventory;
}

//--- Clear All Inventory
void Inventory::Clear(void) {
   ConstructType *Types[];
   Container     *Containers[];
   ConstructInventory.CopyTo(Types, Containers);
   
   for (int i = 0; i < ArraySize(Types); i++) {
      delete Containers[i];
   }
}

//--- Add New Construct To The Inventory
void Inventory::Add(Construct *InputConstruct) {   
   CheckAndHandleNewConstructType(InputConstruct);
   LocateContainerAndAddConstruct(InputConstruct);
}

//--- Helper Functions: Add
void Inventory::CheckAndHandleNewConstructType(Construct *InputConstruct) {
   ConstructType *Type = InputConstruct.GetConstructType();
   if (!ConstructInventory.ContainsKey(Type)) {
      Container *NewConstructContainer = new Container(Type);
      ConstructInventory.Add(Type, NewConstructContainer);
   }
}

//--- Helper Functions: Add
void Inventory::LocateContainerAndAddConstruct(Construct *InputConstruct) {
   Container *ConstructContainer;
   ConstructInventory.TryGetValue(InputConstruct.GetConstructType(), ConstructContainer);
   ConstructContainer.Add(InputConstruct);
}

//--- Retrieve Construct With The Corresponding Type
Construct *Inventory::RetrieveConstruct(ConstructType *InputType, ConstructParameters *InputParameters) {
   if (ConstructInventory.ContainsKey(InputType)) {
      Container *ConstructContainer;
      ConstructInventory.TryGetValue(InputType, ConstructContainer);
      return ConstructContainer.RetrieveConstruct(InputParameters);
   }
   return NULL;
}