#ifndef MQL_TRADE_RESULT_H
#define MQL_TRADE_RESULT_H

#include <Generic/Interfaces/IComparable.mqh>

#include "../General/GlobalConstants.mqh"

class MqlTradeResultWrapper : public IComparable<MqlTradeResultWrapper*>
{
public:
   //--- Default Constructor
   MqlTradeResultWrapper(void);
   
   //--- Main Constructor
   MqlTradeResultWrapper(MqlTradeResult &result);
   
   //--- Revert Back To Struct Format
   void Unwrap(MqlTradeResult &result);
   
   //--- Required ADT Functions
   int  Compare(MqlTradeResultWrapper* Other) override;
   bool Equals(MqlTradeResultWrapper* Other) override;
   int  HashCode() override;
   
   //--- Attributes   
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