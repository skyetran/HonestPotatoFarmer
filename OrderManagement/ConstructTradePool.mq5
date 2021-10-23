#property strict

#include "../OrderManagement/ConstructTradePool.mqh"

//--- Main Constructor
ConstructTradePool::ConstructTradePool(void) {
   IP   = IndicatorProcessor::GetInstance();
   PMHP = PositionManagementHyperParameters::GetInstance(); 
   
   RequestResultSession = new CHashMap<MqlTradeRequestWrapper*, MqlTradeResultWrapper*>();
   
   RawMarketRequestList = new CArrayList<MqlTradeRequestWrapper*>();
   LimitRequestList     = new CArrayList<MqlTradeRequestWrapper*>();
   StopLimitRequestList = new CArrayList<MqlTradeRequestWrapper*>();
   StopRequestList      = new CArrayList<MqlTradeRequestWrapper*>();
}

//--- Destructor
ConstructTradePool::~ConstructTradePool(void) {
   delete RequestResultSession;
   
   delete RawMarketRequestList;
   delete LimitRequestList;
   delete StopLimitRequestList;
   delete StopRequestList;
   delete LongRequestList;
   delete ShortRequestList;
}

//--- Operations
void ConstructTradePool::AddNewRequest(CArrayList<MqlTradeRequestWrapper*> *InputRequestList) {
   for (int i = 0; i < InputRequestList.Count(); i++) {
      MqlTradeRequestWrapper *Request;
      InputRequestList.TryGetValue(i, Request);
      AddNewRequest(Request);
   }
}

//--- Operations
void ConstructTradePool::AddNewRequest(MqlTradeRequestWrapper *InputRequest) {
   AddNewRequestByOrderType(InputRequest);
   AddNewRequestByOrderDirection(InputRequest);   
}

//--- Helper Functions: AddNewRequest
void ConstructTradePool::AddNewRequestByOrderType(MqlTradeRequestWrapper *InputRequest) {
   if (IsRawMarketRequest(InputRequest)) {
      RawMarketRequestList.Add(InputRequest);
   } else if (IsLimitRequest(InputRequest)) {
      LimitRequestList.Add(InputRequest);
   } else if (IsStopLimitRequest(InputRequest)) {
      StopLimitRequestList.Add(InputRequest);
   } else if (IsStopRequest(InputRequest)) {
      StopRequestList.Add(InputRequest);
   }
}

//--- Helper Functions: AddNewRequest
bool ConstructTradePool::IsRawMarketRequest(MqlTradeRequestWrapper *InputRequest) {
   return InputRequest.type == ORDER_TYPE_BUY || InputRequest.type == ORDER_TYPE_SELL;
}

//--- Helper Functions: AddNewRequest
bool ConstructTradePool::IsLimitRequest(MqlTradeRequestWrapper *InputRequest) {
   return InputRequest.type == ORDER_TYPE_BUY_LIMIT || InputRequest.type == ORDER_TYPE_SELL_LIMIT;
}

//--- Helper Functions: AddNewRequest
bool ConstructTradePool::IsStopLimitRequest(MqlTradeRequestWrapper *InputRequest) {
   return InputRequest.type == ORDER_TYPE_BUY_STOP_LIMIT || InputRequest.type == ORDER_TYPE_SELL_STOP_LIMIT;
}

//--- Helper Functions: AddNewRequest
bool ConstructTradePool::IsStopRequest(MqlTradeRequestWrapper *InputRequest) {
   return InputRequest.type == ORDER_TYPE_BUY_STOP || InputRequest.type == ORDER_TYPE_SELL_STOP;
}

//--- Helper Functions: AddNewRequest
void ConstructTradePool::AddNewRequestByOrderDirection(MqlTradeRequestWrapper *InputRequest) {
   if (IsBuyRequest(InputRequest)) {
      LongRequestList.Add(InputRequest);
   } else if (IsSellRequest(InputRequest)) {
      ShortRequestList.Add(InputRequest);
   }
}

