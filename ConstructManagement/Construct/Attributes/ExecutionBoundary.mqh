#ifndef EXECUTION_BOUNDARY_H
#define EXECUTION_BOUNDARY_H

#include <Generic/Interfaces/IComparable.mqh>

class ExecutionBoundary : public IComparable<ExecutionBoundary*>
{
public:
   //--- Default Constructor
   ExecutionBoundary(void);
   
   //--- Main Constructor
   ExecutionBoundary(const double InputLowerBound, const double InputUpperBound);
   
   //--- Getter
   double GetLowerBound(void) const;
   double GetUpperBound(void) const;

   //--- Required ADT Functions
   int  Compare(ExecutionBoundary* Other) override;
   bool Equals(ExecutionBoundary* Other)  override;
   int  HashCode(void)                    override;

private:
   double LowerBound;
   double UpperBound;
   
   string HashString;
};

#endif