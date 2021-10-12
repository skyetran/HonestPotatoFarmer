#property strict

#include "../../ConstructManagement/Warehouse/MasterInventory.mqh"

//--- Main Constructor --- Singleton
MasterInventory::MasterInventory(void) {
   ConstructMasterInventory = new CHashMap<int, Inventory*>();
}

//--- Destructor
MasterInventory::~MasterInventory(void) {
   Clear();
   delete ConstructMasterInventory;
}

//--- Clear All Master Inventory
void MasterInventory::Clear(void) {
   int        EntryPositionIDs[];
   Inventory *Inventories[];
   ConstructMasterInventory.CopyTo(EntryPositionIDs, Inventories);
   
   for (int i = 0; i < ArraySize(Inventories); i++) {
      delete Inventories[i];
   }
}

//--- Get Singleton Instance
MasterInventory* MasterInventory::GetInstance(void) {
   if (!Instance) {
      Instance = new MasterInventory();
   }
   return Instance;
}

//--- Add New Construct To The Master Inventory
void MasterInventory::Add(Construct *InputConstruct) {
   CheckAndHandleNewEntryPositionID(InputConstruct);
   LocateInventoryAndAddConstruct(InputConstruct);
}

//--- Helper Functions: Add
void MasterInventory::CheckAndHandleNewEntryPositionID(Construct *InputConstruct) {
   int EntryPositionID = InputConstruct.GetEntryPositionID();
   if (!ConstructMasterInventory.ContainsKey(EntryPositionID)) {
      Inventory *NewConstructInventory = new Inventory(EntryPositionID);
      ConstructMasterInventory.Add(EntryPositionID, NewConstructInventory);
   }
}

//--- Helper Functions: Add
void MasterInventory::LocateInventoryAndAddConstruct(Construct *InputConstruct) {
   Inventory *ConstructInventory;
   ConstructMasterInventory.TryGetValue(InputConstruct.GetEntryPositionID(), ConstructInventory);
   ConstructInventory.Add(InputConstruct);
}

//--- Retrieve Construct With The Corresponding Key
Construct *MasterInventory::RetrieveConstruct(ConstructKey *InputKey) {
   if (ConstructMasterInventory.ContainsKey(InputKey.GetEntryPositionID())) {
      Inventory *ConstructInventory;
      ConstructMasterInventory.TryGetValue(InputKey.GetEntryPositionID(), ConstructInventory);
      return ConstructInventory.RetrieveConstruct(InputKey.GetConstructType(), InputKey.GetConstructParameters());
   }
   return NULL;
}