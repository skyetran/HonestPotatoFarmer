#ifndef NET_LONG_FREE_STYLING_CONSTRUCT_GENERATOR_H
#define NET_LONG_FREE_STYLING_CONSTRUCT_GENERATOR_H

#include "../ConstructGenerator.mqh"

class NetLongFreeStylingConstructGenerator : public ConstructGenerator
{
public:
   //--- Constructor
   NetLongFreeStylingConstructGenerator(void);
   
   //--- Operations
   void CreateConstructs(ConstructParameters* Parameters) override;
};

#endif