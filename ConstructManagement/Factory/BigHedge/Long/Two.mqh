#ifndef TWO_LEVEL_NET_LONG_BIG_HEDGE_FACTORY_H
#define TWO_LEVEL_NET_LONG_BIG_HEDGE_FACTORY_H

#include "../../../Construct/BigHedge/Long/Two.mqh"
#include "../../ConstructFactory.mqh"

class TwoLevelNetLongBigHedgeFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   TwoLevelNetLongBigHedgeFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 override;
   bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) override;
   Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   override;
   
private:
   //--- Helper Functions: Create Operation
   ConstructFullTradePool *CreateFullTradePool(ConstructParameters *InputParameters) override;
};

#endif