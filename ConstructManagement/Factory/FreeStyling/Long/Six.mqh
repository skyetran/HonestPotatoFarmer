#ifndef SIX_LEVEL_NET_LONG_FREE_STYLING_FACTORY_H
#define SIX_LEVEL_NET_LONG_FREE_STYLING_FACTORY_H

#include "../../../Construct/FreeStyling/Long/Six.mqh"
#include "../FreeStylingFactory.mqh"

class SixLevelNetLongFreeStylingFactory : public FreeStylingFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   SixLevelNetLongFreeStylingFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 override;
   bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) override;
   Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   override;
   
private:
   //--- Helper Functions: Create Operations
   ConstructFullTradePool *CreateFullTradePool(ConstructParameters *InputParameters) override;
};

#endif