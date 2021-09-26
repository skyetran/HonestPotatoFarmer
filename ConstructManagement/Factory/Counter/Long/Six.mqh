#ifndef SIX_LEVEL_NET_LONG_COUNTER_FACTORY_H
#define SIX_LEVEL_NET_LONG_COUNTER_FACTORY_H

#include "../../../Construct/Counter/Long/Six.mqh"
#include "../CounterFactory.mqh"

class SixLevelNetLongCounterFactory : public CounterFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   SixLevelNetLongCounterFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 override;
   bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) override;
   Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   override;
   
private:
   //--- Helper Functions: Create Operations
   ConstructFullTradePool *CreateFullTradePool(ConstructParameters *InputParameters) override;
};

#endif