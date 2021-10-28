#ifndef CONSTRUCT_TRADE_POOL_H
#define CONSTRUCT_TRADE_POOL_H

#include <Generic\ArrayList.mqh>
#include <Generic\HashMap.mqh>

#include "../General/GeneralSettings.mqh"
#include "../General/IndicatorProcessor.mqh"
#include "../General/PositionManagementHyperParameters.mqh"
#include "../Wrapper/MqlTradeRequestWrapper.mqh"
#include "../Wrapper/MqlTradeResultWrapper.mqh"
#include "../MarketWatcher.mqh"

enum ENUM_POOLING_STATUS {
   ALREADY_POOL = 0,
   UNPOOL       = 1,
};

class ConstructTradePool
{
public:
   //--- Main Constructor
   ConstructTradePool(void);
   
   //--- Destructor
   ~ConstructTradePool(void);
   
   //--- Operations
   void AddNewRequest(CArrayList<MqlTradeRequestWrapper*> *InputRequestList);
   void AddNewRequest(MqlTradeRequestWrapper *InputRequest);
   
   CArrayList<MqlTradeRequestWrapper*> *PoolRawMarketRequest(void);
   CArrayList<MqlTradeRequestWrapper*> *PoolLimitRequest(void);
   CArrayList<MqlTradeRequestWrapper*> *PoolStopLimitRequest(void);
   CArrayList<MqlTradeRequestWrapper*> *PoolStopRequest(void);
   
   CArrayList<MqlTradeRequestWrapper*> *GetLongRequest(void);
   CArrayList<MqlTradeRequestWrapper*> *GetShortRequest(void);
   
   void LogExecutedRequest(MqlTradeRequestWrapper *InputRequest, MqlTradeResultWrapper *InputResult);
   
   void MakeFullyHedged(void);
   
   //--- Getters   
   double GetCurrentPnL(void);
   double GetPositiveSlippagePnL(void);
   
   bool IsFullyHedged(void);
   
private:
   //--- External Objects
   IndicatorProcessor *IP;
   PositionManagementHyperParameters *PMHP;
   GeneralSettings *GS;
   
   //--- Session History
   CHashMap<MqlTradeRequestWrapper*, MqlTradeResultWrapper*> *RequestResultSession;
   CHashMap<MqlTradeRequestWrapper*, ENUM_POOLING_STATUS>    *RequestSessionExpiration;

   //--- Current
   CArrayList<MqlTradeRequestWrapper*> *RawMarketRequestList;
   CArrayList<MqlTradeRequestWrapper*> *LimitRequestList;
   CArrayList<MqlTradeRequestWrapper*> *StopLimitRequestList;
   CArrayList<MqlTradeRequestWrapper*> *StopRequestList;
   CArrayList<MqlTradeRequestWrapper*> *LongRequestList;
   CArrayList<MqlTradeRequestWrapper*> *ShortRequestList;
   
   //--- Helper Functions: AddNewRequest
   void AddNewRequestByOrderType(MqlTradeRequestWrapper *InputRequest);
   void AddNewRequestByOrderDirection(MqlTradeRequestWrapper *InputRequest);
   
   bool IsRawMarketRequest(MqlTradeRequestWrapper *InputRequest);
   bool IsLimitRequest(MqlTradeRequestWrapper *InputRequest);
   bool IsStopLimitRequest(MqlTradeRequestWrapper *InputRequest);
   bool IsStopRequest(MqlTradeRequestWrapper *InputRequest);
   
   //--- Helper Functions: PoolRawMarketRequest/PoolLimitRequest/PoolStopLimitRequest/PoolStopRequest
   CArrayList<MqlTradeRequestWrapper*> *GetUnpoolRequests(CArrayList<MqlTradeRequestWrapper*> *RequestList);
   bool IsRequestUnpool(MqlTradeRequestWrapper *InputRequest);
   bool IsRequestAlreadyPool(MqlTradeRequestWrapper *InputRequest);
   ENUM_POOLING_STATUS GetPoolingStatus(MqlTradeRequestWrapper *InputRequest);
   void SetRequestPoolingStatusToAlreadyPool(MqlTradeRequestWrapper *InputRequest);
   
