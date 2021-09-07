#property strict

#include "../Wrapper/MqlTradeCheckResultWrapper.mqh"

//--- Default Constructor
MqlTradeCheckResultWrapper::MqlTradeCheckResultWrapper(void) { }

//--- Main Constructor
MqlTradeCheckResultWrapper::MqlTradeCheckResultWrapper(MqlTradeCheckResult &result) {
   retcode      = result.retcode;
   balance      = result.balance;
   equity       = result.equity;
   profit       = result.profit;
   margin       = result.margin;
   margin_free  = result.margin_free;
   margin_level = result.margin_level;
   comment      = result.comment;
}

//--- Revert Back To Struct Format
void MqlTradeCheckResultWrapper::Unwrap(MqlTradeCheckResult &result) {
   result.retcode       = retcode;
   result.balance       = balance;
   result.equity        = equity;
   result.profit        = profit;
   result.margin        = margin;
   result.margin_free   = margin_free;
   result.margin_level  = margin_level;
   result.comment       = comment;
}