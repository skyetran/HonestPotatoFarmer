#ifndef SEVEN_LEVEL_NET_LONG_FREE_STYLING_FACTORY_H
#define SEVEN_LEVEL_NET_LONG_FREE_STYLING_FACTORY_H

#include "../../../Construct/FreeStyling/Long/Seven.mqh"
#include "../FreeStylingFactory.mqh"

class SevenLevelNetLongFreeStylingFactory : public FreeStylingFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   SevenLevelNetLongFreeStylingFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 override;
   bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) override;
   Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   override;
   
private:
   //--- Helper Functions: Create Operations
   ConstructFullTradePool *CreateFullTradePool(ConstructParameters *InputParameters) override;
};

#endif