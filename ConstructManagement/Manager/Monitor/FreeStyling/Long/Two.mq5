#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/FreeStyling/Long/Two.mqh"

namespace _AnonymousTwoLevelNetLongFreeStylingConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   TwoLevelNetLongFreeStylingConstruct AnonymousTwoLevelNetLongFreeStylingConstructClone;
}

//--- Constructor
//--- Call To Register Type
TwoLevelNetLongFreeStylingConstructMonitor::TwoLevelNetLongFreeStylingConstructMonitor(void) {
   Type = _AnonymousTwoLevelNetLongFreeStylingConstructNameSpaceClone::AnonymousTwoLevelNetLongFreeStylingConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void TwoLevelNetLongFreeStylingConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   TwoLevelNetLongFreeStylingConstruct *MonitoredConstruct = dynamic_cast<TwoLevelNetLongFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void TwoLevelNetLongFreeStylingConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   TwoLevelNetLongFreeStylingConstruct *MonitoredConstruct = dynamic_cast<TwoLevelNetLongFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void TwoLevelNetLongFreeStylingConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   TwoLevelNetLongFreeStylingConstruct *MonitoredConstruct = dynamic_cast<TwoLevelNetLongFreeStylingConstruct*>(InputConstruct);
   
}