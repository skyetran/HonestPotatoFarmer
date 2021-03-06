#ifndef SIX_LEVEL_NET_LONG_BIG_HEDGE_FACTORY_H
#define SIX_LEVEL_NET_LONG_BIG_HEDGE_FACTORY_H

#include "../../../Construct/BigHedge/Long/Six.mqh"
#include "../../ConstructFactory.mqh"
#include "../UniqueComments.mqh"

class SixLevelNetLongBigHedgeFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   SixLevelNetLongBigHedgeFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 override;
   bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) override;
   Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   override;
   
private:
   //--- Helper Functions: Create Operations
   ConstructFullTradePool *CreateFullTradePool(ConstructParameters *InputParameters) override;
};

#endif