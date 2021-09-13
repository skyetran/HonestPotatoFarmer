#ifndef CONTAINER_H
#define CONTAINER_H

#include <Generic\HashMap.mqh>

#include "../Construct/Construct.mqh"
#include "../Construct/ConstructParameters.mqh"
#include "../Construct/ConstructType.mqh"

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
   Construct *Retrieve(ConstructParameters *Parameters);
   
   //--- Clear All Inventory
   void Clear(void);
   
private:
   //--- Map The Parameter Set To The Corresponding Constructs
   CHashMap<ConstructParameters*, Construct*> ConstructContainer;
   
   //--- Inventory Attributes
   ConstructType *ContainerType;
};

#endif