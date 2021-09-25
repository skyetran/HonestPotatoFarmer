#ifndef NET_SHORT_BIG_HEDGE_CONSTRUCT_GENERATOR_H
#define NET_SHORT_BIG_HEDGE_CONSTRUCT_GENERATOR_H

#include "../ConstructGenerator.mqh"

class NetShortBigHedgeConstructGenerator : public ConstructGenerator
{
public:
   //--- Constructor
   NetShortBigHedgeConstructGenerator(void);
   
   //--- Operations
   void CreateConstructs(ConstructParameters* Parameters) override;
};

#endif