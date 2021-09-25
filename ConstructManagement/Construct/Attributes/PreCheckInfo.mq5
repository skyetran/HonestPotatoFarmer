#property strict

#include "../../../ConstructManagement/Construct/Attributes/PreCheckInfo.mqh"

//--- Default Constructor
ConstructPreCheckInfo::ConstructPreCheckInfo(void) { }

//--- Main Constructor
ConstructPreCheckInfo::ConstructPreCheckInfo(const double InputMaxLotSizeExposure, const double InputPersistingLotSizeExposure, const int InputMaxPotentialLossInMinLotPointValue) {
   MaxLotSizeExposure                 = InputMaxLotSizeExposure;
   PersistingLotSizeExposure          = InputPersistingLotSizeExposure;
   MaxPotentialLossInMinLotPointValue = InputMaxPotentialLossInMinLotPointValue;
}

//--- Getters
double ConstructPreCheckInfo::GetMaxLotSizeExposure(void)                 const { return MaxLotSizeExposure;                 }
double ConstructPreCheckInfo::GetPersistingLotSizeExposure(void)          const { return PersistingLotSizeExposure;          }
int    ConstructPreCheckInfo::GetMaxPotentialLossInMinLotPointValue(void) const { return MaxPotentialLossInMinLotPointValue; }