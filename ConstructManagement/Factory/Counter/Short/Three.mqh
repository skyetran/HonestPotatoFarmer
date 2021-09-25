#ifndef THREE_LEVEL_NET_SHORT_COUNTER_FACTORY_H
#define THREE_LEVEL_NET_SHORT_COUNTER_FACTORY_H

#include "../../../Construct/Counter/Short/Three.mqh"
#include "../../ConstructFactory.mqh"

class ThreeLevelNetShortCounterFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   ThreeLevelNetShortCounterFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 override;
   bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) override;
   Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   override;
   
private:
   //--- Helper Functions: Create Operations
   ConstructFullTradePool *CreateFullTradePool(ConstructParameters *InputParameters) override;
};

#endif