#property strict

#include "../../../ConstructManagement/Factory/FreeStyling/FreeStylingFactory.mqh"

//--- Constructor
FreeStylingFactory::FreeStylingFactory(void) { }

//--- Helper Functions For N-Level Long/Short FreeStyling Construct
double FreeStylingFactory::GetMaxLotSizeExposure(ConstructParameters *InputParameters, const int ConstructLevel) const {
   return GetCoveredAllCoveredRetracementLotSize(InputParameters, ConstructLevel) + GetAllCoveredRetracementLotSize(InputParameters, ConstructLevel) + ConstructLevel * MIN_LOT_SIZE;
}

//--- Helper Functions For N-Level Long/Short FreeStyling Construct
double FreeStylingFactory::GetPersistingLotSizeExposure(ConstructParameters *InputParameters, const int ConstructLevel) const {
   return GetAllCoveredRetracementLotSize(InputParameters, ConstructLevel) + ConstructLevel * MIN_LOT_SIZE;
}

//--- Helper Functions For N-Level Long/Short FreeStyling Construct
int FreeStylingFactory::GetMaxPotentialLossInMinLotPointValue(ConstructParameters *InputParameters, const int ConstructLevel) const {
   return (int) MathCeil((GetCoveredAllCoveredRetracementLotSize(InputParameters, ConstructLevel) + GetAllCoveredRetracementLotSize(InputParameters, ConstructLevel)) * (GetDeathZoneSize(InputParameters) + IP.GetAverageSpreadInPts(CURRENT_BAR)) * 100);
}

//--- Helper Functions For N-Level Long/Short FreeStyling Construct
double FreeStylingFactory::GetCoveredAllCoveredRetracementLotSize(ConstructParameters *InputParameters, const int ConstructLevel) const {
   double PossibleLossPerMinLotSize = GetPossibleLossPerMinLotSizeForAllCoveredRetracementLotSize(InputParameters, ConstructLevel);
   double GainedProfitPerMinLotSize = InputParameters.GetIntervalSizeInPts();
   double CoveredCounterLotSize     = PossibleLossPerMinLotSize / GainedProfitPerMinLotSize;
   return ConvertToLotSize(CoveredCounterLotSize);
}

//--- Helper Functions For N-Level Long/Short FreeStyling Construct
double FreeStylingFactory::GetCoveredRetracementLotSizeNLevel(const int RetracementLevel, ConstructParameters *InputParameters) const {
   double PossibleLossPerMinLotSize = InputParameters.GetIntervalSizeInPts() * RetracementLevel + GetDeathZoneSize(InputParameters);
   if (RetracementLevel == LEVEL_ZERO) {
      PossibleLossPerMinLotSize += GetDeathZoneSize(InputParameters) - InputParameters.GetIntervalSizeInPts() + IP.GetAverageSpreadInPts(CURRENT_BAR);
   }
   
   double GainedProfitPerMinLotSize = InputParameters.GetIntervalSizeInPts() * (RetracementLevel + 1);
   double CoveredCounterLotSize     = PossibleLossPerMinLotSize / GainedProfitPerMinLotSize;
   return ConvertToLotSize(CoveredCounterLotSize);
}

//--- Helper Functions
int FreeStylingFactory::GetDeathZoneSize(ConstructParameters *InputParameters) const {
   return PriceToPointCvt(MathAbs(InputParameters.GetCapstoneLevel() - InputParameters.GetStopLossLevel()));
}

//--- Helper Functions
double FreeStylingFactory::ConvertToLotSize(const double &CoveredCounterInPts) const {
   return MathMax(MIN_LOT_SIZE, NormalizeDouble(MathCeil(CoveredCounterInPts) / 100, 2));
}

//--- Helper Functions
double FreeStylingFactory::GetAllCoveredRetracementLotSize(ConstructParameters *InputParameters, const int ConstructLevel) const {
   double LotSize = 0;
   
   for (int RetracementLevel = LEVEL_ZERO; RetracementLevel < ConstructLevel; RetracementLevel++) {
      LotSize += GetCoveredRetracementLotSizeNLevel(RetracementLevel, InputParameters);
   }
   return LotSize;
}

//--- Helper Functions
double FreeStylingFactory::GetPossibleLossPerMinLotSizeForAllCoveredRetracementLotSize(ConstructParameters *InputParameters, const int ConstructLevel) const {
   return (GetDeathZoneSize(InputParameters) + IP.GetAverageSpreadInPts(CURRENT_BAR)) * GetAllCoveredRetracementLotSize(InputParameters, ConstructLevel) * 100;
}