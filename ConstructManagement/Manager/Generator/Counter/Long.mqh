#ifndef NET_LONG_COUNTER_CONSTRUCT_GENERATOR_H
#define NET_LONG_COUNTER_CONSTRUCT_GENERATOR_H

#include "../ConstructGenerator.mqh"

class NetLongCounterConstructGenerator : public ConstructGenerator
{
public:
   //--- Constructor
   NetLongCounterConstructGenerator(void);
   
   //--- Operations
   void CreateConstructs(ConstructParameters* Parameters) override;
};

#endif