#ifndef CONSTRUCT_PARAMETERS_H
#define CONSTRUCT_PARAMETERS_H

#include <Generic/Interfaces/IComparable.mqh>

class ConstructParameters : public IComparable<ConstructParameters*>
{
public:
   //--- Default Constructor
   ConstructParameters(void);
   
   //--- Main Constructor
   ConstructParameters(const double &InputCapstoneLevel, const double &InputApexLevel, const double &InputStopLossLevel, const int &InputIntervalSize);
   
   //--- Getter
   double GetCapstoneLevel(void) const;
   double GetApexLevel(void)     const;
   double GetStopLossLevel(void) const;
   int    GetIntervalSize(void)  const;
   
   //--- Required ADT Functions
   int  Compare(ConstructParameters* Other) override;
   bool Equals(ConstructParameters* Other) override;
   int  HashCode() override;

private:
   double CapstoneLevel;
   double ApexLevel;
   double StopLossLevel;
   int    IntervalSize;
};

#endif