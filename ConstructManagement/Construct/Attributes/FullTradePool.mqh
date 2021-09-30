#ifndef CONSTRUCT_FULL_TRADE_POOL_H
#define CONSTRUCT_FULL_TRADE_POOL_H

#include <Generic\ArrayList.mqh>
#include <Generic\HashMap.mqh>

#include "../../../Wrapper/MqlTradeRequestWrapper.mqh"
#include "CompletionBoundary.mqh"
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
   void AddOneTimeRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request);
   void AddRecurrentRequest(ExecutionBoundary *InputExecutionBoundary, MqlTradeRequestWrapper *Request, CompletionBoundary *InputCompletionBoundary);
   void AddRecurrentRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request); //--- TODO: Move To Private
   
   CArrayList<MqlTradeRequestWrapper*> *GetOneTimeRequest(const double ExecutionPrice);
   CArrayList<MqlTradeRequestWrapper*> *GetRecurrentRequest(const double ExecutionPrice);

private:
   CHashMap<ExecutionBoundary* , CArrayList<MqlTradeRequestWrapper*>*> OneTimeTradePool;
   CHashMap<ExecutionBoundary* , CArrayList<MqlTradeRequestWrapper*>*> RecurrentTradePool;
   CHashMap<CompletionBoundary*, CArrayList<MqlTradeRequestWrapper*>*> RecurrentTradePoolBoomerang; 
   
   //--- Helper Functions: AddOneTimeRequest
   void AddExistedBoundaryOneTimeRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request);
   void AddNewBoundaryOneTimeRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request);
   
   //--- Helper Functions: AddRecurrentRequest
   void AddExistedExecutionBoundaryRecurrentRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request);
   void AddNewExecutionBoundaryRecurrentRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request);
   void AddExistedCompletionBoundaryRecurrentRequest(CompletionBoundary *InputBoundary, MqlTradeRequestWrapper *Request);
   void AddNewCompletionBoundaryRecurrentRequest(CompletionBoundary *InputBoundary, MqlTradeRequestWrapper *Request);
   
   //--- Auxilary Functions
   bool IsInExecutionZone(ExecutionBoundary *InputBoundary, const double ExecutionBoundary);
   void TransferRequest(CArrayList<MqlTradeRequestWrapper*> *From, CArrayList<MqlTradeRequestWrapper*> *To);
};

#endif