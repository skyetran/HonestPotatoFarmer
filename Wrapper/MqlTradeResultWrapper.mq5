#property strict

#include "../Wrapper/MqlTradeResultWrapper.mqh"

//--- Default Constructor
MqlTradeResultWrapper::MqlTradeResultWrapper(void) { }

//--- Main Constructor
MqlTradeResultWrapper::MqlTradeResultWrapper(MqlTradeResult &InputResult) {
   MqlTradeResultWrapper(InputResult, 1);
}

//--- Main Constructor
MqlTradeResultWrapper::MqlTradeResultWrapper(MqlTradeResult &InputResult, const double InputVolumeRatio) {
   retcode           = InputResult.retcode;
   deal              = InputResult.deal;
   order             = InputResult.order;
   volume            = InputResult.volume;
   price             = InputResult.price;
   bid               = InputResult.bid;
   ask               = InputResult.ask;
   comment           = InputResult.comment;
   request_id        = InputResult.request_id;
   retcode_external  = InputResult.retcode_external;
   volume_ratio      = InputVolumeRatio;
}

//--- Main Constructor
MqlTradeResultWrapper::MqlTradeResultWrapper(MqlTradeResultWrapper *InputResult, const double InputVolumeRatio) {
   retcode           = InputResult.retcode;
   deal              = InputResult.deal;
   order             = InputResult.order;
   volume            = InputResult.volume;
   price             = InputResult.price;
   bid               = InputResult.bid;
   ask               = InputResult.ask;
   comment           = InputResult.comment;
   request_id        = InputResult.request_id;
   retcode_external  = InputResult.retcode_external;
   volume_ratio      = InputVolumeRatio;
}

//--- Revert Back To Struct State
void MqlTradeResultWrapper::Unwrap(MqlTradeResult &OutputResult) {
   OutputResult.retcode          = retcode;
   OutputResult.deal             = deal;
   OutputResult.order            = order;
   OutputResult.volume           = GetRealVolume();
   OutputResult.price            = price;
   OutputResult.bid              = bid;
   OutputResult.ask              = ask;
   OutputResult.comment          = comment;
   OutputResult.request_id       = request_id;
   OutputResult.retcode_external = (int) retcode_external;
}

//--- Getters
double MqlTradeResultWrapper::GetRealVolume(void) const {
   return NormalizeDouble(volume * volume_ratio, 2);
}