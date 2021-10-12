#property strict

#include "../Wrapper/MqlTradeResultWrapper.mqh"

//--- Default Constructor
MqlTradeResultWrapper::MqlTradeResultWrapper(void) { }

//--- Main Constructor
MqlTradeResultWrapper::MqlTradeResultWrapper(MqlTradeResult &result) {
   MqlTradeResultWrapper(result, 1);
}

//--- Main Constructor
MqlTradeResultWrapper::MqlTradeResultWrapper(MqlTradeResult &result, const double InputVolumeRatio) {
   retcode           = result.retcode;
   deal              = result.deal;
   order             = result.order;
   volume            = result.volume;
   price             = result.price;
   bid               = result.bid;
   ask               = result.ask;
   comment           = result.comment;
   request_id        = result.request_id;
   retcode_external  = result.retcode_external;
   volume_ratio      = InputVolumeRatio;
}

//--- Revert Back To Struct State
void MqlTradeResultWrapper::Unwrap(MqlTradeResult &result) {
   result.retcode          = retcode;
   result.deal             = deal;
   result.order            = order;
   result.volume           = GetRealVolume();
   result.price            = price;
   result.bid              = bid;
   result.ask              = ask;
   result.comment          = comment;
   result.request_id       = request_id;
   result.retcode_external = (int) retcode_external;
}

//--- Getters
double MqlTradeResultWrapper::GetRealVolume(void) const {
   return NormalizeDouble(volume * volume_ratio, 2);
}