#property strict

#include "../../ConstructManagement/Construct/PreCheckInfo.mqh"

//--- Default Constructor
ConstructPreCheckInfo::ConstructPreCheckInfo(void) { }

//--- Main Constructor
ConstructPreCheckInfo::ConstructPreCheckInfo(const double InputMaxMarginRequirement, const double InputPersistingMarginRequirement, const double InputMaxPotentialLoss) {
   MaxMarginRequirement        = InputMaxMarginRequirement;
   PersistingMarginRequirement = InputPersistingMarginRequirement;
   MaxPotentialLoss            = InputMaxPotentialLoss;
}

//--- Getters
double ConstructPreCheckInfo::GetMaxMarginRequirement(void)        const { return MaxMarginRequirement;        }
double ConstructPreCheckInfo::GetPersistingMarginRequirement(void) const { return PersistingMarginRequirement; }
double ConstructPreCheckInfo::GetMaxPotentialLoss(void)            const { return MaxPotentialLoss;            }