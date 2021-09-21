#property strict

#include "../../ConstructManagement/Construct/Construct.mqh"

//--- Main Constructor
Construct::Construct(void) {
   PMHP = PositionManagementHyperParameters::GetInstance();
}

//--- Destructor
Construct::~Construct(void) {
   delete Pool;
   delete Key;
   delete Type;
   delete Parameters;
   delete RollingInfo;
   delete ResultInfo;
   GetConstructFactories().Clear();
   GetConstructMonitors().Clear();
   delete GetConstructFactories();
   delete GetConstructMonitors();
}

//--- Register Construct Type To The Right Construct Factory
static void Construct::RegisterFactory(ConstructType *InputType, ConstructFactory *InputFactory) {
   GetConstructFactories().Add(InputType, InputFactory);
}

//--- Register Construct Type To The Right Construct Monitor
static void Construct::RegisterMonitor(ConstructType *InputType, ConstructMonitor *InputMonitor) {
   GetConstructMonitors().Add(InputType, InputMonitor);
}

//--- Return Key Variables To Check If Construct Meet Requirements --- Validation Happens Elsewhere
static ConstructPreCheckInfo *Construct::PreCheck(ConstructType *InputType, ConstructParameters *InputParameters) {
   if (!GetConstructFactories().ContainsKey(InputType)) {
      Print(CONSTRUCT_TYPE_DOES_NOT_EXIST);
      return NULL;
   }
   ConstructFactory *ResponsibleFactory;
   GetConstructFactories().TryGetValue(InputType, ResponsibleFactory);
   return ResponsibleFactory.PreCheck(GetPointer(InputParameters));
}

//--- Find The Corresponding Construct Factory And Validate The Construct
static bool Construct::Validate(ConstructType *InputType, ConstructParameters *InputParameters, const int InputEntryPosition) {
   if (!GetConstructFactories().ContainsKey(InputType)) {
      Print(CONSTRUCT_TYPE_DOES_NOT_EXIST);
      return false;
   }
   ConstructFactory *ResponsibleFactory;
   GetConstructFactories().TryGetValue(InputType, ResponsibleFactory);
   return ResponsibleFactory.Validate(GetPointer(InputParameters), InputEntryPosition);
}

//--- Find The Corresponding Construct Factory And Get Factory To Create The Construct
static Construct *Construct::create(ConstructType *InputType, ConstructParameters *InputParameters, const int InputEntryPosition) {
   if (!GetConstructFactories().ContainsKey(InputType)) {
      Print(CONSTRUCT_TYPE_DOES_NOT_EXIST);
      return NULL;
   }
   ConstructFactory *ResponsibleFactory;
   GetConstructFactories().TryGetValue(InputType, ResponsibleFactory);
   return ResponsibleFactory.Create(GetPointer(InputParameters), InputEntryPosition);
}

//--- Getters
ConstructTradePool   *Construct::GetConstructTradePool(void)   const { return Pool;        }
ConstructKey         *Construct::GetConstructKey(void)         const { return Key;         }
ConstructType        *Construct::GetConstructType(void)        const { return Type;        }
ConstructParameters  *Construct::GetConstructParameters(void)  const { return Parameters;  }
ConstructRollingInfo *Construct::GetConstructRollingInfo(void) const { return RollingInfo; }
ConstructResultInfo  *Construct::GetConstructResultInfo(void)  const { return ResultInfo;  }

//--- Main Operations
//--- Find The Right Monitor And Run OnTick Update
void Construct::UpdateTradePool(void) {
   if (!GetConstructMonitors().ContainsKey(Type)) {
      Print(CONSTRUCT_TYPE_DOES_NOT_EXIST);
   } else {
      ConstructMonitor *ResponsibleMonitor;
      GetConstructMonitors().TryGetValue(Type, ResponsibleMonitor);
      ResponsibleMonitor.UpdateTradePool(GetPointer(this));
   }
}

void Construct::UpdateFinance(void) {
   if (!GetConstructMonitors().ContainsKey(Type)) {
      Print(CONSTRUCT_TYPE_DOES_NOT_EXIST);
   } else {
      ConstructMonitor *ResponsibleMonitor;
      GetConstructMonitors().TryGetValue(Type, ResponsibleMonitor);
      ResponsibleMonitor.UpdateFinance(GetPointer(this));
   }
}

void Construct::UpdateRisk(void) {
   if (!GetConstructMonitors().ContainsKey(Type)) {
      Print(CONSTRUCT_TYPE_DOES_NOT_EXIST);
   } else {
      ConstructMonitor *ResponsibleMonitor;
      GetConstructMonitors().TryGetValue(Type, ResponsibleMonitor);
      ResponsibleMonitor.UpdateRisk(GetPointer(this));
   }
}