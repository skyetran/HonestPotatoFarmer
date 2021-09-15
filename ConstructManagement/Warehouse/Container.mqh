#ifndef CONTAINER_H
#define CONTAINER_H

#include <Generic\HashMap.mqh>

#include "../Construct/Construct.mqh"
#include "../Construct/Parameters.mqh"
#include "../Construct/Type.mqh"

class Container
{
public:
   //--- Default Constructor
   Container(void);
   
   //--- Main Constructor
   Container(ConstructType *InputType);
   
   //--- Destructor
   ~Container(void);
   
   //--- Add New Construct To The Inventory
   void Add(Construct *NewConstruct);
   
   //--- Retrieve Construct With The Corresponding Parameters
   Construct *RetrieveConstruct(ConstructParameters *Parameters);
   
   //--- Retrieve Construct Multiplier With The Corresponding Parameters
   int RetrieveMultiplier(ConstructParameters *Parameters);
   
   //--- Clear All Inventory
   void Clear(void);
   
private:
   //--- Map The Parameter Set To The Corresponding Constructs
   CHashMap<ConstructParameters*, Construct*> ConstructContainer;
   CHashMap<ConstructParameters*, int>        Multiplier;
   
   //--- Inventory Attributes
   ConstructType *ContainerType;
};

#endif