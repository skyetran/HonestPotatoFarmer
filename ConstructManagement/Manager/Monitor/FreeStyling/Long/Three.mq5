#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/FreeStyling/Long/Three.mqh"

namespace _AnonymousThreeLevelNetLongFreeStylingConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   ThreeLevelNetLongFreeStylingConstruct AnonymousThreeLevelNetLongFreeStylingConstructClone;
}

//--- Constructor
//--- Call To Register Type
ThreeLevelNetLongFreeStylingConstructMonitor::ThreeLevelNetLongFreeStylingConstructMonitor(void) {
   Type = _AnonymousThreeLevelNetLongFreeStylingConstructNameSpaceClone::AnonymousThreeLevelNetLongFreeStylingConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void ThreeLevelNetLongFreeStylingConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   ThreeLevelNetLongFreeStylingConstruct *MonitoredConstruct = dynamic_cast<ThreeLevelNetLongFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void ThreeLevelNetLongFreeStylingConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   ThreeLevelNetLongFreeStylingConstruct *MonitoredConstruct = dynamic_cast<ThreeLevelNetLongFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void ThreeLevelNetLongFreeStylingConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   ThreeLevelNetLongFreeStylingConstruct *MonitoredConstruct = dynamic_cast<ThreeLevelNetLongFreeStylingConstruct*>(InputConstruct);
   
}