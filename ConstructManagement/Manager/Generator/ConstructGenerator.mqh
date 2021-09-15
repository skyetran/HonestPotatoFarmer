#ifndef CONSTRUCT_GENERATOR_H
#define CONSTRUCT_GENERATOR_H

#include "../ConstructManager.mqh"

class ConstructGenerator : public ConstructManager
{
public:
   //--- Constructor
   ConstructGenerator(void);
   
   //--- Operations
   virtual void CreateConstructs(ConstructParameters* Parameters) = NULL;
};

#endif