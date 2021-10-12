#property strict

#include "../../ConstructManagement/Warehouse/Container.mqh"

//--- Default Constructor
Container::Container(void) { }

//--- Main Constructor
Container::Container(ConstructType *InputType) {
   ConstructContainer = new CHashMap<ConstructParameters*, Construct*>();
   ContainerType = InputType;
}

//--- Destructor
Container::~Container(void) {
   Clear();
   delete ConstructContainer;
}

//--- Clear All Container
void Container::Clear(void) {
   ConstructParameters *ParametersSets[];
   Construct           *Constructs[];
   ConstructContainer.CopyTo(ParametersSets, Constructs);
   
   for (int i = 0; i < ArraySize(ParametersSets); i++) {
      delete ParametersSets[i];
      delete Constructs[i];
   }
}

ConstructType *Container::GetContainerType(void) const {
   return ContainerType;
}

//--- Add Input Construct To The Inventory
void Container::Add(Construct *InputConstruct) {
   if (ConstructContainer.ContainsKey(InputConstruct.GetConstructParameters())) {
      AddExistedConstruct(InputConstruct);
   } else {
      AddNewConstruct(InputConstruct);
   }
}

//--- Helper Functions: Add
void Container::AddExistedConstruct(Construct *InputConstruct) {
   Construct *ExistedConstruct;
   ConstructContainer.TryGetValue(InputConstruct.GetConstructParameters(), ExistedConstruct);
   ExistedConstruct.SetMultiplier(ExistedConstruct.GetMultiplier() + BASE_MULTIPLIER);
   ConstructContainer.Add(ExistedConstruct.GetConstructParameters(), ExistedConstruct);
}

//--- Helper Functions: Add
void Container::AddNewConstruct(Construct *InputConstruct) {
   Construct *NewConstruct = InputConstruct;
   NewConstruct.SetMultiplier(BASE_MULTIPLIER);
   ConstructContainer.Add(NewConstruct.GetConstructParameters(), NewConstruct);
}

//--- Retrieve Construct With The Corresponding Parameters
Construct *Container::RetrieveConstruct(ConstructParameters *InputParameters) {
   if (ConstructContainer.ContainsKey(InputParameters)) {
      Construct *RetrievedConstruct;
      ConstructContainer.TryGetValue(InputParameters, RetrievedConstruct);
      return RetrievedConstruct;
   }
   return NULL;
}