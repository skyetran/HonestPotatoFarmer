#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/Counter/Short/Two.mqh"

namespace _AnonymousTwoLevelNetShortCounterConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   TwoLevelNetShortCounterConstruct AnonymousTwoLevelNetShortCounterConstructClone;
}

//--- Constructor
//--- Call To Register Type
TwoLevelNetShortCounterConstructMonitor::TwoLevelNetShortCounterConstructMonitor(void) {
   Type = _AnonymousTwoLevelNetShortCounterConstructNameSpaceClone::AnonymousTwoLevelNetShortCounterConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void TwoLevelNetShortCounterConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   TwoLevelNetShortCounterConstruct *MonitoredConstruct = dynamic_cast<TwoLevelNetShortCounterConstruct*>(InputConstruct);

}

//--- Operations
void TwoLevelNetShortCounterConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   TwoLevelNetShortCounterConstruct *MonitoredConstruct = dynamic_cast<TwoLevelNetShortCounterConstruct*>(InputConstruct);

}

//--- Operations
void TwoLevelNetShortCounterConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   TwoLevelNetShortCounterConstruct *MonitoredConstruct = dynamic_cast<TwoLevelNetShortCounterConstruct*>(InputConstruct);
   
}