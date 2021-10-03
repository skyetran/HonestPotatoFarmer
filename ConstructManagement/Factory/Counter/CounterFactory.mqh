#ifndef COUNTER_FACTORY_H
#define COUNTER_FACTORY_H

#include "../ConstructFactory.mqh"
#include "UniqueComments.mqh"

class CounterFactory : public ConstructFactory
{
public:
   //--- Constructor
   CounterFactory(void);
   
protected:
   //--- Helper Functions For N-Level Long/Short Counter Construct
   double GetMaxLotSizeExposure(ConstructParameters *InputParameters, const int ConstructLevel)                                  const;
   double GetPersistingLotSizeExposure(ConstructParameters *InputParameters, const int ConstructLevel)                           const;
   int    GetMaxPotentialLossInMinLotPointValue(ConstructParameters *InputParameters, const int ConstructLevel)                  const;
   double GetCoveredAllCoveredCounterLotSize(ConstructParameters *InputParameters, const int ConstructLevel)                     const;
   double GetCoveredCounterLotSizeNLevel(const int CounterLevel, ConstructParameters *InputParameters, const int ConstructLevel) const;
   
private:
   //--- Helper Functions
   int    GetDeathZoneSize(ConstructParameters *InputParameters)                                                                  const;
   double ConvertToLotSize(const double &CoveredCounterInPts)                                                                     const;
   double GetAllCoveredCounterLotSize(ConstructParameters *InputParameters, const int ConstructLevel)                             const;
   double GetPossibleLossPerMinLotSizeForAllCoveredCounterLotSize(ConstructParameters *InputParameters, const int ConstructLevel) const;
};

#endif