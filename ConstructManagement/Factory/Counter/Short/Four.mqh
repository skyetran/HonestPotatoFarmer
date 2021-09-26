#ifndef FOUR_LEVEL_NET_SHORT_COUNTER_FACTORY_H
#define FOUR_LEVEL_NET_SHORT_COUNTER_FACTORY_H

#include "../../../Construct/Counter/Short/Four.mqh"
#include "../CounterFactory.mqh"

class FourLevelNetShortCounterFactory : public CounterFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   FourLevelNetShortCounterFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 override;
   bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) override;
   Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   override;
   
private:
   //--- Helper Functions: Create Operations
   ConstructFullTradePool *CreateFullTradePool(ConstructParameters *InputParameters) override;
};

#endif