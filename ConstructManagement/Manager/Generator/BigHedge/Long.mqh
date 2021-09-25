#ifndef NET_LONG_BIG_HEDGE_CONSTRUCT_GENERATOR_H
#define NET_LONG_BIG_HEDGE_CONSTRUCT_GENERATOR_H

#include "../ConstructGenerator.mqh"

class NetLongBigHedgeConstructGenerator : public ConstructGenerator
{
public:
   //--- Constructor
   NetLongBigHedgeConstructGenerator(void);
   
   //--- Operations
   void CreateConstructs(ConstructParameters* Parameters) override;
};

#endif