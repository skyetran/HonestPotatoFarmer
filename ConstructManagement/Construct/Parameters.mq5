#property strict

#include "../../ConstructManagement/Construct/Parameters.mqh"

//--- Default Constructor
ConstructParameters::ConstructParameters(void) { }

//--- Main Constructor
ConstructParameters::ConstructParameters(double InputCapstoneLevel, double InputApexLevel, double InputStopLossLevel, int InputIntervalSize) {
   CapstoneLevel = InputCapstoneLevel;
   ApexLevel     = InputApexLevel;
   StopLossLevel = InputStopLossLevel;
   IntervalSize  = InputIntervalSize;
}

//--- Getters
double ConstructParameters::GetCapstoneLevel(void) const { return CapstoneLevel; }
double ConstructParameters::GetApexLevel(void)     const { return ApexLevel;     }
double ConstructParameters::GetStopLossLevel(void) const { return StopLossLevel; }
int    ConstructParameters::GetIntervalSize(void)  const { return IntervalSize;  }

//--- Required ADT Functions
int ConstructParameters::Compare(ConstructParameters *Other) {
   return 0;
}

bool ConstructParameters::Equals(ConstructParameters *Other) {
   return CapstoneLevel == Other.GetCapstoneLevel() &&
          ApexLevel     == Other.GetApexLevel()     &&
          StopLossLevel == Other.GetStopLossLevel() &&
          IntervalSize  == Other.GetIntervalSize()   ;
}

int ConstructParameters::HashCode(void) {
   return 0;
}