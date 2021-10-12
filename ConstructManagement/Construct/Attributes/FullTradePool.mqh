#ifndef CONSTRUCT_FULL_TRADE_POOL_H
#define CONSTRUCT_FULL_TRADE_POOL_H

#include <Generic\ArrayList.mqh>
#include <Generic\HashMap.mqh>

#include "../../../General/GlobalConstants.mqh"
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
   
   //--- Operations: Create Objects
   void AddOneTimeRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request);
   void AddRecurrentRequest(ExecutionBoundary *InputExecutionBoundary, MqlTradeRequestWrapper *Request, CompletionBoundary *InputCompletionBoundary);
   
   //--- Operations: Monitoring
   CArrayList<MqlTradeRequestWrapper*> *GetRequest(const double CurrentPrice);
   void UpdateRecurrentTradeBoomerangStatus(const double CurrentPrice);

private:
   CHashMap<ExecutionBoundary* , CArrayList<MqlTradeRequestWrapper*>*> OneTimeTradePool;
   CHashMap<MqlTradeRequestWrapper*, bool>                             OneTimeTradeBoomerangStatus;
   CHashMap<ExecutionBoundary* , CArrayList<MqlTradeRequestWrapper*>*> RecurrentTradePool;
   CHashMap<CompletionBoundary*, CArrayList<MqlTradeRequestWrapper*>*> RecurrentTradePoolBoomerang; 
   CHashMap<MqlTradeRequestWrapper*, bool>                             RecurrentTradeBoomerangStatus;
   
   //--- Helper Functions: GetRequest
   void AddExistedBoundaryOneTimeRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request);
   void AddNewBoundaryOneTimeRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request);
   
   //--- Helper Functions: AddRecurrentRequest
   void AddRecurrentRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request);
   void AddExistedExecutionBoundaryRecurrentRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request);
   void AddNewExecutionBoundaryRecurrentRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request);
   void AddExistedCompletionBoundaryRecurrentRequest(CompletionBoundary *InputBoundary, MqlTradeRequestWrapper *Request);
   void AddNewCompletionBoundaryRecurrentRequest(CompletionBoundary *InputBoundary, MqlTradeRequestWrapper *Request);
   void AddRecurrentRequestBoomerang(CompletionBoundary *InputBoundary, MqlTradeRequestWrapper *Request);
   
   //--- Helper Functions: GetRequest
   CArrayList<MqlTradeRequestWrapper*> *GetOneTimeRequest(const double CurrentPrice);
   CArrayList<MqlTradeRequestWrapper*> *GetRecurrentRequest(const double CurrentPrice);
   
   //--- Helper Functions: GetOneTimeRequest
   void TransferOneTimeRequest(CArrayList<MqlTradeRequestWrapper*> *From, CArrayList<MqlTradeRequestWrapper*> *To);
   bool IsOneTimeBoomerangStatus(MqlTradeRequestWrapper *Request);
   void SetOneTimeBoomerangStatus(MqlTradeRequestWrapper *Request, const bool InputBoomerangStatus);
   
   //--- Helper Functions: GetRecurrentRequest
   void TransferRecurrentRequest(CArrayList<MqlTradeRequestWrapper*> *From, CArrayList<MqlTradeRequestWrapper*> *To);
   bool IsRecurrentBoomerangStatus(MqlTradeRequestWrapper *Request);
   void SetRecurrentBoomerangStatus(MqlTradeRequestWrapper *Request, const bool InputBoomerangStatus);
   
   //--- Helper Functions: UpdateRecurrentTradeBoomerangStatus
   bool IsInCompletionZone(CompletionBoundary *InputBoundary, const double InputPrice);
   void SetRecurrentBoomerangStatus(CArrayList<MqlTradeRequestWrapper*> *RequestList, const bool InputBoomerangStatus);
   
   //--- Auxilary Functions
   bool IsInExecutionZone(ExecutionBoundary *InputBoundary, const double InputPrice);
   
};

#endif