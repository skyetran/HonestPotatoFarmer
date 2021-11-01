#property strict

#include "../OrderManagement/ConstructTradePool.mqh"

//--- Main Constructor
ConstructTradePool::ConstructTradePool(void) {
   IP   = IndicatorProcessor::GetInstance();
   PMHP = PositionManagementHyperParameters::GetInstance(); 
   GS   = GeneralSettings::GetInstance();
   
   RequestResultSession     = new CHashMap<MqlTradeRequestWrapper*, MqlTradeResultWrapper*>();
   RequestSessionExpiration = new CHashMap<MqlTradeRequestWrapper*, ENUM_POOLING_STATUS>();
   
   RawMarketRequestList = new CArrayList<MqlTradeRequestWrapper*>();
   LimitRequestList     = new CArrayList<MqlTradeRequestWrapper*>();
   StopLimitRequestList = new CArrayList<MqlTradeRequestWrapper*>();
   StopRequestList      = new CArrayList<MqlTradeRequestWrapper*>();
   LongRequestList      = new CArrayList<MqlTradeRequestWrapper*>();
   ShortRequestList     = new CArrayList<MqlTradeRequestWrapper*>();
}

//--- Destructor
ConstructTradePool::~ConstructTradePool(void) {
   RequestResultSession.Clear();
   RequestSessionExpiration.Clear();
   
   RawMarketRequestList.Clear();
   LimitRequestList.Clear();
   StopLimitRequestList.Clear();
   StopRequestList.Clear();
   LongRequestList.Clear();
   ShortRequestList.Clear();
   
   delete RequestResultSession;
   delete RequestSessionExpiration;
   
   delete RawMarketRequestList;
   delete LimitRequestList;
   delete StopLimitRequestList;
   delete StopRequestList;
   delete LongRequestList;
   delete ShortRequestList;
}

//--- Operations
void ConstructTradePool::AddNewRequest(CArrayList<MqlTradeRequestWrapper*> *InputRequestList) {
   MqlTradeRequestWrapper *Request;
   for (int i = 0; i < InputRequestList.Count(); i++) {
      InputRequestList.TryGetValue(i, Request);
      AddNewRequest(Request);
   }
   delete InputRequestList;
}

//--- Operations
void ConstructTradePool::AddNewRequest(MqlTradeRequestWrapper *InputRequest) {
   AddNewRequestByOrderType(InputRequest);
   AddNewRequestByOrderDirection(InputRequest);
   RequestSessionExpiration.Add(InputRequest, UNPOOL);
}

//--- Helper Functions: AddNewRequest
void ConstructTradePool::AddNewRequestByOrderType(MqlTradeRequestWrapper *InputRequest) {
   if (InputRequest.IsRawMarketRequest()) {
      RawMarketRequestList.Add(InputRequest);
   } else if (InputRequest.IsLimitRequest()) {
      LimitRequestList.Add(InputRequest);
   } else if (InputRequest.IsStopLimitRequest()) {
      StopLimitRequestList.Add(InputRequest);
   } else if (InputRequest.IsStopRequest()) {
      StopRequestList.Add(InputRequest);
   }
}

//--- Helper Functions: AddNewRequest
void ConstructTradePool::AddNewRequestByOrderDirection(MqlTradeRequestWrapper *InputRequest) {
   if (InputRequest.IsBuyRequest()) {
      LongRequestList.Add(InputRequest);
   } else if (InputRequest.IsSellRequest()) {
      ShortRequestList.Add(InputRequest);
   }
}

//--- Operations
CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *ConstructTradePool::GetRawMarketRequestOriginMapping(void) {
   CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *RawMarketRequestOriginMapping = new CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*>();
   CArrayList<MqlTradeRequestWrapper*> *UnpoolRawMarketRequest = PoolRawMarketRequest();
   MakeOriginMapping(RawMarketRequestOriginMapping, UnpoolRawMarketRequest);   
   delete UnpoolRawMarketRequest;
   return RawMarketRequestOriginMapping;
}

//--- Operations
CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *ConstructTradePool::GetLimitRequestOriginMapping(void) {
   CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *LimitRequestOriginMapping = new CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*>();
   CArrayList<MqlTradeRequestWrapper*> *UnpoolLimitRequest = PoolLimitRequest();
   MakeOriginMapping(LimitRequestOriginMapping, UnpoolLimitRequest);   
   delete UnpoolLimitRequest;
   return LimitRequestOriginMapping;
}

