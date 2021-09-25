#ifndef FIVE_LEVEL_NET_SHORT_COUNTER_FACTORY_H
#define FIVE_LEVEL_NET_SHORT_COUNTER_FACTORY_H

#include "../../../Construct/Counter/Short/Five.mqh"
#include "../../ConstructFactory.mqh"

class FiveLevelNetShortCounterFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   FiveLevelNetShortCounterFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 override;
   bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) override;
   Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   override;
   
private:
   //--- Helper Functions: Create Operations
   ConstructFullTradePool *CreateFullTradePool(ConstructParameters *InputParameters) override;
};

#endif