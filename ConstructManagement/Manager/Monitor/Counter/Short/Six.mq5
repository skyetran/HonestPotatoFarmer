#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/Counter/Short/Six.mqh"

namespace _AnonymousSixLevelNetShortCounterConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   SixLevelNetShortCounterConstruct AnonymousSixLevelNetShortCounterConstructClone;
}

//--- Constructor
//--- Call To Register Type
SixLevelNetShortCounterConstructMonitor::SixLevelNetShortCounterConstructMonitor(void) {
   Type = _AnonymousSixLevelNetShortCounterConstructNameSpaceClone::AnonymousSixLevelNetShortCounterConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void SixLevelNetShortCounterConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   SixLevelNetShortCounterConstruct *MonitoredConstruct = dynamic_cast<SixLevelNetShortCounterConstruct*>(InputConstruct);

}

//--- Operations
void SixLevelNetShortCounterConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   SixLevelNetShortCounterConstruct *MonitoredConstruct = dynamic_cast<SixLevelNetShortCounterConstruct*>(InputConstruct);

}

//--- Operations
void SixLevelNetShortCounterConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   SixLevelNetShortCounterConstruct *MonitoredConstruct = dynamic_cast<SixLevelNetShortCounterConstruct*>(InputConstruct);
   
}