#property strict

#include "../../../ConstructManagement/Construct/Attributes/RollingInfo.mqh"

//--- Main Constructor
ConstructRollingInfo::ConstructRollingInfo(void) { }

//--- Updaters
void ConstructRollingInfo::UpdateReleasedFreeMargin(const double NewReleasedFreeMargin) {
   ReleasedFreeMargin = NewReleasedFreeMargin;
}

void ConstructRollingInfo::UpdatePositiveSlippageInPrice(const double NewPositiveSlippageInPrice) {
   PositiveSlippageInPrice = NewPositiveSlippageInPrice;
}

void ConstructRollingInfo::UpdatePositiveSlippageInPts(const int NewPositiveSlippageInPts) {
   PositiveSlippageInPts = NewPositiveSlippageInPts;
}

void ConstructRollingInfo::UpdateValueAtRisk(const double NewValueAtRisk) {
   ValueAtRisk = NewValueAtRisk;
}

void ConstructRollingInfo::UpdateActiveStatus(const bool NewActiveStatus) {
   ActiveStatus = NewActiveStatus;
}

double ConstructRollingInfo::GetReleasedFreeMargin(void)      const { return ReleasedFreeMargin;      }
double ConstructRollingInfo::GetPositiveSlippageInPrice(void) const { return PositiveSlippageInPrice; }
int    ConstructRollingInfo::GetPositiveSlippageInPts(void)   const { return PositiveSlippageInPts;   }
double ConstructRollingInfo::GetValueAtRisk(void)             const { return ValueAtRisk;             }
bool   ConstructRollingInfo::IsRiskFree(void)                 const { return ValueAtRisk == 0;        }
bool   ConstructRollingInfo::HasCompleteLifeCycle(void)       const { return !ActiveStatus;           }