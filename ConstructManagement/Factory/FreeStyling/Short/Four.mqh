#ifndef FOUR_LEVEL_NET_SHORT_FREE_STYLING_FACTORY_H
#define FOUR_LEVEL_NET_SHORT_FREE_STYLING_FACTORY_H

#include "../../../Construct/FreeStyling/Short/Four.mqh"
#include "../FreeStylingFactory.mqh"

class FourLevelNetShortFreeStylingFactory : public FreeStylingFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   FourLevelNetShortFreeStylingFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 override;
   bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) override;
   Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   override;
   
private:
   //--- Helper Functions: Create Operations
   ConstructFullTradePool *CreateFullTradePool(ConstructParameters *InputParameters) override;
};

#endif