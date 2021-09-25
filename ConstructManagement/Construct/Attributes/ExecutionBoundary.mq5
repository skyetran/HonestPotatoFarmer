#property strict

#include "../../../ConstructManagement/Construct/Attributes/ExecutionBoundary.mqh"

//--- Default Constructor
ExecutionBoundary::ExecutionBoundary(void) { }

//--- Main Constructor
ExecutionBoundary::ExecutionBoundary(const double InputLowerBound, const double InputUpperBound) {
   LowerBound = InputLowerBound;
   UpperBound = InputUpperBound;
   
   HashString = DoubleToString(InputLowerBound) + DoubleToString(InputUpperBound);
}

//--- Getters
double ExecutionBoundary::GetLowerBound(void) const { return LowerBound; }
double ExecutionBoundary::GetUpperBound(void) const { return UpperBound; }

//--- Required ADT Functions
int ExecutionBoundary::Compare(ExecutionBoundary *Other) {
   //--- No Comparison Logics
   return 0;
}

bool ExecutionBoundary::Equals(ExecutionBoundary *Other) {
   return LowerBound == Other.GetLowerBound() &&
          UpperBound == Other.GetUpperBound()  ;
}

int ExecutionBoundary::HashCode(void) {
   int Length    = StringLen(HashString);
   int HashValue = 0;
   
   if (Length > 0) {
      for (int i = 0; i < Length; i++) {
         HashValue = 31 * HashValue + HashString[i];
      }
   } 
   return HashValue;
}