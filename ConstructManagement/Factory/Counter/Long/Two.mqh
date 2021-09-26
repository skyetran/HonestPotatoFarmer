#ifndef TWO_LEVEL_NET_LONG_COUNTER_FACTORY_H
#define TWO_LEVEL_NET_LONG_COUNTER_FACTORY_H

#include "../../../Construct/Counter/Long/Two.mqh"
#include "../CounterFactory.mqh"

class TwoLevelNetLongCounterFactory : public CounterFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   TwoLevelNetLongCounterFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 override;
   bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) override;
   Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   override;
   
private:
   //--- Helper Functions: Create Operations
   ConstructFullTradePool *CreateFullTradePool(ConstructParameters *InputParameters) override;
};

#endif