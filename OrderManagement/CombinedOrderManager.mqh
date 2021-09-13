#ifndef COMBINED_ORDER_MANAGER_H
#define COMBINED_ORDER_MANAGER_H

#include <Generic\SortedSet.mqh>

#include "../Wrapper/MqlTradeRequestWrapper.mqh"

class CombinedOrderManager
{
public:
   //--- Destructor
   ~CombinedOrderManager(void);
   
   //--- Get Singleton Instance
   static CombinedOrderManager* GetInstance(void);
   
private:
   //--- Single Instance
   static CombinedOrderManager* Instance;
   
   // Main Constructor --- Singleton
   CombinedOrderManager(void);
};

CombinedOrderManager* CombinedOrderManager::Instance = NULL;

#endif