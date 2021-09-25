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
   ~ConstructTradePool(void);
   
   void AddOrderRequest(MqlTradeRequestWrapper *Request);
   void ResetRequestTradePool(void);
   
   void AddOrderResult(MqlTradeRequestWrapper *Result);
   
   //--- Getters
   CArrayList<MqlTradeRequestWrapper*> *GetOrderRequestList(void) const;
   CArrayList<MqlTradeResultWrapper*>  *GetOrderResultList(void)  const;
   
private:
   CArrayList<MqlTradeRequestWrapper*> *OrderRequestList;
   CArrayList<MqlTradeResultWrapper*>  *OrderResultList;
};

#endif