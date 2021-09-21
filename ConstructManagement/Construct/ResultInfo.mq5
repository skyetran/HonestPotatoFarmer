#property strict

#include "../../ConstructManagement/Construct/ResultInfo.mqh"

//--- Default Constructor
ConstructResultInfo::ConstructResultInfo(void) { }

//--- Main Constructor
ConstructResultInfo::ConstructResultInfo(const double InputTotalRealizedProfit, const double InputMaxRisk) {
   TotalRealizedProfit = InputTotalRealizedProfit;
   MaxRisk             = InputMaxRisk;
}

double ConstructResultInfo::GetTotalRealizedProfit(void) const { return TotalRealizedProfit; }
double ConstructResultInfo::GetMaxRisk(void)             const { return MaxRisk;             }