//--- Operations
CArrayList<MqlTradeRequestWrapper*> *ConstructTradePool::PoolRawMarketRequest(void) { return RawMarketRequestList; }
CArrayList<MqlTradeRequestWrapper*> *ConstructTradePool::PoolLimitRequest(void)     { return LimitRequestList;     }
CArrayList<MqlTradeRequestWrapper*> *ConstructTradePool::PoolStopLimitRequest(void) { return StopLimitRequestList; }
CArrayList<MqlTradeRequestWrapper*> *ConstructTradePool::PoolStopRequest(void)      { return StopRequestList;      }

//--- Operations
void ConstructTradePool::LogExecutedRequest(MqlTradeRequestWrapper *InputRequest, MqlTradeResultWrapper *InputResult) {
   RequestResultSession.Add(InputRequest, InputResult);
}

//--- Getters
double ConstructTradePool::GetAbsRealUnhedgedNetVolume(void) {
   return MathAbs(GetRealUnhedgedNetVolume());
}

//--- Getters
double ConstructTradePool::GetRealUnhedgedNetVolume(void) {
   return GetUnhedgedNetVolume() - GetHedgedNetVolume();
}

//--- Getters
double ConstructTradePool::GetAbsUnhedgedNetVolume(void) {
   return MathAbs(GetUnhedgedNetVolume());
}

//--- Getters
double ConstructTradePool::GetUnhedgedNetVolume(void) {
   CArrayList<ulong> *AllOrderTickets = GetAllOrderTickets();
   double UnhedgedNetVolume = GetNetVolume(AllOrderTickets);
   delete AllOrderTickets;
   return UnhedgedNetVolume;
}

//--- Getters
double ConstructTradePool::GetAbsHedgedNetVolume(void) {
   return MathAbs(GetHedgedNetVolume());
}

//--- Getters
double ConstructTradePool::GetHedgedNetVolume(void) {
   CArrayList<ulong> *HedgedOrderTickets = GetHedgedOrderTickets();
   double HedgedNetVolume = GetNetVolume(HedgedOrderTickets);
   delete HedgedOrderTickets;
   return HedgedNetVolume;
}

//--- Helper Functions: GetNetVolume
double ConstructTradePool::GetNetVolume(CArrayList<ulong> *InputOrderTickets) {
   double NetVolume = 0;
   
   ulong  OrderTicketTemp;
   double OrderVolumeTemp;
   
   for (int i = 0; i < InputOrderTickets.Count(); i++) {
      InputOrderTickets.TryGetValue(i, OrderTicketTemp);
      OrderVolumeTemp = GetOrderVolume(OrderTicketTemp);
      if (IsLongOrder(OrderTicketTemp)) {
         NetVolume += OrderVolumeTemp;
      } else if (IsShortOrder(OrderTicketTemp)) {
         NetVolume -= OrderVolumeTemp;
      }
   }
   return NetVolume;
}

//--- Helper Functions: GetNetVolume
bool ConstructTradePool::IsLongOrder(ulong InputOrderTicket) {
   ENUM_ORDER_TYPE OrderType = GetOrderType(InputOrderTicket);
   return OrderType == ORDER_TYPE_BUY           ||
          OrderType == ORDER_TYPE_BUY_LIMIT     ||
          OrderType == ORDER_TYPE_BUY_STOP      ||
          OrderType == ORDER_TYPE_BUY_STOP_LIMIT;
}

//--- Helper Functions: GetNetVolume
bool ConstructTradePool::IsShortOrder(ulong InputOrderTicket) {
   ENUM_ORDER_TYPE OrderType = GetOrderType(InputOrderTicket);
   return OrderType == ORDER_TYPE_SELL           ||
          OrderType == ORDER_TYPE_SELL_LIMIT     ||
          OrderType == ORDER_TYPE_SELL_STOP      ||
          OrderType == ORDER_TYPE_SELL_STOP_LIMIT;
}

//--- Getters
CArrayList<ulong> *ConstructTradePool::GetUnhedgedOrderTickets(void) {
   CArrayList<ulong> *UnhedgedOrderTickets = new CArrayList<ulong>();
   CArrayList<ulong> *AllOrderTickets      = GetAllOrderTickets();
   CArrayList<ulong> *HedgedOrderTickets   = GetHedgedOrderTickets();
   
   ulong OrderTicketTemp;
   
   for (int i = 0; i < AllOrderTickets.Count(); i++) {
      AllOrderTickets.TryGetValue(i, OrderTicketTemp);
      if (!HedgedOrderTickets.Contains(OrderTicketTemp)) {
         UnhedgedOrderTickets.Add(OrderTicketTemp);
      }
   }
   delete AllOrderTickets;
   delete HedgedOrderTickets;
   return UnhedgedOrderTickets;
}
   
