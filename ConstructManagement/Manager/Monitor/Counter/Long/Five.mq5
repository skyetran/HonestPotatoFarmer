#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/Counter/Long/Five.mqh"

namespace _AnonymousFiveLevelNetLongCounterConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   FiveLevelNetLongCounterConstruct AnonymousFiveLevelNetLongCounterConstructClone;
}

//--- Constructor
//--- Call To Register Type
FiveLevelNetLongCounterConstructMonitor::FiveLevelNetLongCounterConstructMonitor(void) {
   Type = _AnonymousFiveLevelNetLongCounterConstructNameSpaceClone::AnonymousFiveLevelNetLongCounterConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void FiveLevelNetLongCounterConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   FiveLevelNetLongCounterConstruct *MonitoredConstruct = dynamic_cast<FiveLevelNetLongCounterConstruct*>(InputConstruct);

}

//--- Operations
void FiveLevelNetLongCounterConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   FiveLevelNetLongCounterConstruct *MonitoredConstruct = dynamic_cast<FiveLevelNetLongCounterConstruct*>(InputConstruct);

}

//--- Operations
void FiveLevelNetLongCounterConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   FiveLevelNetLongCounterConstruct *MonitoredConstruct = dynamic_cast<FiveLevelNetLongCounterConstruct*>(InputConstruct);
   
}