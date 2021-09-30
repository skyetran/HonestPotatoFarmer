#property strict

#include "../../../ConstructManagement/Construct/Attributes/CompletionBoundary.mqh"

//--- Default Constructor
CompletionBoundary::CompletionBoundary(void) { }

//--- Main Constructor
CompletionBoundary::CompletionBoundary(const double InputLowerBound, const double InputUpperBound) {
   LowerBound = MathMin(InputLowerBound, InputUpperBound);
   UpperBound = MathMax(InputLowerBound, InputUpperBound);
   
   HashString = DoubleToString(InputLowerBound) + DoubleToString(InputUpperBound);
}

//--- Getters
double CompletionBoundary::GetLowerBound(void) const { return LowerBound; }
double CompletionBoundary::GetUpperBound(void) const { return UpperBound; }

//--- Required ADT Functions
int CompletionBoundary::Compare(CompletionBoundary *Other) {
   //--- No Comparison Logics
   return 0;
}

bool CompletionBoundary::Equals(CompletionBoundary *Other) {
   return LowerBound == Other.GetLowerBound() &&
          UpperBound == Other.GetUpperBound()  ;
}

int CompletionBoundary::HashCode(void) {
   int Length    = StringLen(HashString);
   int HashValue = 0;
   
   if (Length > 0) {
      for (int i = 0; i < Length; i++) {
         HashValue = 31 * HashValue + HashString[i];
      }
   } 
   return HashValue;
}