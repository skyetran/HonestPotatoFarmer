#ifndef NET_SHORT_COUNTER_CONSTRUCT_GENERATOR_H
#define NET_SHORT_COUNTER_CONSTRUCT_GENERATOR_H

#include "../ConstructGenerator.mqh"

class NetShortCounterConstructGenerator : public ConstructGenerator
{
public:
   //--- Constructor
   NetShortCounterConstructGenerator(void);
   
   //--- Operations
   void CreateConstructs(ConstructParameters* Parameters) override;
};

#endif