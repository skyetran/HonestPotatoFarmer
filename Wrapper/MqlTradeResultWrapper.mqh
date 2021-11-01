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
   MqlTradeResultWrapper(MqlTradeResult &InputResult);
   
   //--- Main Constructor
   MqlTradeResultWrapper(MqlTradeResult &InputResult, const double InputVolumeRatio);
   
   //--- Main Constructor
   MqlTradeResultWrapper(MqlTradeResultWrapper *InputResult, const double InputVolumeRatio);
   
   //--- Revert Back To Struct Format
   void Unwrap(MqlTradeResult &result);
   
   //--- Required ADT Functions
   int  Compare(MqlTradeResultWrapper* Other) override;
   bool Equals(MqlTradeResultWrapper* Other) override;
   int  HashCode() override;
   
   //--- Getters
   double GetRealVolume(void) const;
   
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

private:
   double   volume_ratio;
};

#endif