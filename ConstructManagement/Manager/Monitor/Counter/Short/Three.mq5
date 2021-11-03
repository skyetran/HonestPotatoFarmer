#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/Counter/Short/Three.mqh"

namespace _AnonymousThreeLevelNetShortCounterConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   ThreeLevelNetShortCounterConstruct AnonymousThreeLevelNetShortCounterConstructClone;
}

//--- Constructor
//--- Call To Register Type
ThreeLevelNetShortCounterConstructMonitor::ThreeLevelNetShortCounterConstructMonitor(void) {
   Type = _AnonymousThreeLevelNetShortCounterConstructNameSpaceClone::AnonymousThreeLevelNetShortCounterConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void ThreeLevelNetShortCounterConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   ThreeLevelNetShortCounterConstruct *MonitoredConstruct = dynamic_cast<ThreeLevelNetShortCounterConstruct*>(InputConstruct);

}

//--- Operations
void ThreeLevelNetShortCounterConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   ThreeLevelNetShortCounterConstruct *MonitoredConstruct = dynamic_cast<ThreeLevelNetShortCounterConstruct*>(InputConstruct);

}

//--- Operations
void ThreeLevelNetShortCounterConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   ThreeLevelNetShortCounterConstruct *MonitoredConstruct = dynamic_cast<ThreeLevelNetShortCounterConstruct*>(InputConstruct);
   
}