#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/FreeStyling/Long/Five.mqh"

namespace _AnonymousFiveLevelNetLongFreeStylingConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   FiveLevelNetLongFreeStylingConstruct AnonymousFiveLevelNetLongFreeStylingConstructClone;
}

//--- Constructor
//--- Call To Register Type
FiveLevelNetLongFreeStylingConstructMonitor::FiveLevelNetLongFreeStylingConstructMonitor(void) {
   Type = _AnonymousFiveLevelNetLongFreeStylingConstructNameSpaceClone::AnonymousFiveLevelNetLongFreeStylingConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void FiveLevelNetLongFreeStylingConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   FiveLevelNetLongFreeStylingConstruct *MonitoredConstruct = dynamic_cast<FiveLevelNetLongFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void FiveLevelNetLongFreeStylingConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   FiveLevelNetLongFreeStylingConstruct *MonitoredConstruct = dynamic_cast<FiveLevelNetLongFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void FiveLevelNetLongFreeStylingConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   FiveLevelNetLongFreeStylingConstruct *MonitoredConstruct = dynamic_cast<FiveLevelNetLongFreeStylingConstruct*>(InputConstruct);
   
}