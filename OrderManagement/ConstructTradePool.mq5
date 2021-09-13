#property strict

#include "../OrderManagement/ConstructTradePool.mqh"

//--- Main Constructor
ConstructTradePool::ConstructTradePool(void) {
   MarketOrderList  = new CArrayList<MqlTradeRequestWrapper*>();
   PendingOrderList = new CArrayList<MqlTradeRequestWrapper*>();
}

//--- Destructor
ConstructTradePool::~ConstructTradePool(void) {
   MarketOrderList.Clear();
   PendingOrderList.Clear();
   delete MarketOrderList;
   delete PendingOrderList;
}

void ConstructTradePool::AddRequest(MqlTradeRequestWrapper *Request) {
   if (IsMarketOrderRequest(Request)) {
      AddMarketOrderRequest(Request);
   } else if (IsPendingOrderRequest(Request)) {
      AddPendingOrderRequest(Request);
   }
}

bool ConstructTradePool::IsMarketOrderRequest(MqlTradeRequestWrapper *Request) {
   return Request.action == TRADE_ACTION_DEAL;
}

bool ConstructTradePool::IsPendingOrderRequest(MqlTradeRequestWrapper *Request) {
   return Request.action == TRADE_ACTION_PENDING;
}

void ConstructTradePool::AddMarketOrderRequest(MqlTradeRequestWrapper *Request) {
   MarketOrderList.Add(Request);
}

void ConstructTradePool::AddPendingOrderRequest(MqlTradeRequestWrapper *Request) {
   PendingOrderList.Add(Request);
}

void ConstructTradePool::Reset(void) {
   MarketOrderList.Clear();
   PendingOrderList.Clear();
}