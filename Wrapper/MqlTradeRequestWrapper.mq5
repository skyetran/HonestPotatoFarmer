#property strict

#include "../Wrapper/MqlTradeRequestWrapper.mqh"

//--- Default Constructor
MqlTradeRequestWrapper::MqlTradeRequestWrapper(void) {
   IP = IndicatorProcessor::GetInstance();
   CreateDateTime = TimeGMT();
}

//--- Copy Constructor
MqlTradeRequestWrapper::MqlTradeRequestWrapper(MqlTradeRequestWrapper *InputRequest) {
   Copy(InputRequest);
}

//--- Main Constructor
MqlTradeRequestWrapper::MqlTradeRequestWrapper(MqlTradeRequest &InputRequest) {
   action         = InputRequest.action;
   magic          = InputRequest.magic;
   order          = InputRequest.order;
   symbol         = InputRequest.symbol;
   volume         = InputRequest.volume;
   price          = InputRequest.price;
   stoplimit      = InputRequest.stoplimit;
   sl             = InputRequest.sl;
   tp             = InputRequest.tp;
   deviation      = InputRequest.deviation;
   type           = InputRequest.type;
   type_filling   = InputRequest.type_filling;
   type_time      = InputRequest.type_time;
   expiration     = InputRequest.expiration;
   comment        = InputRequest.comment;
   position       = InputRequest.position;
   position_by    = InputRequest.position_by;
}

//--- Revert Back To Struct State
void MqlTradeRequestWrapper::Unwrap(MqlTradeRequest &InputRequest) {
   InputRequest.action       = action;
   InputRequest.magic        = magic;
   InputRequest.order        = order;
   InputRequest.symbol       = symbol;
   InputRequest.volume       = volume;
   InputRequest.price        = price;
   InputRequest.stoplimit    = stoplimit;
   InputRequest.sl           = sl;
   InputRequest.tp           = tp;
   InputRequest.deviation    = deviation;
   InputRequest.type         = type;
   InputRequest.type_filling = type_filling;
   InputRequest.type_time    = type_time;
   InputRequest.expiration   = expiration;
   InputRequest.comment      = comment;
   InputRequest.position     = position;
   InputRequest.position_by  = position_by;
}

//--- Required ADT Functions
int  MqlTradeRequestWrapper::Compare(MqlTradeRequestWrapper* Other) {
   //--- Ranking Importance Of Request To Determine Which To Execute First
   return 0;
}

bool MqlTradeRequestWrapper::Equals(MqlTradeRequestWrapper* Other) {
   return action       == Other.action       &&
          magic        == Other.magic        &&
          order        == Other.order        &&
          symbol       == Other.symbol       &&
          volume       == Other.volume       &&
          price        == Other.price        &&
          stoplimit    == Other.stoplimit    &&
          sl           == Other.sl           &&
          tp           == Other.tp           &&
          deviation    == Other.deviation    &&
          type         == Other.type         &&
          type_filling == Other.type_filling &&
          type_time    == Other.type_time    &&
          expiration   == Other.expiration   &&
          comment      == Other.comment      &&
          position     == Other.position     &&
          position_by  == Other.position_by   ;
}

int  MqlTradeRequestWrapper::HashCode() {
   string HashString = DoubleToString(10 * action + order) + DoubleToString(volume) + DoubleToString(price) + DoubleToString(stoplimit) + comment + TimeToString(CreateDateTime);
   int    Length     = StringLen(HashString);
   int    HashValue  = 0;
   
   if (Length > 0) {
      for (int i = 0; i < Length; i++) {
         HashValue = 31 * HashValue + HashString[i];
      }
   } 
   return HashValue;
}

//--- Getters
bool MqlTradeRequestWrapper::IsRawMarketRequest() { return type == ORDER_TYPE_BUY || type == ORDER_TYPE_SELL;                       }
bool MqlTradeRequestWrapper::IsLimitRequest()     { return type == ORDER_TYPE_BUY_LIMIT || type == ORDER_TYPE_SELL_LIMIT;           }
bool MqlTradeRequestWrapper::IsStopLimitRequest() { return type == ORDER_TYPE_BUY_STOP_LIMIT || type == ORDER_TYPE_SELL_STOP_LIMIT; }
bool MqlTradeRequestWrapper::IsStopRequest()      { return type == ORDER_TYPE_BUY_STOP || type == ORDER_TYPE_SELL_STOP;             }
   
bool MqlTradeRequestWrapper::IsMarketRequest()    { return action == TRADE_ACTION_DEAL;    }
bool MqlTradeRequestWrapper::IsPendingRequest()   { return action == TRADE_ACTION_PENDING; }

bool MqlTradeRequestWrapper::IsBuyRequest() { 
   return IsBuyMarketRequest()   ||
          IsBuyLimitRequest()    ||
          IsBuyStopRequest()     ||
          IsBuyStopLimitRequest();
}

bool MqlTradeRequestWrapper::IsBuyMarketRequest()    { return type == ORDER_TYPE_BUY;            }
bool MqlTradeRequestWrapper::IsBuyLimitRequest()     { return type == ORDER_TYPE_BUY_LIMIT;      }
bool MqlTradeRequestWrapper::IsBuyStopRequest()      { return type == ORDER_TYPE_BUY_STOP;       }
bool MqlTradeRequestWrapper::IsBuyStopLimitRequest() { return type == ORDER_TYPE_BUY_STOP_LIMIT; }

bool MqlTradeRequestWrapper::IsSellRequest() {
   return IsSellMarketRequest()   ||
          IsSellLimitRequest()    ||
          IsSellStopRequest()     ||
          IsSellStopLimitRequest();
}

bool MqlTradeRequestWrapper::IsSellMarketRequest()    { return type == ORDER_TYPE_SELL;            }
bool MqlTradeRequestWrapper::IsSellLimitRequest()     { return type == ORDER_TYPE_SELL_LIMIT;      }
bool MqlTradeRequestWrapper::IsSellStopRequest()      { return type == ORDER_TYPE_SELL_STOP;       }
bool MqlTradeRequestWrapper::IsSellStopLimitRequest() { return type == ORDER_TYPE_SELL_STOP_LIMIT; }

//--- Setters
void MqlTradeRequestWrapper::SetCreateDateTime(const datetime InputCreateDateTime) {
   CreateDateTime = InputCreateDateTime;
}

//--- Operations
void MqlTradeRequestWrapper::Copy(MqlTradeRequestWrapper *InputRequest) {
   action       = InputRequest.action;
   magic        = InputRequest.magic;
   order        = InputRequest.order;
   symbol       = InputRequest.symbol;
   volume       = InputRequest.volume;
   price        = InputRequest.price;
   stoplimit    = InputRequest.stoplimit;
   sl           = InputRequest.sl;
   tp           = InputRequest.tp;
   deviation    = InputRequest.deviation;
   type         = InputRequest.type;
   type_filling = InputRequest.type_filling;
   type_time    = InputRequest.type_time;
   expiration   = InputRequest.expiration;
   comment      = InputRequest.comment;
   position     = InputRequest.position;
   position_by  = InputRequest.position_by;
}

//--- Operations
void MqlTradeRequestWrapper::AddVolume(const double InputVolume) {
   volume += InputVolume;
}