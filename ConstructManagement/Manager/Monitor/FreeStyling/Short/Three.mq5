#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/FreeStyling/Short/Three.mqh"

namespace _AnonymousThreeLevelNetShortFreeStylingConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   ThreeLevelNetShortFreeStylingConstruct AnonymousThreeLevelNetShortFreeStylingConstructClone;
}

//--- Constructor
//--- Call To Register Type
ThreeLevelNetShortFreeStylingConstructMonitor::ThreeLevelNetShortFreeStylingConstructMonitor(void) {
   Type = _AnonymousThreeLevelNetShortFreeStylingConstructNameSpaceClone::AnonymousThreeLevelNetShortFreeStylingConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void ThreeLevelNetShortFreeStylingConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   ThreeLevelNetShortFreeStylingConstruct *MonitoredConstruct = dynamic_cast<ThreeLevelNetShortFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void ThreeLevelNetShortFreeStylingConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   ThreeLevelNetShortFreeStylingConstruct *MonitoredConstruct = dynamic_cast<ThreeLevelNetShortFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void ThreeLevelNetShortFreeStylingConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   ThreeLevelNetShortFreeStylingConstruct *MonitoredConstruct = dynamic_cast<ThreeLevelNetShortFreeStylingConstruct*>(InputConstruct);
   
}