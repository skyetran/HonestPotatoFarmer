#ifndef CONSTRUCT_FULL_TRADE_POOL_H
#define CONSTRUCT_FULL_TRADE_POOL_H

#include <Generic\ArrayList.mqh>
#include <Generic\HashMap.mqh>

#include "../../../Wrapper/MqlTradeRequestWrapper.mqh"
#include "ExecutionBoundary.mqh"

//+------------------------------------------------------------------+
//| Trades That Are Executed If Execution Price Is Greater Than Or   |
//| Equal To The Current Price, Goes To The UpperTradePool           |
//+------------------------------------------------------------------+

class ConstructFullTradePool
{
public:
   //--- Main Constructor
   ConstructFullTradePool(void);
   
   //--- Destructor
   ~ConstructFullTradePool(void);
   
   //--- Operations
   void AddRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper* Request);
   CArrayList<MqlTradeRequestWrapper*> *GetRequest(const double ExecutionPrice);

private:
   CHashMap<ExecutionBoundary*, CArrayList<MqlTradeRequestWrapper*>*> TradePool;
   
   //--- Helper Functions: AddRequest
   void AddExistedBoundaryRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper* Request);
   void AddNewBoundaryRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper* Request);
   
   //--- Helper Functions: GetRequest
   bool IsInExecutionZone(ExecutionBoundary *InputBoundary, const double ExecutionBoundary);
   void TransferRequest(CArrayList<MqlTradeRequestWrapper*> *From, CArrayList<MqlTradeRequestWrapper*> *To);
};

#endif