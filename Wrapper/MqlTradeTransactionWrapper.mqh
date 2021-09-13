#ifndef MQL_TRADE_TRANSACTION_WRAPPER_H
#define MQL_TRADE_TRANSACTION_WRAPPER_H

#include <Generic/Interfaces/IComparable.mqh>

#include "../General/GlobalConstants.mqh"

class MqlTradeTransactionWrapper : public IComparable<MqlTradeTransactionWrapper*>
{
public:
   //--- Default Constructor
   MqlTradeTransactionWrapper(void);
   
   //--- Main Constructor
   MqlTradeTransactionWrapper(MqlTradeTransaction &trans);
   
   //--- Revert Back To Struct Format
   void Unwrap(MqlTradeTransaction &trans);
   
   //--- Required ADT Functions
   int  Compare(MqlTradeTransactionWrapper* Other) override;
   bool Equals(MqlTradeTransactionWrapper* Other) override;
   int  HashCode() override;
   
   //--- Attributes
   ulong                         deal;
   ulong                         order;
   string                        symbol;
   ENUM_TRADE_TRANSACTION_TYPE   type;
   ENUM_ORDER_TYPE               order_type;
   ENUM_ORDER_STATE              order_state;
   ENUM_DEAL_TYPE                deal_type;
   ENUM_ORDER_TYPE_TIME          time_type;
   datetime                      time_expiration;
   double                        price;
   double                        price_trigger;
   double                        price_sl;
   double                        price_tp;
   double                        volume;
   ulong                         position;
   ulong                         position_by;
};

#endif