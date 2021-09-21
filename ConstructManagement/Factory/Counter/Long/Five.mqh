#ifndef FIVE_LEVEL_NET_LONG_COUNTER_FACTORY_H
#define FIVE_LEVEL_NET_LONG_COUNTER_FACTORY_H

#include "../../../Construct/Counter/Long/Five.mqh"
#include "../../ConstructFactory.mqh"

class FiveLevelNetLongCounterFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   FiveLevelNetLongCounterFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 override;
   bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) override;
   Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   override;
};

#endif