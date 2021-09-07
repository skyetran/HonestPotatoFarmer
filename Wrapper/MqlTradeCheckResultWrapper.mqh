#ifndef MQL_TRADE_CHECK_RESULT_H
#define MQL_TRADE_CHECK_RESULT_H

class MqlTradeCheckResultWrapper
{
public:
   //--- Default Constructor
   MqlTradeCheckResultWrapper(void);
   
   //--- Main Constructor
   MqlTradeCheckResultWrapper(MqlTradeCheckResult &result);
   
   //--- Revert Back To Struct Format
   void Unwrap(MqlTradeCheckResult &result);
   
   uint         retcode;
   double       balance;
   double       equity;
   double       profit;
   double       margin;
   double       margin_free;
   double       margin_level;
   string       comment;

};

#endif