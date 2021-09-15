#ifndef SEVEN_LEVEL_NET_LONG_FREE_STYLING_FACTORY_H
#define SEVEN_LEVEL_NET_LONG_FREE_STYLING_FACTORY_H

#include "../../ConstructFactory.mqh"

class SevenLevelNetLongFreeStylingFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   SevenLevelNetLongFreeStylingFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif