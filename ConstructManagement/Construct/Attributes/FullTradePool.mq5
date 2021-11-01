#property strict

#include "../../../ConstructManagement/Construct/Attributes/FullTradePool.mqh"

//--- Main Constructor
ConstructFullTradePool::ConstructFullTradePool(void) {
   IP = IndicatorProcessor::GetInstance();
}

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
   CArrayList<MqlTradeRequestWrapper*> *RequestList;
   OneTimeTradePool.TryGetValue(InputBoundary, RequestList);
   RequestList.Add(Request);
   OneTimeTradePool.TrySetValue(InputBoundary, RequestList);
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
   CArrayList<MqlTradeRequestWrapper*> *RequestList;
   RecurrentTradePool.TryGetValue(InputBoundary, RequestList);
   RequestList.Add(Request);
   RecurrentTradePool.TrySetValue(InputBoundary, RequestList);
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
   CArrayList<MqlTradeRequestWrapper*> *RequestList;
   RecurrentTradePoolBoomerang.TryGetValue(InputBoundary, RequestList);
   RequestList.Add(Request);
   RecurrentTradePoolBoomerang.TrySetValue(InputBoundary, RequestList);
}

//--- Helper Functions: AddRecurrentRequestBoomerang
void ConstructFullTradePool::AddNewCompletionBoundaryRecurrentRequest(CompletionBoundary *InputBoundary, MqlTradeRequestWrapper *Request) {
   CArrayList<MqlTradeRequestWrapper*> *RequestList = new CArrayList<MqlTradeRequestWrapper*>();
   RequestList.Add(Request);
   RecurrentTradePoolBoomerang.Add(InputBoundary, RequestList);
}

//--- Operations: Monitoring
CArrayList<MqlTradeRequestWrapper*> *ConstructFullTradePool::GetRequest(const double CurrentPrice) {
   CArrayList<MqlTradeRequestWrapper*> *OneTimeRequestList   = GetOneTimeRequest(CurrentPrice);
   CArrayList<MqlTradeRequestWrapper*> *RecurrentRequestList = GetRecurrentRequest(CurrentPrice);
   CArrayList<MqlTradeRequestWrapper*> *FinalRequestList     = new CArrayList<MqlTradeRequestWrapper*>();
   
   FinalRequestList.AddRange(OneTimeRequestList);
   FinalRequestList.AddRange(RecurrentRequestList);
   
   delete OneTimeRequestList;
   delete RecurrentRequestList;
   return FinalRequestList;
}

//--- Helper Functions: GetRequest
CArrayList<MqlTradeRequestWrapper*> *ConstructFullTradePool::GetOneTimeRequest(const double CurrentPrice) {
   CArrayList<MqlTradeRequestWrapper*> *ExecutingRequest = new CArrayList<MqlTradeRequestWrapper*>();
   
   ExecutionBoundary                   *BoundaryList[];
   CArrayList<MqlTradeRequestWrapper*> *RequestList[];
   OneTimeTradePool.CopyTo(BoundaryList, RequestList);
   
   for (int i = 0; i < ArraySize(BoundaryList); i++) {
      if (IsInExecutionZone(BoundaryList[i], CurrentPrice)) {
         TransferOneTimeRequest(RequestList[i], ExecutingRequest);
      }
   }
   return ExecutingRequest;
}

//--- Helper Functions: GetOneTimeRequest
void ConstructFullTradePool::TransferOneTimeRequest(CArrayList<MqlTradeRequestWrapper*> *From, CArrayList<MqlTradeRequestWrapper*> *To) {
   MqlTradeRequestWrapper *Request;
   for (int i = 0; i < From.Count(); i++) {
      From.TryGetValue(i, Request);
      if (IsOneTimeBoomerangStatus(Request)) {
         To.Add(new MqlTradeRequestWrapper(Request));
         SetOneTimeBoomerangStatus(Request, BOOMERANG_NOT_ALLOWED);
      }
   }
}