//--- Getters
CArrayList<ulong> *ConstructTradePool::GetHedgedOrderTickets(void) {
   CArrayList<ulong> *HedgedOrderTickets = new CArrayList<ulong>();
   
   if (IsNetLong()) {
      HedgedOrderTickets = GetHedgedOrderTicketsOfNetLongConstruct();
   } else if (IsNetShort()) {
      HedgedOrderTickets = GetHedgedOrderTicketsOfNetShortConstruct();
   } else if (IsFullyHedged()) {
      HedgedOrderTickets = GetHedgedOrderTicketsOfFullyHedgedConstruct();
   }
   return HedgedOrderTickets;
}

//--- Helper Functions: GetUnhedgedOrderTickets/GetHedgedOrderTickets
CArrayList<ulong> *ConstructTradePool::GetHedgedOrderTicketsOfNetLongConstruct(void) {
   CArrayList<ulong> *HedgedOrderTickets = new CArrayList<ulong>();
   CArrayList<ulong> *LongOrderTickets   = GetAllLongOrderTickets();
   CArrayList<ulong> *ShortOrderTickets  = GetAllShortOrderTickets();
   
   double HedgedVolume = GetTotalShortVolume();
   double CurrentLongVolume = 0;
   ulong LongOrderTicketTemp;
   
   HedgedOrderTickets.AddRange(ShortOrderTickets);
   for (int i = 0; i < LongOrderTickets.Count(); i++) {
      LongOrderTickets.TryGetValue(i, LongOrderTicketTemp);
      HedgedOrderTickets.Add(LongOrderTicketTemp);
      CurrentLongVolume += GetOrderVolume(LongOrderTicketTemp);
      if (CurrentLongVolume >= HedgedVolume) {
         break;
      }
   }
   delete LongOrderTickets;
   delete ShortOrderTickets;
   return HedgedOrderTickets;
}

//--- Helper Functions: GetUnhedgedOrderTickets/GetHedgedOrderTickets
CArrayList<ulong> *ConstructTradePool::GetHedgedOrderTicketsOfNetShortConstruct(void) {
   CArrayList<ulong> *HedgedOrderTickets = new CArrayList<ulong>();
   CArrayList<ulong> *LongOrderTickets   = GetAllLongOrderTickets();
   CArrayList<ulong> *ShortOrderTickets  = GetAllShortOrderTickets();
   
   double HedgedVolume = GetTotalLongVolume();
   double CurrentShortVolume = 0;
   ulong ShortOrderTicketTemp;
   
   HedgedOrderTickets.AddRange(LongOrderTickets);
   for (int i = 0; i < ShortOrderTickets.Count(); i++) {
      ShortOrderTickets.TryGetValue(i, ShortOrderTicketTemp);
      HedgedOrderTickets.Add(ShortOrderTicketTemp);
      CurrentShortVolume += GetOrderVolume(ShortOrderTicketTemp);
      if (CurrentShortVolume >= HedgedVolume) {
         break;
      }
   }
   delete LongOrderTickets;
   delete ShortOrderTickets;
   return HedgedOrderTickets;
}

//--- Helper Functions: GetUnhedgedOrderTickets/GetHedgedOrderTickets
CArrayList<ulong> *ConstructTradePool::GetHedgedOrderTicketsOfFullyHedgedConstruct(void) {
   return GetAllLongOrderTickets();
}

//--- Helper Functions: GetUnhedgedOrderTickets/GetHedgedOrderTickets
CArrayList<ulong> *ConstructTradePool::GetAllOrderTickets(void) {
   CArrayList<ulong> *AllOrderTickets = new CArrayList<ulong>();
   
   MqlTradeRequestWrapper *RequestList[];
   MqlTradeResultWrapper  *ResultList[];
   RequestResultSession.CopyTo(RequestList, ResultList);
   
   for (int i = 0; i < ArraySize(RequestList); i++) {
      if (IsOrderFilled(RequestList[i])) {
         AllOrderTickets.Add(ResultList[i].order);
      }
   }
   return AllOrderTickets;
}

