#property strict

#include "../Wrapper/MqlTradeRequestWrapper.mqh"

//--- Default Constructor
MqlTradeRequestWrapper::MqlTradeRequestWrapper(void) {
   IP = IndicatorProcessor::GetInstance();
}

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
   string HashString = DoubleToString(10 * action + order) + DoubleToString(volume) + DoubleToString(price) + DoubleToString(stoplimit) + comment;
   int    Length     = StringLen(HashString);
   int    HashValue  = 0;
   
   if (Length > 0) {
      for (int i = 0; i < Length; i++) {
         HashValue = 31 * HashValue + HashString[i];
      }
   } 
   return HashValue;
}