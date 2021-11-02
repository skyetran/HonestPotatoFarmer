#property strict

#include "../../ConstructManagement/Warehouse/Warehouse.mqh"

//--- Main Constructor --- Singleton
Warehouse::Warehouse(void) {
   CounterTrendBearishMasterInventory = new MasterInventory();
   CounterTrendBullishMasterInventory = new MasterInventory();
   RangingMasterInventory             = new MasterInventory();
   WithTrendBearishMasterInventory    = new MasterInventory();
   WithTrendBullishMasterInventory    = new MasterInventory();
   
   LastLastMasterInventory            = RangingMasterInventory;
   LastMasterInventory                = RangingMasterInventory;
   CurrentMasterInventory             = RangingMasterInventory;
   
   LastLastStateName                  = "Ranging";
   LastStateName                      = "Ranging";
   CurrentStateName                   = "Ranging";
}

//--- Destructor
Warehouse::~Warehouse(void) {
   delete CounterTrendBearishMasterInventory;
   delete CounterTrendBullishMasterInventory;
   delete RangingMasterInventory;
   delete WithTrendBearishMasterInventory;
   delete WithTrendBullishMasterInventory;
}

//--- Get Singleton Instance
Warehouse* Warehouse::GetInstance(void) {
   if (!Instance) {
      Instance = new Warehouse();
   }
   return Instance;
}

//--- OnTick Functions
void Warehouse::Update(void) {
   if (CurrentStateName != MW.GetStateName()) {
      UpdateStateNameOrder();
      UpdateMasterInventoryOrder();
   } 
}

//--- Helper Functions: Update
void Warehouse::UpdateStateNameOrder(void) {
   LastLastStateName = LastStateName;
   LastStateName     = CurrentStateName;
   CurrentStateName  = MW.GetStateName();
}

//--- Helper Functions: Update
void Warehouse::UpdateMasterInventoryOrder(void) {
   UpdateLastLastMasterInventory();
   UpdateLastMasterInventory();
   UpdateCurrentMasterInventory();   
}

//--- Helper Functions: UpdateMasterInventoryOrder
void Warehouse::UpdateLastLastMasterInventory(void) {
   SetMasterInventoryPointer(LastLastMasterInventory, LastLastStateName);
}

//--- Helper Functions: UpdateMasterInventoryOrder
void Warehouse::UpdateLastMasterInventory(void) {
   SetMasterInventoryPointer(LastMasterInventory, LastStateName);
}

//--- Helper Functions: UpdateMasterInventoryOrder
void Warehouse::UpdateCurrentMasterInventory(void) {
   SetMasterInventoryPointer(CurrentMasterInventory, CurrentStateName);
}

//--- Helper Functions: UpdateMasterInventoryOrder
void Warehouse::SetMasterInventoryPointer(MasterInventory *InputMasterInventoryPointer, string InputStateName) {
   if (InputStateName == "Counter-Trend Bearish") {
      InputMasterInventoryPointer = CounterTrendBearishMasterInventory;
   } else if (InputStateName == "Counter-Trend Bullish") {
      InputMasterInventoryPointer = CounterTrendBullishMasterInventory;
   } else if (InputStateName == "Ranging") {
      InputMasterInventoryPointer = RangingMasterInventory;
   } else if (InputStateName == "With-Trend Bearish") {
      InputMasterInventoryPointer = WithTrendBearishMasterInventory;
   } else if (InputStateName == "With-Trend Bullish") {
      InputMasterInventoryPointer = WithTrendBullishMasterInventory;
   }
}

//--- Operations
void Warehouse::AddConstructToCurrentMarketState(Construct *InputConstruct) {
   CurrentMasterInventory.Add(InputConstruct);
}

//--- Operations
Construct *Warehouse::RetrieveConstructOfCurrentMarketState(ConstructKey *InputKey) {
   return CurrentMasterInventory.RetrieveConstruct(InputKey);
}

//--- Operations
void Warehouse::ClearCurrentMarketState(void) {
   CurrentMasterInventory.Clear();
}

//--- Operations
Construct *Warehouse::RetrieveConstructOfLastMarketState(ConstructKey *InputKey) {
   return LastMasterInventory.RetrieveConstruct(InputKey);
}

//--- Operations
void Warehouse::ClearLastMarketState(void) {
   LastMasterInventory.Clear();
}

//--- Operations
Construct *Warehouse::RetrieveConstructOfLastLastMarketState(ConstructKey *InputKey) {
   return LastLastMasterInventory.RetrieveConstruct(InputKey);
}

//--- Operations
void Warehouse::ClearLastLastMarketState(void) {
   LastLastMasterInventory.Clear();
}