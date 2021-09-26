#property strict

#include "../../../ConstructManagement/Factory/Counter/CounterFactory.mqh"

//--- Construct
CounterFactory::CounterFactory(void) { }

//--- Helper Functions For N-Level Long/Short Counter Construct
double CounterFactory::GetMaxLotSizeExposure(ConstructParameters *InputParameters, const int ConstructLevel) const {
   return GetCoveredAllCoveredCounterLotSize(InputParameters, ConstructLevel) + GetAllCoveredCounterLotSize(InputParameters, ConstructLevel);
}

//--- Helper Functions For N-Level Long/Short Counter Construct
double CounterFactory::GetPersistingLotSizeExposure(ConstructParameters *InputParameters, const int ConstructLevel) const {
   return GetAllCoveredCounterLotSize(InputParameters, ConstructLevel);
}

//--- Helper Functions For N-Level Long/Short Counter Construct
int CounterFactory::GetMaxPotentialLossInMinLotPointValue(ConstructParameters *InputParameters, const int ConstructLevel) const {
   return (int) MathCeil(GetMaxLotSizeExposure(InputParameters, ConstructLevel) * (GetDeathZoneSize(InputParameters) + IP.GetAverageSpreadInPts(CURRENT_BAR)) * 100);
}

//--- Helper Functions For N-Level Long/Short Counter Construct
double CounterFactory::GetCoveredAllCoveredCounterLotSize(ConstructParameters *InputParameters, const int ConstructLevel) const {
   double PossibleLossPerMinLotSize = GetPossibleLossPerMinLotSizeForAllCoveredCounterLotSize(InputParameters, ConstructLevel);
   double GainedProfitPerMinLotSize = InputParameters.GetIntervalSizeInPts();
   double CoveredCounterLotSize     = PossibleLossPerMinLotSize / GainedProfitPerMinLotSize;
   return ConvertToLotSize(CoveredCounterLotSize);
}

//--- Helper Functions For N-Level Long/Short Counter Construct
double CounterFactory::GetCoveredCounterLotSizeNLevel(const int CounterLevel, ConstructParameters *InputParameters, const int ConstructLevel) const {
   double PossibleLossPerMinLotSize = IP.GetAverageSpreadInPts(CURRENT_BAR) + PMHP.GetOutOfBoundBufferInPts() + InputParameters.GetIntervalSizeInPts() * CounterLevel;
   double GainedProfitPerMinLotSize = InputParameters.GetIntervalSizeInPts() * (ConstructLevel - CounterLevel);
   double CoveredCounterLotSize     = PossibleLossPerMinLotSize / GainedProfitPerMinLotSize;
   return ConvertToLotSize(CoveredCounterLotSize);
}

//--- Helper Functions
int CounterFactory::GetDeathZoneSize(ConstructParameters *InputParameters) const {
   return PriceToPointCvt(MathAbs(InputParameters.GetCapstoneLevel() - InputParameters.GetStopLossLevel()));
}

//--- Helper Functions
double CounterFactory::ConvertToLotSize(const double &CoveredCounterInPts) const {
   return NormalizeDouble(MathCeil(CoveredCounterInPts) / 100, 2);
}

//--- Helper Functions
double CounterFactory::GetAllCoveredCounterLotSize(ConstructParameters *InputParameters, const int ConstructLevel) const {
   double LotSize = 0;
   
   for (int CounterLevel = 0; CounterLevel < ConstructLevel - 1; CounterLevel++) {
      LotSize += GetCoveredCounterLotSizeNLevel(CounterLevel, InputParameters, ConstructLevel);
   }
   return LotSize;
}

//--- Helper Functions
double CounterFactory::GetPossibleLossPerMinLotSizeForAllCoveredCounterLotSize(ConstructParameters *InputParameters, const int ConstructLevel) const {
   int DeathZoneSize = GetDeathZoneSize(InputParameters);
   return (DeathZoneSize + IP.GetAverageSpreadInPts(CURRENT_BAR)) * GetAllCoveredCounterLotSize(InputParameters, ConstructLevel);
}