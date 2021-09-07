#property strict

#include "../Wrapper/MqlTradeRequestWrapper.mqh"

//--- Default Constructor
MqlTradeRequestWrapper::MqlTradeRequestWrapper(void) { }

//--- Main Constructor
MqlTradeRequestWrapper::MqlTradeRequestWrapper(MqlTradeRequest &request) {
   action         = request.action;
   magic          = request.magic;
   order          = request.order;
   symbol         = request.symbol;
   volume         = request.volume;
   price          = request.price;
   stoplimit      = request.stoplimit;
   sl             = request.sl;
   tp             = request.tp;
   deviation      = request.deviation;
   type           = request.type;
   type_filling   = request.type_filling;
   type_time      = request.type_time;
   expiration     = request.expiration;
   comment        = request.comment;
   position       = request.position;
   position_by    = request.position_by;
}

//--- Revert Back To Struct State
void MqlTradeRequestWrapper::Unwrap(MqlTradeRequest &request) {
   request.action       = action;
   request.magic        = magic;
   request.order        = order;
   request.symbol       = symbol;
   request.volume       = volume;
   request.price        = price;
   request.stoplimit    = stoplimit;
   request.sl           = sl;
   request.tp           = tp;
   request.deviation    = deviation;
   request.type         = type;
   request.type_filling = type_filling;
   request.type_time    = type_time;
   request.expiration   = expiration;
   request.comment      = comment;
   request.position     = position;
   request.position_by  = position_by;
}