//--- Helper Functions: TransferOneTimeRequest
bool ConstructFullTradePool::IsOneTimeBoomerangStatus(MqlTradeRequestWrapper *Request) {
   bool BoomerangStatus = BOOMERANG_NOT_ALLOWED;
   OneTimeTradeBoomerangStatus.TryGetValue(Request, BoomerangStatus);
   return BoomerangStatus;
}

//--- Helper Functions: TransferOneTimeRequest
void ConstructFullTradePool::SetOneTimeBoomerangStatus(MqlTradeRequestWrapper *Request, const bool InputBoomerangStatus) {
   OneTimeTradeBoomerangStatus.TrySetValue(Request, InputBoomerangStatus);
}

//--- Helper Functions: GetRequest
CArrayList<MqlTradeRequestWrapper*> *ConstructFullTradePool::GetRecurrentRequest(const double CurrentPrice) {
   CArrayList<MqlTradeRequestWrapper*> *ExecutingRequest = new CArrayList<MqlTradeRequestWrapper*>();
   
   ExecutionBoundary                    *BoundaryList[];
   CArrayList<MqlTradeRequestWrapper *> *RequestList[];
   RecurrentTradePool.CopyTo(BoundaryList, RequestList);
   
   for (int i = 0; i < ArraySize(BoundaryList); i++) {
      if (IsInExecutionZone(BoundaryList[i], CurrentPrice)) {
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
         To.Add(new MqlTradeRequestWrapper(Request));
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
   RecurrentTradeBoomerangStatus.TrySetValue(Request, InputBoomerangStatus);
}

//--- Operations: Monitoring
void ConstructFullTradePool::UpdateRecurrentTradeBoomerangStatus(const double CurrentPrice) {
   CompletionBoundary                  *BoundaryList[];
   CArrayList<MqlTradeRequestWrapper*> *RequestList[];
   RecurrentTradePoolBoomerang.CopyTo(BoundaryList, RequestList);
   
   for (int i = 0; i < ArraySize(BoundaryList); i++) {
      if (IsInCompletionZone(BoundaryList[i], CurrentPrice)) {
         UpdateRecurrentRequestListCreateDateTime(RequestList[i]);
         SetRecurrentBoomerangStatus(RequestList[i], BOOMERANG_ALLOWED);
      }
   }
}

//--- Helper Functions: UpdateRecurrentTradeBoomerangStatus
bool ConstructFullTradePool::IsInCompletionZone(CompletionBoundary *InputBoundary, const double InputPrice) {
   return InputBoundary.GetBidLowerBound() <= InputPrice && InputPrice <= InputBoundary.GetBidUpperBound() &&
          InputBoundary.GetAskLowerBound() <= InputPrice + IP.GetCloseSpreadInPrice(CURRENT_BAR)           &&
          InputBoundary.GetAskUpperBound() >= InputPrice + IP.GetCloseSpreadInPrice(CURRENT_BAR)            ;
}

//--- Helper Functions: UpdateRecurrentTradeBoomerangStatus
void ConstructFullTradePool::UpdateRecurrentRequestListCreateDateTime(CArrayList<MqlTradeRequestWrapper*> *RequestList) {
   for (int i = 0; i < RequestList.Count(); i++) {
      MqlTradeRequestWrapper *Request;
      RequestList.TryGetValue(i, Request);
      Request.SetCreateDateTime(TimeGMT());
   }
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
   return InputBoundary.GetBidLowerBound() <= InputPrice && InputPrice <= InputBoundary.GetBidUpperBound() &&
          InputBoundary.GetAskLowerBound() <= InputPrice + IP.GetCloseSpreadInPrice(CURRENT_BAR)           &&
          InputBoundary.GetAskUpperBound() >= InputPrice + IP.GetCloseSpreadInPrice(CURRENT_BAR)            ;
}