//--- Operations
CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *ConstructTradePool::GetStopLimitRequestOriginMapping(void) {
   CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *StopLimitRequestOriginMapping = new CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*>();
   CArrayList<MqlTradeRequestWrapper*> *UnpoolStopLimitRequest = PoolStopLimitRequest();
   MakeOriginMapping(StopLimitRequestOriginMapping, UnpoolStopLimitRequest);   
   delete UnpoolStopLimitRequest;
   return StopLimitRequestOriginMapping;
}

//--- Operations
CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *ConstructTradePool::GetStopRequestOriginMapping(void) {
   CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *StopRequestOriginMapping = new CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*>();
   CArrayList<MqlTradeRequestWrapper*> *UnpoolStopRequest = PoolStopRequest();
   MakeOriginMapping(StopRequestOriginMapping, UnpoolStopRequest);   
   delete UnpoolStopRequest;
   return StopRequestOriginMapping;
}

//--- Helper Functions: GetOriginMapping
CArrayList<MqlTradeRequestWrapper*> *ConstructTradePool::PoolRawMarketRequest(void) { return GetUnpoolRequests(RawMarketRequestList); }
CArrayList<MqlTradeRequestWrapper*> *ConstructTradePool::PoolLimitRequest(void)     { return GetUnpoolRequests(LimitRequestList);     }
CArrayList<MqlTradeRequestWrapper*> *ConstructTradePool::PoolStopLimitRequest(void) { return GetUnpoolRequests(StopLimitRequestList); }
CArrayList<MqlTradeRequestWrapper*> *ConstructTradePool::PoolStopRequest(void)      { return GetUnpoolRequests(StopRequestList);      }

//--- Helper Functions: GetOriginMapping
void ConstructTradePool::MakeOriginMapping(CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *InputOriginMapping, CArrayList<MqlTradeRequestWrapper*> *InputUnpoolRequestList) {
   MqlTradeRequestWrapper *TempRequest;
   for (int i = 0; i < InputUnpoolRequestList.Count(); i++) {
      InputUnpoolRequestList.TryGetValue(i, TempRequest);
      InputOriginMapping.Add(TempRequest, GetPointer(this));
   }
}

//--- Operations
CArrayList<MqlTradeRequestWrapper*> *ConstructTradePool::GetLongRequest(void)       { return LongRequestList;  }
CArrayList<MqlTradeRequestWrapper*> *ConstructTradePool::GetShortRequest(void)      { return ShortRequestList; }

//--- Helper Functions: PoolRawMarketRequest/PoolLimitRequest/PoolStopLimitRequest/PoolStopRequest
CArrayList<MqlTradeRequestWrapper*> *ConstructTradePool::GetUnpoolRequests(CArrayList<MqlTradeRequestWrapper*> *RequestList) {
   CArrayList<MqlTradeRequestWrapper*> *UnpoolRequestList = new CArrayList<MqlTradeRequestWrapper*>();
   
   MqlTradeRequestWrapper *RequestTemp;
   for (int i = 0; i < RequestList.Count(); i++) {
      RequestList.TryGetValue(i, RequestTemp);
      if (IsRequestUnpool(RequestTemp)) {
         UnpoolRequestList.Add(RequestTemp);
         SetRequestPoolingStatusToAlreadyPool(RequestTemp);
      }
   }
   return UnpoolRequestList;
}

//--- Helper Functions: PoolRawMarketRequest/PoolLimitRequest/PoolStopLimitRequest/PoolStopRequest
bool ConstructTradePool::IsRequestUnpool(MqlTradeRequestWrapper *InputRequest) {
   return GetPoolingStatus(InputRequest) == UNPOOL;
}

//--- Helper Functions: PoolRawMarketRequest/PoolLimitRequest/PoolStopLimitRequest/PoolStopRequest
bool ConstructTradePool::IsRequestAlreadyPool(MqlTradeRequestWrapper *InputRequest) {
   return GetPoolingStatus(InputRequest) == ALREADY_POOL;
}

//--- Helper Functions: PoolRawMarketRequest/PoolLimitRequest/PoolStopLimitRequest/PoolStopRequest
ENUM_POOLING_STATUS ConstructTradePool::GetPoolingStatus(MqlTradeRequestWrapper *InputRequest) {
   ENUM_POOLING_STATUS RequestPoolingStatus = ALREADY_POOL;
   RequestSessionExpiration.TryGetValue(InputRequest, RequestPoolingStatus);
   return RequestPoolingStatus;
}

//--- Helper Functions: PoolRawMarketRequest/PoolLimitRequest/PoolStopLimitRequest/PoolStopRequest
void ConstructTradePool::SetRequestPoolingStatusToAlreadyPool(MqlTradeRequestWrapper *InputRequest) {
   RequestSessionExpiration.TrySetValue(InputRequest, ALREADY_POOL);
}

