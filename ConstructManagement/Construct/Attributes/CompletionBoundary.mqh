#ifndef COMPLETION_BOUNDARY_H
#define COMPLETION_BOUNDARY_H

#include <Generic/Interfaces/IComparable.mqh>

class CompletionBoundary : public IComparable<CompletionBoundary*>
{
public:
   //--- Default Constructor
   CompletionBoundary(void);
   
   //--- Main Constructor
   CompletionBoundary(const double InputLowerBound, const double InputUpperBound);
   
   //--- Getter
   double GetLowerBound(void) const;
   double GetUpperBound(void) const;

   //--- Required ADT Functions
   int  Compare(CompletionBoundary* Other) override;
   bool Equals(CompletionBoundary* Other)  override;
   int  HashCode(void)                    override;

private:
   double LowerBound;
   double UpperBound;
   
   string HashString;
};

#endif