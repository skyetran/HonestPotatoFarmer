#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/Counter/Long/Six.mqh"

namespace _AnonymousSixLevelNetLongCounterConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   SixLevelNetLongCounterConstruct AnonymousSixLevelNetLongCounterConstructClone;
}

//--- Constructor
//--- Call To Register Type
SixLevelNetLongCounterConstructMonitor::SixLevelNetLongCounterConstructMonitor(void) {
   Type = _AnonymousSixLevelNetLongCounterConstructNameSpaceClone::AnonymousSixLevelNetLongCounterConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void SixLevelNetLongCounterConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   SixLevelNetLongCounterConstruct *MonitoredConstruct = dynamic_cast<SixLevelNetLongCounterConstruct*>(InputConstruct);

}

//--- Operations
void SixLevelNetLongCounterConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   SixLevelNetLongCounterConstruct *MonitoredConstruct = dynamic_cast<SixLevelNetLongCounterConstruct*>(InputConstruct);

}

//--- Operations
void SixLevelNetLongCounterConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   SixLevelNetLongCounterConstruct *MonitoredConstruct = dynamic_cast<SixLevelNetLongCounterConstruct*>(InputConstruct);
   
}