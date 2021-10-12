#ifndef CONSTRUCT_TRADE_POOL_H
#define CONSTRUCT_TRADE_POOL_H

#include <Generic\ArrayList.mqh>
#include <Generic\HashMap.mqh>
#include <Trade\OrderInfo.mqh>

#include "../General/IndicatorProcessor.mqh"
#include "../General/PositionManagementHyperParameters.mqh"
#include "../Wrapper/MqlTradeRequestWrapper.mqh"
#include "../Wrapper/MqlTradeResultWrapper.mqh"

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
   
   CArrayList<MqlTradeRequestWrapper*> *PoolRawMarketRequest(void) const;
   CArrayList<MqlTradeRequestWrapper*> *PoolLimitRequest(void)     const;
   CArrayList<MqlTradeRequestWrapper*> *PoolStopLimitRequest(void) const;
   CArrayList<MqlTradeRequestWrapper*> *PoolStopRequest(void)      const;
   
   void LogExecutedRequest(MqlTradeRequestWrapper *InputRequest, MqlTradeResultWrapper *InputResult);
   
   //--- Getters
   CArrayList<MqlTradeResultWrapper*> *GetFullDealList(void) const;
   CArrayList<MqlTradeResultWrapper*> *GetNetDealList(void)  const;
   double                              GetCurrentPnL(void);
   double                              GetPositiveSlippagePnL(void);
   
   bool IsNetLong(void)    const;
   bool IsNetShort(void)   const;
   bool IsFullHedged(void) const;
   
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
   
   //--- Helper Functions: AddNewRequest
   bool IsRawMarketRequest(MqlTradeRequestWrapper *InputRequest);
   bool IsLimitRequest(MqlTradeRequestWrapper *InputRequest);
   bool IsStopLimitRequest(MqlTradeRequestWrapper *InputRequest);
   bool IsStopRequest(MqlTradeRequestWrapper *InputRequest);
   
   //--- Helper Functions: GetCurrentPnL
   int  GetPnLInPts(MqlTradeRequestWrapper *InputRequest);
   
   //--- Helper Functions: GetPositiveSlippagePnL
   int  GetPositiveSlippageInPts(MqlTradeRequestWrapper *InputRequest);
   
   int  GetPositiveSlippageBuyRequest(MqlTradeRequestWrapper *InputRequest);
   int  GetPositiveSlippageBuyRequestMarketOrder(MqlTradeRequestWrapper *InputRequest);
   bool IsBullishState(void);
   int  GetPositiveSlippageBuyRequestPendingOrder(MqlTradeRequestWrapper *InputRequest);   
   
   int  GetPositiveSlippageSellRequest(MqlTradeRequestWrapper *InputRequest);
   int  GetPositiveSlippageSellRequestMarketOrder(MqlTradeRequestWrapper *InputRequest);
   bool IsBearishState(void);
   int  GetPositiveSlippageSellRequestPendingOrder(MqlTradeRequestWrapper *InputRequest);     
   
   //--- Auxilary Functions
   bool IsOrderFilled(MqlTradeRequestWrapper *InputRequest);
   
   //--- Auxilary Functions: Get Raw Info
   MqlTradeResultWrapper *GetTradeResult(MqlTradeRequestWrapper *InputRequest);
   
   ENUM_ORDER_STATE GetOrderState(MqlTradeRequestWrapper *InputRequest);
   
   double GetDesiredPrice(MqlTradeRequestWrapper *InputRequest);
   double GetRealPrice(MqlTradeRequestWrapper *InputRequest);
   
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