//--- Operations
void ConstructTradePool::LogExecutedRequest(MqlTradeRequestWrapper *InputRequest, MqlTradeResultWrapper *InputResult) {
   RequestResultSession.Add(InputRequest, InputResult);
}

//--- Operations
void ConstructTradePool::MakeFullyHedged(void) {
   if (IsNetLong()) {
      MakeNetLongFullyHedged();
   } else if (IsNetShort()) {
      MakeNetShortFullyHedged();
   }
}

//--- Helper Functions: MakeFullyHedged
void ConstructTradePool::MakeNetLongFullyHedged(void) {
   MqlTradeRequest request = {};
   
   request.action    = TRADE_ACTION_DEAL;
   request.magic     = GS.GetMagicNumber();
   request.symbol    = Symbol();
   request.deviation = PMHP.GetSlippageInPts();
   request.type      = ORDER_TYPE_SELL;
   
   request.volume    = GetUnhedgedNetVolume();
   request.price     = IP.GetBidPrice(CURRENT_BAR);
   request.comment   = GetRandomString();
   
   AddNewRequest(new MqlTradeRequestWrapper(request));
}

//--- Helper Functions: MakeFullyHedged
void ConstructTradePool::MakeNetShortFullyHedged(void) {
   MqlTradeRequest request = {};
   
   request.action    = TRADE_ACTION_DEAL;
   request.magic     = GS.GetMagicNumber();
   request.symbol    = Symbol();
   request.deviation = PMHP.GetSlippageInPts();
   request.type      = ORDER_TYPE_BUY;
   
   request.volume    = GetUnhedgedNetVolume();
   request.price     = IP.GetAskPrice(CURRENT_BAR);
   request.comment   = GetRandomString();
   
   AddNewRequest(new MqlTradeRequestWrapper(request));
}

//--- Helper Functions: MakeFullyHedged
string ConstructTradePool::GetRandomString(void) {
   return IntegerToString(1 * MathRand()) + IntegerToString(2 * MathRand()) + IntegerToString(3 * MathRand()) +
          IntegerToString(4 * MathRand()) + IntegerToString(5 * MathRand()) + IntegerToString(6 * MathRand()) +
          IntegerToString(7 * MathRand()) + IntegerToString(8 * MathRand()) + IntegerToString(9 * MathRand()) +
          IntegerToString(8 * MathRand()) + IntegerToString(7 * MathRand()) + IntegerToString(6 * MathRand());
}

//--- Getters
double ConstructTradePool::GetUnhedgedNetVolume(void) {
   double TotalLongVolume  = GetTotalLongVolume();
   double TotalShortVolume = GetTotalShortVolume();
   return MathMax(TotalLongVolume, TotalShortVolume) - MathMin(TotalLongVolume, TotalShortVolume);
}

//--- Getters
double ConstructTradePool::GetHedgedNetVolume(void) {
   return MathMin(GetTotalLongVolume(), GetTotalShortVolume());
}

//--- Helper Functions: Volume-Related Functions
double ConstructTradePool::GetTotalLongVolume(void) {
   double TotalLongVolume = 0;
   
   MqlTradeRequestWrapper *TempRequest;
   for (int i = 0; i < LongRequestList.Count(); i++) {
      LongRequestList.TryGetValue(i, TempRequest);
      TotalLongVolume += GetRequestVolume(TempRequest);
   }
   return TotalLongVolume;
}

//--- Helper Functions: Volume-Related Functions
double ConstructTradePool::GetTotalShortVolume(void) {
   double TotalShortVolume = 0;
   
   MqlTradeRequestWrapper *TempRequest;
   for (int i = 0; i < ShortRequestList.Count(); i++) {
      ShortRequestList.TryGetValue(i, TempRequest);
      TotalShortVolume += GetRequestVolume(TempRequest);
   }
   return TotalShortVolume;
}

//--- Getters
double ConstructTradePool::GetCurrentPnL(void) {
   double PnL = 0;
   
   MqlTradeRequestWrapper *RequestList[];
   MqlTradeResultWrapper  *ResultList[];
   RequestResultSession.CopyTo(RequestList, ResultList);
   
   for (int i = 0; i < ArraySize(RequestList); i++) {
      if (IsOrderFilled(RequestList[i])) {
         int MinLotSizeMultiple = (int) (GetRequestVolume(RequestList[i]) / GetMinLotSize());
         PnL += GetPnLInPts(RequestList[i]) * GetPointValuePerMinStandardLot() * MinLotSizeMultiple;
      }
   }
   return PnL;
}

