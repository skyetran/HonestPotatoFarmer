#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/FreeStyling/Short/Five.mqh"

namespace _AnonymousFiveLevelNetShortFreeStylingConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   FiveLevelNetShortFreeStylingConstruct AnonymousFiveLevelNetShortFreeStylingConstructClone;
}

//--- Constructor
//--- Call To Register Type
FiveLevelNetShortFreeStylingConstructMonitor::FiveLevelNetShortFreeStylingConstructMonitor(void) {
   Type = _AnonymousFiveLevelNetShortFreeStylingConstructNameSpaceClone::AnonymousFiveLevelNetShortFreeStylingConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void FiveLevelNetShortFreeStylingConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   FiveLevelNetShortFreeStylingConstruct *MonitoredConstruct = dynamic_cast<FiveLevelNetShortFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void FiveLevelNetShortFreeStylingConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   FiveLevelNetShortFreeStylingConstruct *MonitoredConstruct = dynamic_cast<FiveLevelNetShortFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void FiveLevelNetShortFreeStylingConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   FiveLevelNetShortFreeStylingConstruct *MonitoredConstruct = dynamic_cast<FiveLevelNetShortFreeStylingConstruct*>(InputConstruct);
   
}