//--- Helper Functions: GetUnhedgedOrderTickets/GetHedgedOrderTickets
CArrayList<ulong> *ConstructTradePool::GetAllLongOrderTickets(void) {
   CArrayList<ulong> *AllLongOrderTickets = new CArrayList<ulong>();
   
   for (int i = 0; i < LongRequestList.Count(); i++) {
      MqlTradeRequestWrapper *TempRequest;
      LongRequestList.TryGetValue(i, TempRequest);
      AllLongOrderTickets.Add(GetOrderTicket(TempRequest));
   }
   return AllLongOrderTickets;
}

//--- Helper Functions: GetUnhedgedOrderTickets/GetHedgedOrderTickets
CArrayList<ulong> *ConstructTradePool::GetAllShortOrderTickets(void) {
   CArrayList<ulong> *AllShortOrderTickets = new CArrayList<ulong>();
   
   for (int i = 0; i < ShortRequestList.Count(); i++) {
      MqlTradeRequestWrapper *TempRequest;
      ShortRequestList.TryGetValue(i, TempRequest);
      AllShortOrderTickets.Add(GetOrderTicket(TempRequest));
   }
   return AllShortOrderTickets;
}

//--- Helper Functions: GetUnhedgedOrderTickets/GetHedgedOrderTickets
double ConstructTradePool::GetTotalLongVolume(void) {
   double TotalLongVolume = 0;
   
   CArrayList<ulong> *AllLongOrderTickets = GetAllLongOrderTickets();
   for (int i = 0; i < AllLongOrderTickets.Count(); i++) {
      ulong LongOrderTicketTemp;
      AllLongOrderTickets.TryGetValue(i, LongOrderTicketTemp);
      TotalLongVolume += GetOrderVolume(LongOrderTicketTemp);
   }
   delete AllLongOrderTickets;
   return TotalLongVolume;
}

