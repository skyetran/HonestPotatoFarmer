#ifndef ORDER_MANAGER_H
#define ORDER_MANAGER_H

#include <Generic\ArrayList.mqh>
#include "Wrapper/MqlTradeRequestWrapper.mqh"

class OrderManager
{
public:
   //--- Destructor
   ~OrderManager(void);
   
   //--- Get Singleton Instance
   static OrderManager* GetInstance(void);
   
   void AddRequest(MqlTradeRequestWrapper* request);
   
   
private:
   //--- Single Instance
   static OrderManager* Instance;
   
   // Main Constructor --- Singleton
   OrderManager(void);
   
   CArrayList<MqlTradeRequestWrapper*> PendingOrdersList, SLTPOrdersList, ModifyOrdersList, RemoveOrdersList, CloseByOrdersList;
};

#endif