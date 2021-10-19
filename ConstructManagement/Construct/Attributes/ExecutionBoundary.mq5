#property strict

#include "../../../ConstructManagement/Construct/Attributes/ExecutionBoundary.mqh"

//--- Default Constructor
ExecutionBoundary::ExecutionBoundary(void) {
   IP = IndicatorProcessor::GetInstance();
}

//--- Main Constructor
ExecutionBoundary::ExecutionBoundary(const double InputLowerBound, const double InputUpperBound) {
   BidLowerBound = MathMin(InputLowerBound, InputUpperBound);
   BidUpperBound = MathMax(InputLowerBound, InputUpperBound);
   AskLowerBound = BidLowerBound + IP.GetAverageSpreadInPrice(CURRENT_BAR);
   AskUpperBound = BidUpperBound + IP.GetAverageSpreadInPrice(CURRENT_BAR);
   
   HashString = DoubleToString(InputLowerBound) + DoubleToString(InputUpperBound);
}

//--- Getters
double ExecutionBoundary::GetBidLowerBound(void) const { return BidLowerBound; }
double ExecutionBoundary::GetBidUpperBound(void) const { return BidUpperBound; }
double ExecutionBoundary::GetAskLowerBound(void) const { return AskLowerBound; }
double ExecutionBoundary::GetAskUpperBound(void) const { return AskUpperBound; }

//--- Required ADT Functions
int ExecutionBoundary::Compare(ExecutionBoundary *Other) {
   //--- No Comparison Logics
   return 0;
}

bool ExecutionBoundary::Equals(ExecutionBoundary *Other) {
   return BidLowerBound == Other.GetBidLowerBound() &&
          BidUpperBound == Other.GetBidUpperBound() &&
          AskLowerBound == Other.GetAskLowerBound() &&
          AskUpperBound == Other.GetAskUpperBound()  ;
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