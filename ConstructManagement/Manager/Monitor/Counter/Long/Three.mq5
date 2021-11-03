#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/Counter/Long/Three.mqh"

namespace _AnonymousThreeLevelNetLongCounterConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   ThreeLevelNetLongCounterConstruct AnonymousThreeLevelNetLongCounterConstructClone;
}

//--- Constructor
//--- Call To Register Type
ThreeLevelNetLongCounterConstructMonitor::ThreeLevelNetLongCounterConstructMonitor(void) {
   Type = _AnonymousThreeLevelNetLongCounterConstructNameSpaceClone::AnonymousThreeLevelNetLongCounterConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void ThreeLevelNetLongCounterConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   ThreeLevelNetLongCounterConstruct *MonitoredConstruct = dynamic_cast<ThreeLevelNetLongCounterConstruct*>(InputConstruct);

}

//--- Operations
void ThreeLevelNetLongCounterConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   ThreeLevelNetLongCounterConstruct *MonitoredConstruct = dynamic_cast<ThreeLevelNetLongCounterConstruct*>(InputConstruct);

}

//--- Operations
void ThreeLevelNetLongCounterConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   ThreeLevelNetLongCounterConstruct *MonitoredConstruct = dynamic_cast<ThreeLevelNetLongCounterConstruct*>(InputConstruct);
   
}