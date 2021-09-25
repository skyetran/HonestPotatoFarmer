#ifndef COMBINED_TRADE_REQUEST_H
#define COMBINED_TRADE_REQUEST_H

#include <Generic\ArrayList.mqh>

#include "../Wrapper/MqlTradeRequestWrapper.mqh"
#include "../Wrapper/MqlTradeResultWrapper.mqh"
#include "ConstructTradePool.mqh"

class CombinedTradeRequest
{
public:
   //--- Default Constructor
   CombinedTradeRequest(void);
   
   //--- Main Constructor
   CombinedTradeRequest(MqlTradeRequestWrapper* NewRequest);
   
   //--- Destructor
   ~CombinedTradeRequest(void);
   
   //--- Add Trade Pool To Manage
   void AddTradePool(ConstructTradePool *InputTradePool, double Volume);
   
   //--- Getters
   double                  GetEntryPrice(void)           const;
   MqlTradeRequestWrapper *GetCombinedTradeRequest(void) const;
   
   //--- Setters
   void SetCombinedTradeResult(MqlTradeResultWrapper* TradeResult);
   
private:
   MqlTradeRequestWrapper *CombinedRequest;
   MqlTradeResultWrapper  *CombinedResult;
   
   //--- List Of Trade Pool To Send Trade Result To
   CArrayList<ConstructTradePool*> TradePoolList;
   CArrayList<double> VolumeRatio;
};

#endif