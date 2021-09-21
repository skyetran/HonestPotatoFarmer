#ifndef CONSTRUCT_FACTORY_H
#define CONSTRUCT_FACTORY_H

#include "../Construct/Construct.mqh"

class ConstructFactory
{
public:
   //--- Constructor
   ConstructFactory(void);
   
   //--- Operations
   virtual ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 = NULL; 
   virtual bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) = NULL;  
   virtual Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   = NULL;
};

#endif