//--- Helper Functions: GetUnhedgedOrderTickets/GetHedgedOrderTickets
double ConstructTradePool::GetTotalShortVolume(void) {
   double TotalShortVolume = 0;
   
   CArrayList<ulong> *AllShortOrderTickets = GetAllShortOrderTickets();
   for (int i = 0; i < AllShortOrderTickets.Count(); i++) {
      ulong ShortOrderTicketTemp;
      AllShortOrderTickets.TryGetValue(i, ShortOrderTicketTemp);
      TotalShortVolume += GetOrderVolume(ShortOrderTicketTemp);
   }
   delete AllShortOrderTickets;
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
   if (IsBuyRequest(InputRequest)) {
      return GetPnLBuyRequestInPts(InputRequest);
   }
   if (IsSellRequest(InputRequest)) {
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
   if (IsBuyRequest(InputRequest)) {
      return GetPositiveSlippageBuyRequestInPts(InputRequest);
   }
   if (IsSellRequest(InputRequest)) {
      return GetPositiveSlippageSellRequestInPts(InputRequest);
   }
   return 0;
}

//--- Helper Functions: GetPositiveSlippagePnL
int ConstructTradePool::GetPositiveSlippageBuyRequestInPts(MqlTradeRequestWrapper *InputRequest) {
   if (InputRequest.action == TRADE_ACTION_DEAL) {
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
   if (InputRequest.action == TRADE_ACTION_PENDING) {
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
double ConstructTradePool::GetOrderVolume(ulong InputOrderTicket) {
   MqlTradeRequestWrapper *RequestTemp;
   
   //--- Check From LongRequestList
   for (int i = 0; i < LongRequestList.Count(); i++) {
      LongRequestList.TryGetValue(i, RequestTemp);
      if (IsRequestMatchesOrderTicket(RequestTemp, InputOrderTicket)) {
         return GetRequestVolume(RequestTemp);
      }
   }
   
   //--- Check From ShortRequestList
   for (int i = 0; i < ShortRequestList.Count(); i++) {
      ShortRequestList.TryGetValue(i, RequestTemp);
      if (IsRequestMatchesOrderTicket(RequestTemp, InputOrderTicket)) {
         return GetRequestVolume(RequestTemp);
      }
   }
   return 0;
}

//--- Helper Functions: GetOrderVolume
bool ConstructTradePool::IsRequestMatchesOrderTicket(MqlTradeRequestWrapper *InputRequest, ulong InputOrderTicket) {
   return GetTradeResult(InputRequest).order == InputOrderTicket;
}

//--- Auxilary Functions: Get Raw Info
ENUM_ORDER_TYPE ConstructTradePool::GetOrderType(ulong InputOrderTicket) {
   return (ENUM_ORDER_TYPE) HistoryOrderGetInteger(InputOrderTicket, ORDER_TYPE);
}

//--- Auxilary Functions: Get Raw Info
double ConstructTradePool::GetDesiredPrice(MqlTradeRequestWrapper *InputRequest) {
   if (IsBuyStopLimitRequest(InputRequest) || IsSellStopLimitRequest(InputRequest)) {
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
   if (IsMarketRequest(InputRequest)) {
      return GetMarketDealTicket(InputRequest);
   }
   if (IsPendingRequest(InputRequest)) {
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

//--- Auxilary Functions: Get Raw Info
bool ConstructTradePool::IsMarketRequest(MqlTradeRequestWrapper *InputRequest) {
   return IsRawMarketRequest(InputRequest);
}

//--- Auxilary Functions: Get Raw Info
bool ConstructTradePool::IsPendingRequest(MqlTradeRequestWrapper *InputRequest) {
   return IsLimitRequest(InputRequest) || IsStopRequest(InputRequest) || IsStopLimitRequest(InputRequest);
}

//--- Auxilary Functions: Get Raw Info
bool ConstructTradePool::IsBuyRequest(MqlTradeRequestWrapper *InputRequest) {
   return IsBuyMarketRequest(InputRequest)   ||
          IsBuyLimitRequest(InputRequest)    ||
          IsBuyStopRequest(InputRequest)     ||
          IsBuyStopLimitRequest(InputRequest);
}

//--- Auxilary Functions: Get Raw Info
bool ConstructTradePool::IsBuyMarketRequest(MqlTradeRequestWrapper *InputRequest) {
   return InputRequest.type == ORDER_TYPE_BUY;
}

//--- Auxilary Functions: Get Raw Info
bool ConstructTradePool::IsBuyLimitRequest(MqlTradeRequestWrapper *InputRequest) {
   return InputRequest.type == ORDER_TYPE_BUY_LIMIT;
}

//--- Auxilary Functions: Get Raw Info
bool ConstructTradePool::IsBuyStopRequest(MqlTradeRequestWrapper *InputRequest) {
   return InputRequest.type == ORDER_TYPE_BUY_STOP;
}

//--- Auxilary Functions: Get Raw Info
bool ConstructTradePool::IsBuyStopLimitRequest(MqlTradeRequestWrapper *InputRequest) {
   return InputRequest.type == ORDER_TYPE_BUY_STOP_LIMIT;
}

//--- Auxilary Functions: Get Raw Info
bool ConstructTradePool::IsSellRequest(MqlTradeRequestWrapper *InputRequest) {
   return IsSellMarketRequest(InputRequest)   ||
          IsSellLimitRequest(InputRequest)    ||
          IsSellStopRequest(InputRequest)     ||
          IsSellStopLimitRequest(InputRequest);
}

//--- Auxilary Functions: Get Raw Info
bool ConstructTradePool::IsSellMarketRequest(MqlTradeRequestWrapper *InputRequest) {
   return InputRequest.type == ORDER_TYPE_SELL;
}

//--- Auxilary Functions: Get Raw Info
bool ConstructTradePool::IsSellLimitRequest(MqlTradeRequestWrapper *InputRequest) {
   return InputRequest.type == ORDER_TYPE_SELL_LIMIT;
}

//--- Auxilary Functions: Get Raw Info
bool ConstructTradePool::IsSellStopRequest(MqlTradeRequestWrapper *InputRequest) {
   return InputRequest.type == ORDER_TYPE_SELL_STOP;
}

//--- Auxilary Functions: Get Raw Info
bool ConstructTradePool::IsSellStopLimitRequest(MqlTradeRequestWrapper *InputRequest) {
   return InputRequest.type == ORDER_TYPE_SELL_STOP_LIMIT;
}