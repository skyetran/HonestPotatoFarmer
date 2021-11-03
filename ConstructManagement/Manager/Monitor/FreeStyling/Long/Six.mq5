#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/FreeStyling/Long/Six.mqh"

namespace _AnonymousSixLevelNetLongFreeStylingConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   SixLevelNetLongFreeStylingConstruct AnonymousSixLevelNetLongFreeStylingConstructClone;
}

//--- Constructor
//--- Call To Register Type
SixLevelNetLongFreeStylingConstructMonitor::SixLevelNetLongFreeStylingConstructMonitor(void) {
   Type = _AnonymousSixLevelNetLongFreeStylingConstructNameSpaceClone::AnonymousSixLevelNetLongFreeStylingConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void SixLevelNetLongFreeStylingConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   SixLevelNetLongFreeStylingConstruct *MonitoredConstruct = dynamic_cast<SixLevelNetLongFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void SixLevelNetLongFreeStylingConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   SixLevelNetLongFreeStylingConstruct *MonitoredConstruct = dynamic_cast<SixLevelNetLongFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void SixLevelNetLongFreeStylingConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   SixLevelNetLongFreeStylingConstruct *MonitoredConstruct = dynamic_cast<SixLevelNetLongFreeStylingConstruct*>(InputConstruct);
   
}