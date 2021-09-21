#ifndef SEVEN_LEVEL_NET_SHORT_COUNTER_FACTORY_H
#define SEVEN_LEVEL_NET_SHORT_COUNTER_FACTORY_H

#include "../../../Construct/Counter/Short/Seven.mqh"
#include "../../ConstructFactory.mqh"

class SevenLevelNetShortCounterFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   SevenLevelNetShortCounterFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 override;
   bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) override;
   Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   override;
};

#endif