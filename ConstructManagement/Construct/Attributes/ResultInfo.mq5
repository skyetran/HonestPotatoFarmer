#property strict

#include "../../../ConstructManagement/Construct/Attributes/ResultInfo.mqh"

//--- Default Constructor
ConstructResultInfo::ConstructResultInfo(void) { }

//--- Main Constructor
ConstructResultInfo::ConstructResultInfo(const double InputTotalRealizedProfit, const double InputMaxRisk) {
   TotalRealizedProfit = InputTotalRealizedProfit;
   MaxRisk             = InputMaxRisk;
}

//--- Getters
double ConstructResultInfo::GetTotalRealizedProfit(void) const { return TotalRealizedProfit; }
double ConstructResultInfo::GetMaxRisk(void)             const { return MaxRisk;             }

//--- Updaters
void ConstructResultInfo::UpdateTotalRealizedProfit(const double NewTotalRealizedProfit) {
   TotalRealizedProfit = NewTotalRealizedProfit;
}

//--- Updaters
void ConstructResultInfo::UpdateMaxRisk(const double NewMaxRisk) {
   MaxRisk = MathMax(MaxRisk, NewMaxRisk);
}