#ifndef COMPLETION_BOUNDARY_H
#define COMPLETION_BOUNDARY_H

#include <Generic/Interfaces/IComparable.mqh>

#include "../../../General/IndicatorProcessor.mqh"

class CompletionBoundary : public IComparable<CompletionBoundary*>
{
public:
   //--- Default Constructor
   CompletionBoundary(void);
   
   //--- Main Constructor
   CompletionBoundary(const double InputLowerBound, const double InputUpperBound);
   
   //--- Getter
   double GetBidLowerBound(void) const;
   double GetBidUpperBound(void) const;
   double GetAskLowerBound(void) const;
   double GetAskUpperBound(void) const;
   
   //--- Required ADT Functions
   int  Compare(CompletionBoundary* Other) override;
   bool Equals(CompletionBoundary* Other)  override;
   int  HashCode(void)                     override;

private:
   //--- External Entities
   IndicatorProcessor *IP;
   
   double BidLowerBound;
   double BidUpperBound;
   double AskLowerBound;
   double AskUpperBound;
   
   string HashString;
};

#endif