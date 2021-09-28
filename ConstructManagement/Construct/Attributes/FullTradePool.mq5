#property strict

#include "../../../ConstructManagement/Construct/Attributes/FullTradePool.mqh"

//--- Main Constructor
ConstructFullTradePool::ConstructFullTradePool(void) { }

//--- Destructor
ConstructFullTradePool::~ConstructFullTradePool(void) {
   OneTimeTradePool.Clear();
   RecurrentTradePool.Clear();
}

//--- Operations
void ConstructFullTradePool::AddOneTimeRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper* Request) {
   if (OneTimeTradePool.ContainsKey(InputBoundary)) {
      AddExistedBoundaryOneTimeRequest(InputBoundary, Request);
   } else {
      AddNewBoundaryOneTimeRequest(InputBoundary, Request);
   }
}

//--- Helper Functions: AddOneTimeRequest
void ConstructFullTradePool::AddExistedBoundaryOneTimeRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request) {
   CArrayList<MqlTradeRequestWrapper*> *RequestList = new CArrayList<MqlTradeRequestWrapper*>();
   OneTimeTradePool.TryGetValue(InputBoundary, RequestList);
   RequestList.Add(Request);
   OneTimeTradePool.Add(InputBoundary, RequestList);
}

//--- Helper Functios: AddOneTimeRequest
void ConstructFullTradePool::AddNewBoundaryOneTimeRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request) {
   CArrayList<MqlTradeRequestWrapper*> *RequestList = new CArrayList<MqlTradeRequestWrapper*>();
   RequestList.Add(Request);
   OneTimeTradePool.Add(InputBoundary, RequestList);
}

//--- Operations
void ConstructFullTradePool::AddRecurrentRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper* Request) {
   if (RecurrentTradePool.ContainsKey(InputBoundary)) {
      AddExistedBoundaryRecurrentRequest(InputBoundary, Request);
   } else {
      AddNewBoundaryRecurrentRequest(InputBoundary, Request);
   }
}

//--- Helper Functions: AddRecurrentRequest
void ConstructFullTradePool::AddExistedBoundaryRecurrentRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request) {
   CArrayList<MqlTradeRequestWrapper*> *RequestList = new CArrayList<MqlTradeRequestWrapper*>();
   RecurrentTradePool.TryGetValue(InputBoundary, RequestList);
   RequestList.Add(Request);
}

//--- Helper Functios: AddRecurrentRequest
void ConstructFullTradePool::AddNewBoundaryRecurrentRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request) {
   CArrayList<MqlTradeRequestWrapper*> *RequestList = new CArrayList<MqlTradeRequestWrapper*>();
   RequestList.Add(Request);
   RecurrentTradePool.Add(InputBoundary, RequestList);
}

//--- Operations
CArrayList<MqlTradeRequestWrapper*> *ConstructFullTradePool::GetOneTimeRequest(const double ExecutionPrice) {
   CArrayList<MqlTradeRequestWrapper*> *ExecutingRequest = new CArrayList<MqlTradeRequestWrapper*>();
   
   ExecutionBoundary                    *BoundaryList[];
   CArrayList<MqlTradeRequestWrapper *> *RequestList[];
   OneTimeTradePool.CopyTo(BoundaryList, RequestList);
   
   for (int i = 0; i < ArraySize(BoundaryList); i++) {
      if (IsInExecutionZone(BoundaryList[i], ExecutionPrice)) {
         TransferRequest(RequestList[i], ExecutingRequest);
      }
   }
   return ExecutingRequest;
}

//--- Operations
CArrayList<MqlTradeRequestWrapper*> *ConstructFullTradePool::GetRecurrentRequest(const double ExecutionPrice) {
   CArrayList<MqlTradeRequestWrapper*> *ExecutingRequest = new CArrayList<MqlTradeRequestWrapper*>();
   
   ExecutionBoundary                    *BoundaryList[];
   CArrayList<MqlTradeRequestWrapper *> *RequestList[];
   RecurrentTradePool.CopyTo(BoundaryList, RequestList);
   
   for (int i = 0; i < ArraySize(BoundaryList); i++) {
      if (IsInExecutionZone(BoundaryList[i], ExecutionPrice)) {
         TransferRequest(RequestList[i], ExecutingRequest);
      }
   }
   return ExecutingRequest;
}

//--- Auxilary Function
bool ConstructFullTradePool::IsInExecutionZone(ExecutionBoundary *InputBoundary, const double ExecutionBoundary) {
   return InputBoundary.GetLowerBound() <= ExecutionBoundary && ExecutionBoundary <= InputBoundary.GetUpperBound();
}

//--- Auxilary Function
void ConstructFullTradePool::TransferRequest(CArrayList<MqlTradeRequestWrapper*> *From, CArrayList<MqlTradeRequestWrapper*> *To) {
   for (int i = 0; i < From.Count(); i++) {
      MqlTradeRequestWrapper *Request;
      From.TryGetValue(i, Request);
      To.Add(Request);
   }
}