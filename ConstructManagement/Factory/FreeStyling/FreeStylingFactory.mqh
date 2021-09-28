#ifndef FREE_STYLING_FACTORY_H
#define FREE_STYLING_FACTORY_H

#include "../ConstructFactory.mqh"

class FreeStylingFactory : public ConstructFactory
{
public:
   //--- Constructor
   FreeStylingFactory(void);

protected:
   //--- Helper Functions For N-Level Long/Short FreeStyling Construct
   double GetMaxLotSizeExposure(ConstructParameters *InputParameters, const int ConstructLevel)                  const;
   double GetPersistingLotSizeExposure(ConstructParameters *InputParameters, const int ConstructLevel)           const;
   int    GetMaxPotentialLossInMinLotPointValue(ConstructParameters *InputParameters, const int ConstructLevel)  const;
   double GetCoveredAllCoveredRetracementLotSize(ConstructParameters *InputParameters, const int ConstructLevel) const;
   double GetCoveredRetracementLotSizeNLevel(const int RetracementLevel, ConstructParameters *InputParameters)   const;
   
private:
   //--- Helper Functions
   int    GetDeathZoneSize(ConstructParameters *InputParameters)                                                                      const;
   double ConvertToLotSize(const double &CoveredCounterInPts)                                                                         const;
   double GetCoveredRetracementLotSizeFirstLevelBias(ConstructParameters *InputParameters)                                            const;
   double GetAllCoveredRetracementLotSize(ConstructParameters *InputParameters, const int ConstructLevel)                             const;
   double GetPossibleLossPerMinLotSizeForAllCoveredRetracementLotSize(ConstructParameters *InputParameters, const int ConstructLevel) const;

};

#endif