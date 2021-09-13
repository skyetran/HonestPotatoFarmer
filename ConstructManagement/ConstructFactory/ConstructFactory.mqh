#ifndef CONSTRUCT_FACTORY_H
#define CONSTRUCT_FACTORY_H

#include "../Construct/Construct.mqh"
#include "../General/GlobalCosntants.mqh"

class ConstructFactory {
   virtual Construct *Create() = NULL;
};

#endif