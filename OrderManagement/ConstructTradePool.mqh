#ifndef CONSTRUCT_TRADE_POOL_H
#define CONSTRUCT_TRADE_POOL_H

#include <Generic\ArrayList.mqh>

#include "../Wrapper/MqlTradeRequestWrapper.mqh"
#include "../Wrapper/MqlTradeResultWrapper.mqh"

class ConstructTradePool
{
public:
   //--- Main Constructor
   ConstructTradePool(void);
   
   //--- Destructor
   //~ConstructTradePool(void);
   
   //--- Market Order Has The Highest Priority
   //--- Sudo Limit Orders: Place Market Order At The Lower Price (Slippage Deducted)
   //--- Pending Orders: Unchanged regardless Of Final Market Orders; Calculated Relative To The Capstone Level (NOT SUDO-LIMIT LEVEL)
   void AddRequest(MqlTradeRequestWrapper *Request);
   void ResetRequest(void);
   
   void AddMarketOrderResult(MqlTradeRequestWrapper *Result);
   void AddPendingOrderResult(MqlTradeRequestWrapper *Result);
   
   //--- Getters
   CArrayList<MqlTradeRequestWrapper*> *GetMarketOrderRequestList(void);
   CArrayList<MqlTradeRequestWrapper*> *GetPendingOrderRequestList(void);
   CArrayList<MqlTradeResultWrapper*>  *GetMarketOrderResultList(void);
   CArrayList<MqlTradeResultWrapper*>  *GetPendingOrderResultList(void);
   
   bool GetFillTradePoolFlag(void) const;
   
   //--- Setters
   void SetFillTradePoolFlag(bool InputFlag);
   
private:
   bool FillTradePoolFlag;
   
   //--- Market Orders:  Initial Entries (Sudo Limit Orders)
   //--- Pending Orders: Stop-Limit Orders For Stop Loss & Retraced Orders; Limit Orders For Take Profit
   CArrayList<MqlTradeRequestWrapper*> *MarketOrderRequestList, *PendingOrderRequestList;
   CArrayList<MqlTradeResultWrapper*>  *MarketOrderResultList,  *PendingOrderResultList;

   //--- Order Type Classification
   bool IsMarketOrderRequest(MqlTradeRequestWrapper *Request);
   bool IsPendingOrderRequest(MqlTradeRequestWrapper *Request);

   void AddMarketOrderRequest(MqlTradeRequestWrapper *Request);
   void AddPendingOrderRequest(MqlTradeRequestWrapper *Request);
};

#endif