//--- Helper Functions: GetCurrentPnL
int ConstructTradePool::GetPnLInPts(MqlTradeRequestWrapper *InputRequest) {
   if (InputRequest.IsBuyRequest()) {
      return GetPnLBuyRequestInPts(InputRequest);
   }
   if (InputRequest.IsSellRequest()) {
      return GetPnLSellRequestInPts(InputRequest);
   }
   return 0;
}

//--- Helper Functions: GetCurrentPnL
int ConstructTradePool::GetPnLBuyRequestInPts(MqlTradeRequestWrapper *InputRequest) {
   return PriceToPointCvt(IP.GetBidPrice(CURRENT_BAR) - GetDealPrice(InputRequest));
}

//--- Helper Functions: GetCurrentPnL
int ConstructTradePool::GetPnLSellRequestInPts(MqlTradeRequestWrapper *InputRequest) {
   return PriceToPointCvt(GetDealPrice(InputRequest) - IP.GetAskPrice(CURRENT_BAR));
}

//--- Getters
double ConstructTradePool::GetPositiveSlippagePnL(void) {
   double SlippagePnL = 0;
   
   MqlTradeRequestWrapper *RequestList[];
   MqlTradeResultWrapper  *ResultList[];
   RequestResultSession.CopyTo(RequestList, ResultList);
   
   for (int i = 0; i < ArraySize(RequestList); i++) {
      if (IsOrderFilled(RequestList[i])) {
         int MinLotSizeMultiple = (int) (GetRequestVolume(RequestList[i]) / GetMinLotSize());
         SlippagePnL += GetPositiveSlippageInPts(RequestList[i]) * GetPointValuePerMinStandardLot() * MinLotSizeMultiple;
      }
   }
   return SlippagePnL;
}

//--- Helper Functions: GetPositiveSlippagePnL
int ConstructTradePool::GetPositiveSlippageInPts(MqlTradeRequestWrapper *InputRequest) {
   if (InputRequest.IsBuyRequest()) {
      return GetPositiveSlippageBuyRequestInPts(InputRequest);
   }
   if (InputRequest.IsSellRequest()) {
      return GetPositiveSlippageSellRequestInPts(InputRequest);
   }
   return 0;
}

//--- Helper Functions: GetPositiveSlippagePnL
int ConstructTradePool::GetPositiveSlippageBuyRequestInPts(MqlTradeRequestWrapper *InputRequest) {
   if (InputRequest.IsMarketRequest()) {
      return GetPositiveSlippageBuyRequestMarketOrderInPts(InputRequest);
   }
   return GetPositiveSlippageBuyRequestPendingOrderInPts(InputRequest);
}

//--- Helper Functions: GetPositiveSlippagePnL
int ConstructTradePool::GetPositiveSlippageBuyRequestMarketOrderInPts(MqlTradeRequestWrapper *InputRequest) {
   int OrderSlippage = PriceToPointCvt(GetRealPrice(InputRequest) - GetDesiredPrice(InputRequest));
   if (IsBullishState()) {
      OrderSlippage += PMHP.GetSlippageInPts();
   }
   return OrderSlippage;
}

//--- Helper Functions: GetPositiveSlippagePnL
bool ConstructTradePool::IsBullishState(void) {
   return MW.GetStateName() == "With-Trend Bullish" || MW.GetStateName() == "Counter-Trend Bearish";
}

//--- Helper Functions: GetPositiveSlippagePnL
int ConstructTradePool::GetPositiveSlippageBuyRequestPendingOrderInPts(MqlTradeRequestWrapper *InputRequest) {
   return PriceToPointCvt(GetRealPrice(InputRequest) - GetDesiredPrice(InputRequest));
}

//--- Helper Functions: GetPositiveSlippagePnL
int ConstructTradePool::GetPositiveSlippageSellRequestInPts(MqlTradeRequestWrapper *InputRequest) {
   if (InputRequest.IsPendingRequest()) {
      return GetPositiveSlippageSellRequestMarketOrderInPts(InputRequest);
   }
   return GetPositiveSlippageSellRequestPendingOrderInPts(InputRequest);
}

//--- Helper Functions: GetPositiveSlippagePnL
int ConstructTradePool::GetPositiveSlippageSellRequestMarketOrderInPts(MqlTradeRequestWrapper *InputRequest) {
   int OrderSlippage = PriceToPointCvt(GetDesiredPrice(InputRequest) - GetRealPrice(InputRequest));
   if (IsBearishState()) {
      OrderSlippage += PMHP.GetSlippageInPts();
   }
   return OrderSlippage;
}

