#property strict

#include "../../ConstructManagement/Construct/Type.mqh"

//--- Default Constructor
ConstructType::ConstructType(void) { }

//--- Main Constructor
ConstructType::ConstructType(const ENUM_CONSTRUCT_CLASS InputClass, const int InputLevel) {
   Class = InputClass;
   Level = InputLevel;
}

//--- Getters
ENUM_CONSTRUCT_CLASS ConstructType::GetClass(void) const { return Class; }
int                  ConstructType::GetLevel(void) const { return Level; }

//--- Required ADT Functions
int ConstructType::Compare(ConstructType *Other) {
   //--- No Comparison Logic
   return 0;
}

bool ConstructType::Equals(ConstructType *Other) {
   return Class == Other.GetClass() &&
          Level == Other.GetLevel()  ;
}

int ConstructType::HashCode(void) {
   return Class * 10 + Level;
}