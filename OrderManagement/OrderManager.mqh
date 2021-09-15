#ifndef RAW_ORDER_MANAGER_H
#define RAW_ORDER_MANAGER_H

#include <Generic\ArrayList.mqh>

#include "CombinedTradeRequest.mqh"
#include "ConstructTradePool.mqh"

class OrderManager
{
public:
   //--- Main Constructor
   OrderManager(void);
   
   //--- Destructor
   ~OrderManager(void);
   
   //--- OnTick Function
   void Managing(void);
   
   //--- Add Trade Pool To Manage
   void AddTradePool(ConstructTradePool *InputTradePool);
   
   //--- Getters
   CArrayList<CombinedTradeRequest*> *GetMarketOrderRequestList(void);
   CArrayList<CombinedTradeRequest*> *GetPendingOrderRequestList(void);
   
   bool GetMergeTradePoolFlag(void) const;
   
   //--- Setter
   void SetMergeTradePoolFlag(bool InputFlag);
   void SetMarketOrderSendFlag(bool InputFlag);
   
private:
   bool MergeTradePoolFlag;
   bool MarketOrderSendFlag;
   
   //--- Subcribe To A List Of Trade Pools
   CArrayList<ConstructTradePool*> TradePoolList;
   
   //--- Final Request: Ready For Execution
   CArrayList<CombinedTradeRequest*> *MarketOrderList, *PendingOrderList;
   
   //--- Scan Over All Trade Pool And Create Combined Trade Request
   void CombineRequest(void);
   
   //--- Wait For Executer To Flag And Send Back Trade Result
   void SendResult(void);
};

#endif