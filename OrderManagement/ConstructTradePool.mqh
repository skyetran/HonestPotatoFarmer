#ifndef CONSTRUCT_TRADE_POOL_H
#define CONSTRUCT_TRADE_POOL_H

#include <Generic\ArrayList.mqh>

#include "../Wrapper/MqlTradeRequestWrapper.mqh"

class ConstructTradePool
{
public:
   //--- Main Constructor
   ConstructTradePool(void);
   
   //--- Destructor
   ~ConstructTradePool(void);
   
   //--- Market Order Has The Highest Priority
   //--- Sudo Limit Orders: Place Market Order At The Lower Price (Slippage Deducted)
   //--- Pending Orders: Unchanged regardless Of Final Market Orders; Calculated Relative To The Capstone Level (NOT SUDO-LIMIT LEVEL)
   void AddRequest(MqlTradeRequestWrapper *Request);
   void Reset(void);
   
   //--- Getters
   CArrayList<MqlTradeRequestWrapper*> *GetMarketOrderList(void);
   CArrayList<MqlTradeRequestWrapper*> *GetPendingOrderList(void);
   
private:
   //--- Market Orders:  Initial Entries (Sudo Limit Orders)
   //--- Pending Orders: Stop-Limit Orders For Stop Loss & Retraced Orders; Limit Orders For Take Profit
   CArrayList<MqlTradeRequestWrapper*> *MarketOrderList, *PendingOrderList;
   
   //--- Order Type Classification
   bool IsMarketOrderRequest(MqlTradeRequestWrapper *Request);
   bool IsPendingOrderRequest(MqlTradeRequestWrapper *Request);
   
   void AddMarketOrderRequest(MqlTradeRequestWrapper *Request);
   void AddPendingOrderRequest(MqlTradeRequestWrapper *Request);
};

#endif