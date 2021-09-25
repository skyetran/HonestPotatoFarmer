#ifndef SEVEN_LEVEL_NET_LONG_COUNTER_FACTORY_H
#define SEVEN_LEVEL_NET_LONG_COUNTER_FACTORY_H

#include "../../../Construct/Counter/Long/Seven.mqh"
#include "../../ConstructFactory.mqh"

class SevenLevelNetLongCounterFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   SevenLevelNetLongCounterFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 override;
   bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) override;
   Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   override;
   
private:
   //--- Helper Functions: Create Operations
   ConstructFullTradePool *CreateFullTradePool(ConstructParameters *InputParameters) override;
};

#endif