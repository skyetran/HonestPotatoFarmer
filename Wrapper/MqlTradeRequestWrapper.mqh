#ifndef MQL_TRADE_REQUEST_WRAPPER_H
#define MQL_TRADE_REQUEST_WRAPPER_H

class MqlTradeRequestWrapper
{
public:
   //--- Default Constructor
   MqlTradeRequestWrapper(void);
   
   //--- Main Constructor
   MqlTradeRequestWrapper(MqlTradeRequest &request);
   
   //--- Revert Back To Struct Format
   void Unwrap(MqlTradeRequest &request);

   //--- Attributes
   ENUM_TRADE_REQUEST_ACTIONS    action;
   ulong                         magic;
   ulong                         order;
   string                        symbol;
   double                        volume;
   double                        price;
   double                        stoplimit;
   double                        sl;
   double                        tp;
   ulong                         deviation;
   ENUM_ORDER_TYPE               type;
   ENUM_ORDER_TYPE_FILLING       type_filling;
   ENUM_ORDER_TYPE_TIME          type_time;
   datetime                      expiration;
   string                        comment;
   ulong                         position;
   ulong                         position_by;
};

#endif