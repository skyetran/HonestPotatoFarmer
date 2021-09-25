#ifndef NET_SHORT_FREE_STYLING_CONSTRUCT_GENERATOR_H
#define NET_SHORT_FREE_STYLING_CONSTRUCT_GENERATOR_H

#include "../ConstructGenerator.mqh"

class NetShortFreeStylingConstructGenerator : public ConstructGenerator
{
public:
   //--- Constructor
   NetShortFreeStylingConstructGenerator(void);
   
   //--- Operations
   void CreateConstructs(ConstructParameters* Parameters) override;
};

#endif