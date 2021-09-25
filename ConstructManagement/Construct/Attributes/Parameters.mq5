#property strict

#include "../../../ConstructManagement/Construct/Attributes/Parameters.mqh"

//--- Default Constructor
ConstructParameters::ConstructParameters(void) { }

//--- Main Constructor
ConstructParameters::ConstructParameters(const double InputCapstoneLevel, const double InputApexLevel, const double InputStopLossLevel, const int InputIntervalSize) {
   CapstoneLevel = InputCapstoneLevel;
   ApexLevel     = InputApexLevel;
   StopLossLevel = InputStopLossLevel;
   IntervalSize  = InputIntervalSize;
   
   HashString = DoubleToString(CapstoneLevel) + DoubleToString(ApexLevel) +
                DoubleToString(StopLossLevel) + DoubleToString(IntervalSize);
}

//--- Getters
double ConstructParameters::GetCapstoneLevel(void)       const { return CapstoneLevel;                           }
double ConstructParameters::GetApexLevel(void)           const { return ApexLevel;                               }
double ConstructParameters::GetStopLossLevel(void)       const { return StopLossLevel;                           }
int    ConstructParameters::GetIntervalSizeInPts(void)   const { return IntervalSize;                            }
double ConstructParameters::GetIntervalSizeInPrice(void) const { return PointToPriceCvt(GetIntervalSizeInPts()); }

//--- Required ADT Functions
int ConstructParameters::Compare(ConstructParameters *Other) {
   //--- No Comparison Logics
   return 0;
}

bool ConstructParameters::Equals(ConstructParameters *Other) {
   return CapstoneLevel == Other.GetCapstoneLevel()      &&
          ApexLevel     == Other.GetApexLevel()          &&
          StopLossLevel == Other.GetStopLossLevel()      &&
          IntervalSize  == Other.GetIntervalSizeInPts()   ;
}

int ConstructParameters::HashCode(void) {
   int Length    = StringLen(HashString);
   int HashValue = 0;
   
   if (Length > 0) {
      for (int i = 0; i < Length; i++) {
         HashValue = 31 * HashValue + HashString[i];
      }
   } 
   return HashValue;
}