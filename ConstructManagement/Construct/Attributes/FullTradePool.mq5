#property strict

#include "../../../ConstructManagement/Construct/Attributes/FullTradePool.mqh"

//--- Main Constructor
ConstructFullTradePool::ConstructFullTradePool(void) { }

//--- Destructor
ConstructFullTradePool::~ConstructFullTradePool(void) {
   TradePool.Clear();
}

//--- Operations
void ConstructFullTradePool::AddRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper* Request) {
   if (TradePool.ContainsKey(InputBoundary)) {
      AddExistedBoundaryRequest(InputBoundary, Request);
   } else {
      AddNewBoundaryRequest(InputBoundary, Request);
   }
}

//--- Helper Functions: AddRequest
void ConstructFullTradePool::AddExistedBoundaryRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request) {
   CArrayList<MqlTradeRequestWrapper*> *RequestList;
   TradePool.TryGetValue(InputBoundary, RequestList);
   RequestList.Add(Request);
}

//--- Helper Functios: AddRequest
void ConstructFullTradePool::AddNewBoundaryRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request) {
   CArrayList<MqlTradeRequestWrapper*> *RequestList = new CArrayList<MqlTradeRequestWrapper*>();
   RequestList.Add(Request);
   TradePool.Add(InputBoundary, RequestList);
}

//--- Operations
CArrayList<MqlTradeRequestWrapper*> *ConstructFullTradePool::GetRequest(const double ExecutionPrice) {
   CArrayList<MqlTradeRequestWrapper*> *ExecutingRequest = new CArrayList<MqlTradeRequestWrapper*>();
   
   ExecutionBoundary                    *BoundaryList[];
   CArrayList<MqlTradeRequestWrapper *> *RequestList[];
   TradePool.CopyTo(BoundaryList, RequestList);
   
   for (int i = 0; i < ArraySize(BoundaryList); i++) {
      if (IsInExecutionZone(BoundaryList[i], ExecutionPrice)) {
         TransferRequest(RequestList[i], ExecutingRequest);
      }
   }
   return ExecutingRequest;
}

//--- Helper Functions: GetRequest
bool ConstructFullTradePool::IsInExecutionZone(ExecutionBoundary *InputBoundary, const double ExecutionBoundary) {
   return InputBoundary.GetLowerBound() <= ExecutionBoundary && ExecutionBoundary <= InputBoundary.GetUpperBound();
}

//--- Helper Functions: GetRequest
void ConstructFullTradePool::TransferRequest(CArrayList<MqlTradeRequestWrapper*> *From, CArrayList<MqlTradeRequestWrapper*> *To) {
   for (int i = 0; i < From.Count(); i++) {
      MqlTradeRequestWrapper *Request;
      From.TryGetValue(i, Request);
      To.Add(Request);
   }
}