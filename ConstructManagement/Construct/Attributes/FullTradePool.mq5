#property strict

#include "../../../ConstructManagement/Construct/Attributes/FullTradePool.mqh"

//--- Main Constructor
ConstructFullTradePool::ConstructFullTradePool(void) { }

//--- Destructor
ConstructFullTradePool::~ConstructFullTradePool(void) {
   OneTimeTradePool.Clear();
   OneTimeTradeBoomerangStatus.Clear();
   RecurrentTradePool.Clear();
   RecurrentTradePoolBoomerang.Clear();
   RecurrentTradeBoomerangStatus.Clear();
}

//--- Operations: Create Objects
void ConstructFullTradePool::AddOneTimeRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper* Request) {
   if (OneTimeTradePool.ContainsKey(InputBoundary)) {
      AddExistedBoundaryOneTimeRequest(InputBoundary, Request);
   } else {
      AddNewBoundaryOneTimeRequest(InputBoundary, Request);
   }
   OneTimeTradeBoomerangStatus.Add(Request, BOOMERANG_ALLOWED);
}

//--- Helper Functions: AddOneTimeRequest
void ConstructFullTradePool::AddExistedBoundaryOneTimeRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request) {
   CArrayList<MqlTradeRequestWrapper*> *RequestList = new CArrayList<MqlTradeRequestWrapper*>();
   OneTimeTradePool.TryGetValue(InputBoundary, RequestList);
   RequestList.Add(Request);
   OneTimeTradePool.Add(InputBoundary, RequestList);
}

//--- Helper Functions: AddOneTimeRequest
void ConstructFullTradePool::AddNewBoundaryOneTimeRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request) {
   CArrayList<MqlTradeRequestWrapper*> *RequestList = new CArrayList<MqlTradeRequestWrapper*>();
   RequestList.Add(Request);
   OneTimeTradePool.Add(InputBoundary, RequestList);
}

//--- Operations: Create Objects
void ConstructFullTradePool::AddRecurrentRequest(ExecutionBoundary *InputExecutionBoundary, MqlTradeRequestWrapper *Request, CompletionBoundary *InputCompletionBoundary) {
   AddRecurrentRequest(InputExecutionBoundary, Request);
   AddRecurrentRequestBoomerang(InputCompletionBoundary, Request);
   RecurrentTradeBoomerangStatus.Add(Request, BOOMERANG_ALLOWED);
}

//--- Helper Functions: AddRecurrentRequest
void ConstructFullTradePool::AddRecurrentRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper* Request) {
   if (RecurrentTradePool.ContainsKey(InputBoundary)) {
      AddExistedExecutionBoundaryRecurrentRequest(InputBoundary, Request);
   } else {
      AddNewExecutionBoundaryRecurrentRequest(InputBoundary, Request);
   }
}

//--- Helper Functions: AddRecurrentRequest
void ConstructFullTradePool::AddExistedExecutionBoundaryRecurrentRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request) {
   CArrayList<MqlTradeRequestWrapper*> *RequestList = new CArrayList<MqlTradeRequestWrapper*>();
   RecurrentTradePool.TryGetValue(InputBoundary, RequestList);
   RequestList.Add(Request);
   RecurrentTradePool.Add(InputBoundary, RequestList);
}

//--- Helper Functions: AddRecurrentRequest
void ConstructFullTradePool::AddNewExecutionBoundaryRecurrentRequest(ExecutionBoundary *InputBoundary, MqlTradeRequestWrapper *Request) {
   CArrayList<MqlTradeRequestWrapper*> *RequestList = new CArrayList<MqlTradeRequestWrapper*>();
   RequestList.Add(Request);
   RecurrentTradePool.Add(InputBoundary, RequestList);
}

//--- Helper Functions: AddRecurrentRequest
void ConstructFullTradePool::AddRecurrentRequestBoomerang(CompletionBoundary *InputBoundary, MqlTradeRequestWrapper *Request) {
   if (RecurrentTradePoolBoomerang.ContainsKey(InputBoundary)) {
      AddExistedCompletionBoundaryRecurrentRequest(InputBoundary, Request);
   } else {
      AddNewCompletionBoundaryRecurrentRequest(InputBoundary, Request);
   }
}

//--- Helper Functions: AddRecurrentRequestBoomerang
void ConstructFullTradePool::AddExistedCompletionBoundaryRecurrentRequest(CompletionBoundary *InputBoundary, MqlTradeRequestWrapper *Request) {
   CArrayList<MqlTradeRequestWrapper*> *RequestList = new CArrayList<MqlTradeRequestWrapper*>();
   RecurrentTradePoolBoomerang.TryGetValue(InputBoundary, RequestList);
   RequestList.Add(Request);
   RecurrentTradePoolBoomerang.Add(InputBoundary, RequestList);
}

//--- Helper Functions: AddRecurrentRequestBoomerang
void ConstructFullTradePool::AddNewCompletionBoundaryRecurrentRequest(CompletionBoundary *InputBoundary, MqlTradeRequestWrapper *Request) {
   CArrayList<MqlTradeRequestWrapper*> *RequestList = new CArrayList<MqlTradeRequestWrapper*>();
   RequestList.Add(Request);
   RecurrentTradePoolBoomerang.Add(InputBoundary, RequestList);
}

//--- Operations: Monitoring
CArrayList<MqlTradeRequestWrapper*> *ConstructFullTradePool::GetOneTimeRequest(const double ExecutionPrice) {
   CArrayList<MqlTradeRequestWrapper*> *ExecutingRequest = new CArrayList<MqlTradeRequestWrapper*>();
   
   ExecutionBoundary                   *BoundaryList[];
   CArrayList<MqlTradeRequestWrapper*> *RequestList[];
   OneTimeTradePool.CopyTo(BoundaryList, RequestList);
   
   for (int i = 0; i < ArraySize(BoundaryList); i++) {
      if (IsInExecutionZone(BoundaryList[i], ExecutionPrice)) {
         TransferOneTimeRequest(RequestList[i], ExecutingRequest);
      }
   }
   return ExecutingRequest;
}

