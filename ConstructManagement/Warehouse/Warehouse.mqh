#ifndef WAREHOUSE_H
#define WAREHOUSE_H

#include "MasterInventory.mqh"
#include "../../MarketWatcher.mqh"

class Warehouse
{
public:
   //--- Destructor
   ~Warehouse(void);
   
   //--- Get Singleton Instance
   static Warehouse *GetInstance(void);
   
   //--- OnTick
   void Update(void);
   
   //--- Operations
   void AddConstructToCurrentMarketState(Construct *InputConstruct);
   Construct *RetrieveConstructOfCurrentMarketState(ConstructKey *InputKey);
   void ClearCurrentMarketState(void);
   
   Construct *RetrieveConstructOfLastMarketState(ConstructKey *InputKey);
   void ClearLastMarketState(void);
   
   Construct *RetrieveConstructOfLastLastMarketState(ConstructKey *InputKey);
   void ClearLastLastMarketState(void);
   
private:
   //--- Master Inventory Entities
   MasterInventory *CounterTrendBearishMasterInventory;
   MasterInventory *CounterTrendBullishMasterInventory;
   MasterInventory *RangingMasterInventory;
   MasterInventory *WithTrendBearishMasterInventory;
   MasterInventory *WithTrendBullishMasterInventory;
   
   MasterInventory *LastLastMasterInventory;
   MasterInventory *LastMasterInventory;
   MasterInventory *CurrentMasterInventory;
   
   string LastLastStateName;
   string LastStateName;
   string CurrentStateName;
   
   //--- Singleton Instance
   static Warehouse *Instance;
   
   //--- Main Constructor --- Singleton
   Warehouse(void);
   
   //--- Helper Functions: Update
   void UpdateStateNameOrder(void);
   void UpdateMasterInventoryOrder(void);
   
   //--- Helper Functinos: UpdateMasterInventoryOrder
   void UpdateLastLastMasterInventory(void);
   void UpdateLastMasterInventory(void);
   void UpdateCurrentMasterInventory(void);
   void SetMasterInventoryPointer(MasterInventory *InputMasterInventoryPointer, string InputStateName);
};

Warehouse *Warehouse::Instance = NULL;

#endif