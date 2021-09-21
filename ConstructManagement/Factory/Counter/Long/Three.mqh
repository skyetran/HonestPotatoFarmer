#ifndef THREE_LEVEL_NET_LONG_COUNTER_FACTORY_H
#define THREE_LEVEL_NET_LONG_COUNTER_FACTORY_H

#include "../../../Construct/Counter/Long/Three.mqh"
#include "../../ConstructFactory.mqh"

class ThreeLevelNetLongCounterFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   ThreeLevelNetLongCounterFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 override;
   bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) override;
   Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   override;
};

#endif