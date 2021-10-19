#ifndef EXECUTION_BOUNDARY_H
#define EXECUTION_BOUNDARY_H

#include <Generic/Interfaces/IComparable.mqh>

#include "../../../General/IndicatorProcessor.mqh"

class ExecutionBoundary : public IComparable<ExecutionBoundary*>
{
public:
   //--- Default Constructor
   ExecutionBoundary(void);
   
   //--- Main Constructor
   ExecutionBoundary(const double InputLowerBound, const double InputUpperBound);
   
   //--- Getter
   double GetBidLowerBound(void) const;
   double GetBidUpperBound(void) const;
   double GetAskLowerBound(void) const;
   double GetAskUpperBound(void) const;

   //--- Required ADT Functions
   int  Compare(ExecutionBoundary* Other) override;
   bool Equals(ExecutionBoundary* Other)  override;
   int  HashCode(void)                    override;

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