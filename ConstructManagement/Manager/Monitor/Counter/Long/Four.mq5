#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/Counter/Long/Four.mqh"

namespace _AnonymousFourLevelNetLongCounterConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   FourLevelNetLongCounterConstruct AnonymousFourLevelNetLongCounterConstructClone;
}

//--- Constructor
//--- Call To Register Type
FourLevelNetLongCounterConstructMonitor::FourLevelNetLongCounterConstructMonitor(void) {
   Type = _AnonymousFourLevelNetLongCounterConstructNameSpaceClone::AnonymousFourLevelNetLongCounterConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void FourLevelNetLongCounterConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   FourLevelNetLongCounterConstruct *MonitoredConstruct = dynamic_cast<FourLevelNetLongCounterConstruct*>(InputConstruct);

}

//--- Operations
void FourLevelNetLongCounterConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   FourLevelNetLongCounterConstruct *MonitoredConstruct = dynamic_cast<FourLevelNetLongCounterConstruct*>(InputConstruct);

}

//--- Operations
void FourLevelNetLongCounterConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   FourLevelNetLongCounterConstruct *MonitoredConstruct = dynamic_cast<FourLevelNetLongCounterConstruct*>(InputConstruct);
   
}