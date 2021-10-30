#property strict

#include "../../ConstructManagement/Construct/Construct.mqh"

//--- Main Constructor
Construct::Construct(void) {
   PMHP = PositionManagementHyperParameters::GetInstance();
}

//--- Destructor
Construct::~Construct(void) {
   delete FullTradePool;
   delete Pool;
   delete Key;
   delete Type;
   delete Parameters;
   delete RollingInfo;
   delete ResultInfo;
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
   return ResponsibleFactory.PreCheck(InputParameters);
}

//--- Find The Corresponding Construct Factory And Validate The Construct
static bool Construct::Validate(ConstructType *InputType, ConstructParameters *InputParameters, const int InputEntryPosition) {
   if (!GetConstructFactories().ContainsKey(InputType)) {
      Print(CONSTRUCT_TYPE_DOES_NOT_EXIST);
      return false;
   }
   ConstructFactory *ResponsibleFactory;
   GetConstructFactories().TryGetValue(InputType, ResponsibleFactory);
   return ResponsibleFactory.Validate(InputParameters, InputEntryPosition);
}

//--- Find The Corresponding Construct Factory And Get Factory To Create The Construct
static Construct *Construct::Create(ConstructType *InputType, ConstructParameters *InputParameters, const int InputEntryPosition) {
   if (!GetConstructFactories().ContainsKey(InputType)) {
      Print(CONSTRUCT_TYPE_DOES_NOT_EXIST);
      return NULL;
   }
   ConstructFactory *ResponsibleFactory;
   GetConstructFactories().TryGetValue(InputType, ResponsibleFactory);
   return ResponsibleFactory.Create(InputParameters, InputEntryPosition);
}

//--- Getters
ConstructFullTradePool *Construct::GetFullConstructTradePool(void) const { return FullTradePool;   }
ConstructTradePool     *Construct::GetConstructTradePool(void)     const { return Pool;            }
ConstructKey           *Construct::GetConstructKey(void)           const { return Key;             }
ConstructType          *Construct::GetConstructType(void)          const { return Type;            }
ConstructParameters    *Construct::GetConstructParameters(void)    const { return Parameters;      }
ConstructRollingInfo   *Construct::GetConstructRollingInfo(void)   const { return RollingInfo;     }
ConstructResultInfo    *Construct::GetConstructResultInfo(void)    const { return ResultInfo;      }
int                     Construct::GetEntryPositionID(void)        const { return EntryPositionID; }
int                     Construct::GetMultiplier(void)             const { return Multiplier;      }

//--- Setters
void Construct::SetConstructKey(ConstructKey *InputConstructKey)                      { Key             = InputConstructKey;        }
void Construct::SetConstructParameters(ConstructParameters *InputConstructParameters) { Parameters      = InputConstructParameters; }
void Construct::SetEntryPositionID(const int InputEntryPositionID)                    { EntryPositionID = InputEntryPositionID;     }
void Construct::SetFullTradePool(ConstructFullTradePool *InputFullTradePool)          { FullTradePool   = InputFullTradePool;       }
void Construct::SetMultiplier(const int InputMultiplier)                              { Multiplier      = InputMultiplier;          }

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