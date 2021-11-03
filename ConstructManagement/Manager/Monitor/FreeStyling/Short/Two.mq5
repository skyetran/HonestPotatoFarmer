#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/FreeStyling/Short/Two.mqh"

namespace _AnonymousTwoLevelNetShortFreeStylingConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   TwoLevelNetShortFreeStylingConstruct AnonymousTwoLevelNetShortFreeStylingConstructClone;
}

//--- Constructor
//--- Call To Register Type
TwoLevelNetShortFreeStylingConstructMonitor::TwoLevelNetShortFreeStylingConstructMonitor(void) {
   Type = _AnonymousTwoLevelNetShortFreeStylingConstructNameSpaceClone::AnonymousTwoLevelNetShortFreeStylingConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void TwoLevelNetShortFreeStylingConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   TwoLevelNetShortFreeStylingConstruct *MonitoredConstruct = dynamic_cast<TwoLevelNetShortFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void TwoLevelNetShortFreeStylingConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   TwoLevelNetShortFreeStylingConstruct *MonitoredConstruct = dynamic_cast<TwoLevelNetShortFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void TwoLevelNetShortFreeStylingConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   TwoLevelNetShortFreeStylingConstruct *MonitoredConstruct = dynamic_cast<TwoLevelNetShortFreeStylingConstruct*>(InputConstruct);
   
}