//--- Helper Functions: GetPositiveSlippagePnL
bool ConstructTradePool::IsBearishState(void) {
   return MW.GetStateName() == "With-Trend Bearish" || MW.GetStateName() == "Counter-Trend Bullish";
}

//--- Helper Functions: GetPositiveSlippagePnL
int ConstructTradePool::GetPositiveSlippageSellRequestPendingOrderInPts(MqlTradeRequestWrapper *InputRequest) {
   return PriceToPointCvt(GetDesiredPrice(InputRequest) - GetRealPrice(InputRequest));
}

//--- Getters
bool ConstructTradePool::IsNetLong(void) {
   return GetTotalLongVolume() > GetTotalShortVolume();
}

//--- Getters
bool ConstructTradePool::IsNetShort(void) {
   return GetTotalLongVolume() < GetTotalShortVolume();
}

//--- Getters
bool ConstructTradePool::IsFullyHedged(void) {
   return GetTotalLongVolume() == GetTotalShortVolume();
}

//--- Auxilary Functions
bool ConstructTradePool::IsOrderFilled(MqlTradeRequestWrapper *InputRequest) {
   return GetOrderState(InputRequest) == ORDER_STATE_FILLED;
}

//--- Auxilary Functions
void ConstructTradePool::UpdateHistoryRange(void) {
   HistorySelect(MW.GetStartCacheDateTime(), TimeCurrent());
}

//--- Auxilary Functions: Get Raw Info
ENUM_ORDER_STATE ConstructTradePool::GetOrderState(MqlTradeRequestWrapper *InputRequest) {
   UpdateHistoryRange();
   if (HistoryOrderSelect(GetOrderTicket(InputRequest))) {
      return (ENUM_ORDER_STATE) OrderGetInteger(ORDER_STATE);
   }
   return ORDER_STATE_REJECTED;
}

//--- Auxilary Functions: Get Raw Info
ulong ConstructTradePool::GetOrderTicket(MqlTradeRequestWrapper *InputRequest) {
   return GetTradeResult(InputRequest).order;
}

//--- Auxilary Functions: Get Raw Info
MqlTradeResultWrapper *ConstructTradePool::GetTradeResult(MqlTradeRequestWrapper *InputRequest) {
   MqlTradeResultWrapper *Result;
   RequestResultSession.TryGetValue(InputRequest, Result);
   return Result;
}

//--- Auxilary Functions: Get Raw Info
double ConstructTradePool::GetRequestVolume(MqlTradeRequestWrapper *InputRequest) {
   return GetTradeResult(InputRequest).GetRealVolume();
}

//--- Auxilary Functions: Get Raw Info
double ConstructTradePool::GetDesiredPrice(MqlTradeRequestWrapper *InputRequest) {
   if (InputRequest.IsStopLimitRequest()) {
      return InputRequest.stoplimit;
   }
   return InputRequest.price;
}

//--- Auxilary Functions: Get Raw Info
double ConstructTradePool::GetRealPrice(MqlTradeRequestWrapper *InputRequest) {
   return GetDealPrice(InputRequest);
}

//--- Auxilary Functions: Get Raw Info
ulong ConstructTradePool::GetDealTicket(MqlTradeRequestWrapper *InputRequest) {
   if (InputRequest.IsMarketRequest()) {
      return GetMarketDealTicket(InputRequest);
   }
   if (InputRequest.IsPendingRequest()) {
      return GetPendingDealTicket(InputRequest);
   }
   return 0;
}

//--- Auxilary Functions: Get Raw Info
ulong ConstructTradePool::GetMarketDealTicket(MqlTradeRequestWrapper *InputRequest) {
   return GetTradeResult(InputRequest).deal;
}

//--- Auxilary Functions: Get Raw Info
ulong ConstructTradePool::GetPendingDealTicket(MqlTradeRequestWrapper *InputRequest) {
   ulong DealTicket;
   ulong TrueOrderTicket = GetOrderTicket(InputRequest);
   
   UpdateHistoryRange();
   int DealsTotal = HistoryDealsTotal();
   
   for (int DealIndex = 0; DealIndex < DealsTotal; DealIndex++) {
      DealTicket = HistoryDealGetTicket(DealIndex);
      if (HistoryDealGetInteger(DealTicket, DEAL_ORDER) == TrueOrderTicket) {
         return DealTicket;
      }
   }
   return 0;
}

//--- Auxilary Functions: Get Raw Info
double ConstructTradePool::GetDealPrice(MqlTradeRequestWrapper *InputRequest) {
   return HistoryDealGetDouble(GetDealTicket(InputRequest), DEAL_PRICE);
}