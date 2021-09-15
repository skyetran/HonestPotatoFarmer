#ifndef SIX_LEVEL_NET_LONG_FREE_STYLING_FACTORY_H
#define SIX_LEVEL_NET_LONG_FREE_STYLING_FACTORY_H

#include "../../ConstructFactory.mqh"

class SixLevelNetLongFreeStylingFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   SixLevelNetLongFreeStylingFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif