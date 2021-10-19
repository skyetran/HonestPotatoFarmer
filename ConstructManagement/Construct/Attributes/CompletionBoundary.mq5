#property strict

#include "../../../ConstructManagement/Construct/Attributes/CompletionBoundary.mqh"

//--- Default Constructor
CompletionBoundary::CompletionBoundary(void) {
   IP = IndicatorProcessor::GetInstance();
}

//--- Main Constructor
CompletionBoundary::CompletionBoundary(const double InputLowerBound, const double InputUpperBound) {
   BidLowerBound = MathMin(InputLowerBound, InputUpperBound);
   BidUpperBound = MathMax(InputLowerBound, InputUpperBound);
   AskLowerBound = BidLowerBound + IP.GetAverageSpreadInPrice(CURRENT_BAR);
   AskUpperBound = BidUpperBound + IP.GetAverageSpreadInPrice(CURRENT_BAR);
   
   HashString = DoubleToString(InputLowerBound) + DoubleToString(InputUpperBound);
}

//--- Getters
double CompletionBoundary::GetBidLowerBound(void) const { return BidLowerBound; }
double CompletionBoundary::GetBidUpperBound(void) const { return BidUpperBound; }
double CompletionBoundary::GetAskLowerBound(void) const { return AskLowerBound; }
double CompletionBoundary::GetAskUpperBound(void) const { return AskUpperBound; }

//--- Required ADT Functions
int CompletionBoundary::Compare(CompletionBoundary *Other) {
   //--- No Comparison Logics
   return 0;
}

bool CompletionBoundary::Equals(CompletionBoundary *Other) {
   return BidLowerBound == Other.GetBidLowerBound() &&
          BidUpperBound == Other.GetBidUpperBound() &&
          AskLowerBound == Other.GetAskLowerBound() &&
          AskUpperBound == Other.GetAskUpperBound()  ;
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