   //--- Helper Functions: MakeFullyHedged
   void MakeNetLongFullyHedged(void);
   void MakeNetShortFullyHedged(void);
   string GetRandomString(void);
   
   bool IsNetLong(void);
   bool IsNetShort(void);
   
   double GetUnhedgedNetVolume(void);
   double GetHedgedNetVolume(void);
   
   //--- Helper Functions: Volume-Related Functions
   double GetTotalLongVolume(void);
   double GetTotalShortVolume(void);
   
   //--- Helper Functions: GetCurrentPnL
   int  GetPnLInPts(MqlTradeRequestWrapper *InputRequest);
   int  GetPnLBuyRequestInPts(MqlTradeRequestWrapper* InputRequest);
   int  GetPnLSellRequestInPts(MqlTradeRequestWrapper* InputRequest);
   
   //--- Helper Functions: GetPositiveSlippagePnL
   int  GetPositiveSlippageInPts(MqlTradeRequestWrapper *InputRequest);
   
   int  GetPositiveSlippageBuyRequestInPts(MqlTradeRequestWrapper *InputRequest);
   int  GetPositiveSlippageBuyRequestMarketOrderInPts(MqlTradeRequestWrapper *InputRequest);
   bool IsBullishState(void);
   int  GetPositiveSlippageBuyRequestPendingOrderInPts(MqlTradeRequestWrapper *InputRequest);   
   
   int  GetPositiveSlippageSellRequestInPts(MqlTradeRequestWrapper *InputRequest);
   int  GetPositiveSlippageSellRequestMarketOrderInPts(MqlTradeRequestWrapper *InputRequest);
   bool IsBearishState(void);
   int  GetPositiveSlippageSellRequestPendingOrderInPts(MqlTradeRequestWrapper *InputRequest);     
   
   //--- Auxilary Functions
   bool IsOrderFilled(MqlTradeRequestWrapper *InputRequest);
   void  UpdateHistoryRange(void);
   
   //--- Auxilary Functions: Get Raw Info
   ENUM_ORDER_STATE GetOrderState(MqlTradeRequestWrapper *InputRequest);
   ulong            GetOrderTicket(MqlTradeRequestWrapper *InputRequest);
   
   MqlTradeResultWrapper *GetTradeResult(MqlTradeRequestWrapper *InputRequest);  
   
   double          GetRequestVolume(MqlTradeRequestWrapper *InputRequest);
   double          GetOrderVolume(ulong InputOrderTicket);
   ENUM_ORDER_TYPE GetOrderType(ulong InputOrderTicket);
   
   bool            IsRequestMatchesOrderTicket(MqlTradeRequestWrapper *InputRequest, ulong InputOrderTicket);
   
   double GetDesiredPrice(MqlTradeRequestWrapper *InputRequest);
   double GetRealPrice(MqlTradeRequestWrapper *InputRequest);
   
   ulong  GetDealTicket(MqlTradeRequestWrapper *InputRequest);
   double GetDealPrice(MqlTradeRequestWrapper *InputRequest);
   
   ulong GetMarketDealTicket(MqlTradeRequestWrapper *InputRequest);
   ulong GetPendingDealTicket(MqlTradeRequestWrapper *InputRequest);
   
   bool IsMarketRequest(MqlTradeRequestWrapper *InputRequest);
   bool IsPendingRequest(MqlTradeRequestWrapper *InputRequest);
   
   bool IsBuyRequest(MqlTradeRequestWrapper *InputRequest);
   bool IsBuyMarketRequest(MqlTradeRequestWrapper *InputRequest);
   bool IsBuyLimitRequest(MqlTradeRequestWrapper *InputRequest);
   bool IsBuyStopRequest(MqlTradeRequestWrapper *InputRequest);
   bool IsBuyStopLimitRequest(MqlTradeRequestWrapper *InputRequest);
   
   bool IsSellRequest(MqlTradeRequestWrapper *InputRequest);
   bool IsSellMarketRequest(MqlTradeRequestWrapper *InputRequest);
   bool IsSellLimitRequest(MqlTradeRequestWrapper *InputRequest);
   bool IsSellStopRequest(MqlTradeRequestWrapper *InputRequest);
   bool IsSellStopLimitRequest(MqlTradeRequestWrapper *InputRequest);
};

#endif