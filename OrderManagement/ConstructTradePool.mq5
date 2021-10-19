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

//--- Operations
CArrayList<MqlTradeRequestWrapper*> *ConstructTradePool::PoolRawMarketRequest(void) const { return RawMarketRequestList; }
CArrayList<MqlTradeRequestWrapper*> *ConstructTradePool::PoolLimitRequest(void)     const { return LimitRequestList;     }
CArrayList<MqlTradeRequestWrapper*> *ConstructTradePool::PoolStopLimitRequest(void) const { return StopLimitRequestList; }
CArrayList<MqlTradeRequestWrapper*> *ConstructTradePool::PoolStopRequest(void)      const { return StopRequestList;      }

//--- Operations
void ConstructTradePool::LogExecutedRequest(MqlTradeRequestWrapper *InputRequest, MqlTradeResultWrapper *InputResult) {
   RequestResultSession.Add(InputRequest, InputResult);
}

//--- Getters
CArrayList<MqlTradeResultWrapper*> *ConstructTradePool::GetFullDealList(void) const {
   CArrayList<MqlTradeResultWrapper*> *FullDealList = new CArrayList<MqlTradeResultWrapper*>();
   
   return FullDealList;
}

//--- Getters
CArrayList<MqlTradeResultWrapper*> *ConstructTradePool::GetNetDealList(void) const {
   CArrayList<MqlTradeResultWrapper*> *NetDealList = new CArrayList<MqlTradeResultWrapper*>();
   
   return NetDealList;
}

//--- Getters
double ConstructTradePool::GetCurrentPnL(void) {
   double PnL = 0;
   
   MqlTradeRequestWrapper *RequestList[];
   MqlTradeResultWrapper  *ResultList[];
   RequestResultSession.CopyTo(RequestList, ResultList);
   
   for (int i = 0; i < ArraySize(RequestList); i++) {
      if (IsOrderFilled(RequestList[i])) {
         int MinLotSizeMultiple = (int) (ResultList[i].GetRealVolume() / GetMinLotSize());
         //PnL += 
      }
   }
   return PnL;
}

//--- Helper Functions: GetCurrentPnL
int ConstructTradePool::GetPnLInPts(MqlTradeRequestWrapper *InputRequest) {
   if (IsBuyRequest(InputRequest)) {
   
   }
   if (IsSellRequest(InputRequest)) {
   
   }
   return 0;
}

//--- Getters
double ConstructTradePool::GetPositiveSlippagePnL(void) {
   double SlippagePnL = 0;
   
   MqlTradeRequestWrapper *RequestList[];
   MqlTradeResultWrapper  *ResultList[];
   RequestResultSession.CopyTo(RequestList, ResultList);
   
   for (int i = 0; i < ArraySize(RequestList); i++) {
      if (IsOrderFilled(RequestList[i])) {
         int MinLotSizeMultiple = (int) (ResultList[i].GetRealVolume() / GetMinLotSize());
         SlippagePnL += GetPositiveSlippageInPts(RequestList[i]) * GetPointValuePerMinStandardLot() * MinLotSizeMultiple;
      }
   }
   return SlippagePnL;
}

//--- Helper Functions: GetPositiveSlippagePnL
int ConstructTradePool::GetPositiveSlippageInPts(MqlTradeRequestWrapper *InputRequest) {
   if (IsBuyRequest(InputRequest)) {
      return GetPositiveSlippageBuyRequest(InputRequest);
   }
   if (IsSellRequest(InputRequest)) {
      return GetPositiveSlippageSellRequest(InputRequest);
   }
   return 0;
}

//--- Helper Functions: GetPositiveSlippagePnL
int ConstructTradePool::GetPositiveSlippageBuyRequest(MqlTradeRequestWrapper *InputRequest) {
   if (InputRequest.action == TRADE_ACTION_DEAL) {
      return GetPositiveSlippageBuyRequestMarketOrder(InputRequest);
   }
   return GetPositiveSlippageBuyRequestPendingOrder(InputRequest);
}

//--- Helper Functions: GetPositiveSlippagePnL
int ConstructTradePool::GetPositiveSlippageBuyRequestMarketOrder(MqlTradeRequestWrapper *InputRequest) {
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
int ConstructTradePool::GetPositiveSlippageBuyRequestPendingOrder(MqlTradeRequestWrapper *InputRequest) {
   return PriceToPointCvt(GetRealPrice(InputRequest) - GetDesiredPrice(InputRequest));
}

//--- Helper Functions: GetPositiveSlippagePnL
int ConstructTradePool::GetPositiveSlippageSellRequest(MqlTradeRequestWrapper *InputRequest) {
   if (InputRequest.action == TRADE_ACTION_PENDING) {
      return GetPositiveSlippageSellRequestMarketOrder(InputRequest);
   }
   return GetPositiveSlippageSellRequestPendingOrder(InputRequest);
}

//--- Helper Functions: GetPositiveSlippagePnL
int ConstructTradePool::GetPositiveSlippageSellRequestMarketOrder(MqlTradeRequestWrapper *InputRequest) {
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
int ConstructTradePool::GetPositiveSlippageSellRequestPendingOrder(MqlTradeRequestWrapper *InputRequest) {
   return PriceToPointCvt(GetDesiredPrice(InputRequest) - GetRealPrice(InputRequest));
}

//--- Getters
bool ConstructTradePool::IsNetLong(void) const {
   return false;
}

//--- Getters
bool ConstructTradePool::IsNetShort(void) const {
   return false;
}

//--- Getters
bool ConstructTradePool::IsFullHedged(void) const {
   return false;
}

//--- Auxilary Functions
bool ConstructTradePool::IsOrderPlaced(MqlTradeRequestWrapper *InputRequest) {
   return GetOrderState(InputRequest) == ORDER_STATE_PLACED;
}

//--- Auxilary Functions
bool ConstructTradePool::IsOrderFilled(MqlTradeRequestWrapper *InputRequest) {
   return GetOrderState(InputRequest) == ORDER_STATE_FILLED;
}

//--- Auxilary Functions: Get Raw Info
MqlTradeResultWrapper *ConstructTradePool::GetTradeResult(MqlTradeRequestWrapper *InputRequest) {
   MqlTradeResultWrapper *Result;
   RequestResultSession.TryGetValue(InputRequest, Result);
   return Result;
}

//--- Auxilary Functions: Get Raw Info
ulong ConstructTradePool::GetOrderTicket(MqlTradeRequestWrapper *InputRequest) {
   return GetTradeResult(InputRequest).order;
}

//--- Auxilary Functions: Get Raw Info
ENUM_ORDER_STATE ConstructTradePool::GetOrderState(MqlTradeRequestWrapper *InputRequest) {
   if (HistoryOrderSelect(GetOrderTicket(InputRequest))) {
      return (ENUM_ORDER_STATE) OrderGetInteger(ORDER_STATE);
   }
   return ORDER_STATE_REJECTED;
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
   HistoryOrderSelect(GetOrderTicket(InputRequest));
   return HistoryOrderGetDouble(GetOrderTicket(InputRequest), ORDER_PRICE_OPEN);
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