#ifndef CONSTRUCT_FACTORY_H
#define CONSTRUCT_FACTORY_H

#include "../Construct/Construct.mqh"

class ConstructFactory
{
public:
   //--- Constructor
   ConstructFactory(void);
   
   //--- Operations
   virtual ConstructPreCheckInfo *PreCheck(Construct *construct) = NULL;   
   virtual Construct             *Create(void)                   = NULL;
};

#endif