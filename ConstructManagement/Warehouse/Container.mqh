#ifndef CONTAINER_H
#define CONTAINER_H

#include <Generic\HashMap.mqh>

#include "../Construct/Construct.mqh"
#include "../Construct/Attributes/Parameters.mqh"
#include "../Construct/Attributes/Type.mqh"

#define BASE_MULTIPLIER 1

class Container
{
public:
   //--- Default Constructor
   Container(void);
   
   //--- Main Constructor
   Container(ConstructType *InputType);
   
   //--- Destructor
   ~Container(void);
   
   //--- Clear All Container
   void Clear(void);
   
   //--- Getters
   ConstructType *GetContainerType(void) const;
   
   //--- Add Input Construct To The Inventory
   void Add(Construct *InputConstruct);
   
   //--- Retrieve Construct With The Corresponding Parameters
   Construct *RetrieveConstruct(ConstructParameters *InputParameters);
   
private:
   //--- Map The Parameter Set To The Corresponding Constructs
   CHashMap<ConstructParameters*, Construct*> *ConstructContainer;
   
   //--- Inventory Attributes
   ConstructType *ContainerType;
   
   //--- Helper Functions: Add
   void AddExistedConstruct(Construct *InputConstruct);
   void AddNewConstruct(Construct *InputConstruct);
};

#endif