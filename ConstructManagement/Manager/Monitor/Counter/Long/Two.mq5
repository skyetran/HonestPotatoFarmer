#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/Counter/Long/Two.mqh"

namespace _AnonymousTwoLevelNetLongCounterConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   TwoLevelNetLongCounterConstruct AnonymousTwoLevelNetLongCounterConstructClone;
}

//--- Constructor
//--- Call To Register Type
TwoLevelNetLongCounterConstructMonitor::TwoLevelNetLongCounterConstructMonitor(void) {
   Type = _AnonymousTwoLevelNetLongCounterConstructNameSpaceClone::AnonymousTwoLevelNetLongCounterConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void TwoLevelNetLongCounterConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   TwoLevelNetLongCounterConstruct *MonitoredConstruct = dynamic_cast<TwoLevelNetLongCounterConstruct*>(InputConstruct);

}

//--- Operations
void TwoLevelNetLongCounterConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   TwoLevelNetLongCounterConstruct *MonitoredConstruct = dynamic_cast<TwoLevelNetLongCounterConstruct*>(InputConstruct);

}

//--- Operations
void TwoLevelNetLongCounterConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   TwoLevelNetLongCounterConstruct *MonitoredConstruct = dynamic_cast<TwoLevelNetLongCounterConstruct*>(InputConstruct);
   
}