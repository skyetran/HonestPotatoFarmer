#property strict

#include "../../../ConstructManagement/Construct/Attributes/Key.mqh"

//--- Default Constructor
ConstructKey::ConstructKey(void) { }

//--- Main Constructor
ConstructKey::ConstructKey(ConstructType *InputType, ConstructParameters *InputParameters, const int InputEntryPositionID) {
   Type            = InputType;
   Parameters      = InputParameters;
   EntryPositionID = InputEntryPositionID;
}

//--- Getters
ConstructType       *ConstructKey::GetConstructType(void)       const { return Type;            }
ConstructParameters *ConstructKey::GetConstructParameters(void) const { return Parameters;      }
int                  ConstructKey::GetEntryPositionID(void)     const { return EntryPositionID; }