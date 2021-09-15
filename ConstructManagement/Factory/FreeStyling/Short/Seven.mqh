#ifndef SEVEN_LEVEL_NET_SHORT_FREE_STYLING_FACTORY_H
#define SEVEN_LEVEL_NET_SHORT_FREE_STYLING_FACTORY_H

#include "../../ConstructFactory.mqh"

class SevenLevelNetShortFreeStylingFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   SevenLevelNetShortFreeStylingFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif