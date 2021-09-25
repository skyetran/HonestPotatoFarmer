#ifndef THREE_LEVEL_NET_LONG_BIG_HEDGE_FACTORY_H
#define THREE_LEVEL_NET_LONG_BIG_HEDGE_FACTORY_H

#include "../../../Construct/BigHedge/Long/Three.mqh"
#include "../../ConstructFactory.mqh"

class ThreeLevelNetLongBigHedgeFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   ThreeLevelNetLongBigHedgeFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 override;
   bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) override;
   Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   override;
   
private:
   //--- Helper Functions: Create Operations
   ConstructFullTradePool *CreateFullTradePool(ConstructParameters *InputParameters) override;
};

#endif