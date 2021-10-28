#ifndef RAW_ORDER_MANAGER_H
#define RAW_ORDER_MANAGER_H

#include <Generic\ArrayList.mqh>
#include <Generic\HashMap.mqh>

#include "ConstructTradePool.mqh"

class OrderManager
{
public:
   //--- Main Constructor
   OrderManager(void);
   
   //--- Destructor
   ~OrderManager(void);
   
   //--- OnTick Function
   void Managing(void);
   
   //--- Operations
   void AddTradePool(ConstructTradePool *InputTradePool);
   
   CArrayList<MqlTradeRequestWrapper*> *PoolRawMarketRequest(void) const;
   CArrayList<MqlTradeRequestWrapper*> *PoolLimitRequest(void)     const;
   CArrayList<MqlTradeRequestWrapper*> *PoolStopLimitRequest(void) const;
   CArrayList<MqlTradeRequestWrapper*> *PoolStopRequest(void)      const;
   
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

   //--- Subcribed Construct Trade Pools
   CArrayList<ConstructTradePool*> *TradePoolList;
   
   //--- Log Combined Trade Requests
   CHashMap<MqlTradeRequestWrapper*, CArrayList<ConstructTradePool*>*> *CombinedTradeRequestNav;
   CHashMap<MqlTradeRequestWrapper*, CArrayList<double>*>              *CombinedTradeRequestVol;
   
   //--- Scan Over All Trade Pool And Create Combined Trade Request
   void CombineRequest(void);
   
   //--- Send Back Trade Result
   void SendResult(void);
};

#endif