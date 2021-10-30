#ifndef MQL_TRADE_REQUEST_WRAPPER_H
#define MQL_TRADE_REQUEST_WRAPPER_H

#include <Generic/Interfaces/IComparable.mqh>

#include "../General/GlobalConstants.mqh"
#include "../General/IndicatorProcessor.mqh"

class MqlTradeRequestWrapper : public IComparable<MqlTradeRequestWrapper*>
{
public:
   //--- Default Constructor
   MqlTradeRequestWrapper(void);
   
   //--- Copy Constructor
   MqlTradeRequestWrapper(MqlTradeRequestWrapper *InputRequest);
   
   //--- Main Constructor
   MqlTradeRequestWrapper(MqlTradeRequest &InputRequest);
   
   //--- Revert Back To Struct Format
   void Unwrap(MqlTradeRequest &InputRequest);
   
   //--- Required ADT Functions
   int  Compare(MqlTradeRequestWrapper *Other) override;
   bool Equals(MqlTradeRequestWrapper *Other) override;
   int  HashCode() override;
   
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
   
   //--- Getters
   bool IsRawMarketRequest();
   bool IsLimitRequest();
   bool IsStopLimitRequest();
   bool IsStopRequest();
   
   bool IsMarketRequest();
   bool IsPendingRequest();
   
   bool IsBuyRequest();
   bool IsBuyMarketRequest();
   bool IsBuyLimitRequest();
   bool IsBuyStopRequest();
   bool IsBuyStopLimitRequest();
   
   bool IsSellRequest();
   bool IsSellMarketRequest();
   bool IsSellLimitRequest();
   bool IsSellStopRequest();
   bool IsSellStopLimitRequest();
   
   //--- Setters
   void SetCreateDateTime(const datetime InputCreateDateTime);

   //--- Operations
   void Copy(MqlTradeRequestWrapper *InputRequest);
   void AddVolume(const double InputVolume);

private:
   IndicatorProcessor *IP;
   
   datetime CreateDateTime;
};

#endif