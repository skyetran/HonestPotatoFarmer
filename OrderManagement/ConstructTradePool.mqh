#ifndef CONSTRUCT_TRADE_POOL_H
#define CONSTRUCT_TRADE_POOL_H

#include <Generic\ArrayList.mqh>
#include <Generic\HashMap.mqh>

#include "../General/IndicatorProcessor.mqh"
#include "../General/PositionManagementHyperParameters.mqh"
#include "../Wrapper/MqlTradeRequestWrapper.mqh"
#include "../Wrapper/MqlTradeResultWrapper.mqh"
#include "../MarketWatcher.mqh"

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
   
   void LogExecutedRequest(MqlTradeRequestWrapper *InputRequest, MqlTradeResultWrapper *InputResult);
   
   //--- Getters
   double             GetAbsRealUnhedgedNetVolume(void);
   double             GetAbsUnhedgedNetVolume(void);
   double             GetAbsHedgedNetVolume(void);
   double             GetRealUnhedgedNetVolume(void);
   double             GetUnhedgedNetVolume(void);
   double             GetHedgedNetVolume(void);
   CArrayList<ulong> *GetUnhedgedOrderTickets(void);
   CArrayList<ulong> *GetHedgedOrderTickets(void);
   double             GetCurrentPnL(void);
   double             GetPositiveSlippagePnL(void);
   
   bool IsNetLong(void);
   bool IsNetShort(void);
   bool IsFullyHedged(void);
   
private:
   //--- External Objects
   IndicatorProcessor *IP;
   PositionManagementHyperParameters *PMHP;
   
   //--- Session History
   CHashMap<MqlTradeRequestWrapper*, MqlTradeResultWrapper*> *RequestResultSession;

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
   
   //--- Helper Functions: GetAbsNetVolume/GetNetVolume
   double GetNetVolume(CArrayList<ulong> *InputOrderTickets);
   bool   IsLongOrder(ulong InputOrderTicket);
   bool   IsShortOrder(ulong InputOrderTicket);
   
   //--- Helper Functions: GetUnhedgedOrderTickets/GetHedgedOrderTickets
   CArrayList<ulong> *GetHedgedOrderTicketsOfNetLongConstruct(void);
   CArrayList<ulong> *GetHedgedOrderTicketsOfNetShortConstruct(void);
   CArrayList<ulong> *GetHedgedOrderTicketsOfFullyHedgedConstruct(void);
   
   CArrayList<ulong> *GetAllOrderTickets(void);
   CArrayList<ulong> *GetAllLongOrderTickets(void);
   CArrayList<ulong> *GetAllShortOrderTickets(void);
   
   double             GetTotalLongVolume(void);
   double             GetTotalShortVolume(void);
   
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