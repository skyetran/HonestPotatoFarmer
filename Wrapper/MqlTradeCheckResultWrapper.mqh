#ifndef MQL_TRADE_CHECK_RESULT_H
#define MQL_TRADE_CHECK_RESULT_H

#include <Generic/Interfaces/IComparable.mqh>

#include "../General/GlobalConstants.mqh"

class MqlTradeCheckResultWrapper : public IComparable<MqlTradeCheckResultWrapper*>
{
public:
   //--- Default Constructor
   MqlTradeCheckResultWrapper(void);
   
   //--- Main Constructor
   MqlTradeCheckResultWrapper(MqlTradeCheckResult &result);
   
   //--- Revert Back To Struct Format
   void Unwrap(MqlTradeCheckResult &result);
   
   //--- Required ADT Functions
   int  Compare(MqlTradeCheckResultWrapper* Other) override;
   bool Equals(MqlTradeCheckResultWrapper* Other) override;
   int  HashCode() override;
   
   //--- Attributes
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