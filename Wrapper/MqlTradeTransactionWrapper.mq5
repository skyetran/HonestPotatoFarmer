#property strict

#include "../Wrapper/MqlTradeTransactionWrapper.mqh"

//--- Default Constructor
MqlTradeTransactionWrapper::MqlTradeTransactionWrapper(void) { }

//--- Main Constructor
MqlTradeTransactionWrapper::MqlTradeTransactionWrapper(MqlTradeTransaction &trans) {
   deal              = trans.deal;
   order             = trans.order;
   symbol            = trans.symbol;
   type              = trans.type;
   order_type        = trans.order_type;
   order_state       = trans.order_state;
   deal_type         = trans.deal_type;
   time_type         = trans.time_type;
   time_expiration   = trans.time_expiration;
   price             = trans.price;
   price_trigger     = trans.price_trigger;
   price_sl          = trans.price_sl;
   price_tp          = trans.price_tp;
   volume            = trans.volume;
   position          = trans.position;
   position_by       = trans.position_by;
}

//--- Revert Back To Struct Format
void MqlTradeTransactionWrapper::Unwrap(MqlTradeTransaction &trans) {
   trans.deal              = deal;
   trans.order             = order;
   trans.symbol            = symbol;
   trans.type              = type;
   trans.order_type        = order_type;
   trans.order_state       = order_state;
   trans.deal_type         = deal_type;
   trans.time_type         = time_type;
   trans.time_expiration   = time_expiration;
   trans.price             = price;
   trans.price_trigger     = price_trigger;
   trans.price_sl          = price_sl;
   trans.price_tp          = price_tp;
   trans.volume            = volume;
   trans.position          = position;
   trans.position_by       = position_by;
}