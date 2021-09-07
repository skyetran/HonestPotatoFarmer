#ifndef MQL_TRADE_RESULT_H
#define MQL_TRADE_RESULT_H

class MqlTradeResultWrapper
{
public:
   //--- Default Constructor
   MqlTradeResultWrapper(void);
   
   //--- Main Constructor
   MqlTradeResultWrapper(MqlTradeResult &result);
   
   //--- Revert Back To Struct Format
   void Unwrap(MqlTradeResult &result);
   
   uint     retcode;
   ulong    deal;
   ulong    order;
   double   volume;
   double   price;
   double   bid;
   double   ask;
   string   comment;
   uint     request_id;
   uint     retcode_external;
};

#endif