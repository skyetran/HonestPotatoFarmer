#property strict

#include "../OrderManagement/OrderManager.mqh"

//--- Main Constructor
OrderManager::OrderManager(void) {
   IP   = IndicatorProcessor::GetInstance();
   PMHP = PositionManagementHyperParameters::GetInstance(); 
   GS   = GeneralSettings::GetInstance();
   
   TradePoolList = new CArrayList<ConstructTradePool*>();
   CombinedTradeRequestNav = new CHashMap<MqlTradeRequestWrapper*, CArrayList<ConstructTradePool*>*>();
   CombinedTradeRequestVol = new CHashMap<MqlTradeRequestWrapper*, CArrayList<double>*>();
}