//--- Helper Functions: GetOneTimeRequest
void ConstructFullTradePool::TransferOneTimeRequest(CArrayList<MqlTradeRequestWrapper*> *From, CArrayList<MqlTradeRequestWrapper*> *To) {
   for (int i = 0; i < From.Count(); i++) {
      MqlTradeRequestWrapper *Request;
      From.TryGetValue(i, Request);
      if (IsOneTimeBoomerangStatus(Request)) {
         To.Add(Request);
         SetOneTimeBoomerangStatus(Request, BOOMERANG_NOT_ALLOWED);
      }
   }
}

//--- Helper Functions: TransferOneTimeRequest
bool ConstructFullTradePool::IsOneTimeBoomerangStatus(MqlTradeRequestWrapper *Request) {
   bool BoomerangStatus = false;
   OneTimeTradeBoomerangStatus.TryGetValue(Request, BoomerangStatus);
   return BoomerangStatus;
}

//--- Helper Functions: TransferOneTimeRequest
void ConstructFullTradePool::SetOneTimeBoomerangStatus(MqlTradeRequestWrapper *Request, const bool InputBoomerangStatus) {
   bool BoomerangStatus = false;
   OneTimeTradeBoomerangStatus.TryGetValue(Request, BoomerangStatus);
   BoomerangStatus = InputBoomerangStatus;
   OneTimeTradeBoomerangStatus.Add(Request, BoomerangStatus);
}

//--- Operations: Monitoring
CArrayList<MqlTradeRequestWrapper*> *ConstructFullTradePool::GetRecurrentRequest(const double ExecutionPrice) {
   CArrayList<MqlTradeRequestWrapper*> *ExecutingRequest = new CArrayList<MqlTradeRequestWrapper*>();
   
   ExecutionBoundary                    *BoundaryList[];
   CArrayList<MqlTradeRequestWrapper *> *RequestList[];
   RecurrentTradePool.CopyTo(BoundaryList, RequestList);
   
   for (int i = 0; i < ArraySize(BoundaryList); i++) {
      if (IsInExecutionZone(BoundaryList[i], ExecutionPrice)) {
         TransferRecurrentRequest(RequestList[i], ExecutingRequest);
      }
   }
   return ExecutingRequest;
}

//--- Helper Functions: GetRecurrentRequest
void ConstructFullTradePool::TransferRecurrentRequest(CArrayList<MqlTradeRequestWrapper*> *From, CArrayList<MqlTradeRequestWrapper*> *To) {
   for (int i = 0; i < From.Count(); i++) {
      MqlTradeRequestWrapper *Request;
      From.TryGetValue(i, Request);
      if (IsRecurrentBoomerangStatus(Request)) {
         To.Add(Request);
         SetRecurrentBoomerangStatus(Request, BOOMERANG_NOT_ALLOWED);
      }
   }
}

//--- Helper Functions: TransferRecurrentRequest
bool ConstructFullTradePool::IsRecurrentBoomerangStatus(MqlTradeRequestWrapper *Request) {
   bool BoomerangStatus = false;
   RecurrentTradeBoomerangStatus.TryGetValue(Request, BoomerangStatus);
   return BoomerangStatus;
}

//--- Helper Functions: TransferRecurrentRequest
void ConstructFullTradePool::SetRecurrentBoomerangStatus(MqlTradeRequestWrapper *Request, const bool InputBoomerangStatus) {
   bool BoomerangStatus = false;
   RecurrentTradeBoomerangStatus.TryGetValue(Request, BoomerangStatus);
   BoomerangStatus = InputBoomerangStatus;
   RecurrentTradeBoomerangStatus.Add(Request, BoomerangStatus);
}

//--- Operations: Monitoring
void ConstructFullTradePool::UpdateRecurrentTradeBoomerangStatus(const double CurrentPrice) {
   CompletionBoundary                  *BoundaryList[];
   CArrayList<MqlTradeRequestWrapper*> *RequestList[];
   RecurrentTradePoolBoomerang.CopyTo(BoundaryList, RequestList);
   
   for (int i = 0; i < ArraySize(BoundaryList); i++) {
      if (IsInCompletionZone(BoundaryList[i], CurrentPrice)) {
         SetRecurrentBoomerangStatus(RequestList[i], BOOMERANG_ALLOWED);
      }
   }
}

//--- Helper Functions: UpdateRecurrentTradeBoomerangStatus
bool ConstructFullTradePool::IsInCompletionZone(CompletionBoundary *InputBoundary, const double InputPrice) {
   return InputBoundary.GetLowerBound() <= InputPrice && InputPrice <= InputBoundary.GetUpperBound();
}

//--- Helper Functions: UpdateRecurrentTradeBoomerangStatus
void ConstructFullTradePool::SetRecurrentBoomerangStatus(CArrayList<MqlTradeRequestWrapper*> *RequestList, const bool InputBoomerangStatus) {
   for (int i = 0; i < RequestList.Count(); i++) {
      MqlTradeRequestWrapper *Request;
      RequestList.TryGetValue(i, Request);
      SetRecurrentBoomerangStatus(Request, InputBoomerangStatus);
   }
}

//--- Auxilary Function
bool ConstructFullTradePool::IsInExecutionZone(ExecutionBoundary *InputBoundary, const double InputPrice) {
   return InputBoundary.GetLowerBound() <= InputPrice && InputPrice <= InputBoundary.GetUpperBound();
}