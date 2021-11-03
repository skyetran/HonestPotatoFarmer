#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/Counter/Short/Five.mqh"

namespace _AnonymousFiveLevelNetShortCounterConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   FiveLevelNetShortCounterConstruct AnonymousFiveLevelNetShortCounterConstructClone;
}

//--- Constructor
//--- Call To Register Type
FiveLevelNetShortCounterConstructMonitor::FiveLevelNetShortCounterConstructMonitor(void) {
   Type = _AnonymousFiveLevelNetShortCounterConstructNameSpaceClone::AnonymousFiveLevelNetShortCounterConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void FiveLevelNetShortCounterConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   FiveLevelNetShortCounterConstruct *MonitoredConstruct = dynamic_cast<FiveLevelNetShortCounterConstruct*>(InputConstruct);

}

//--- Operations
void FiveLevelNetShortCounterConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   FiveLevelNetShortCounterConstruct *MonitoredConstruct = dynamic_cast<FiveLevelNetShortCounterConstruct*>(InputConstruct);

}

//--- Operations
void FiveLevelNetShortCounterConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   FiveLevelNetShortCounterConstruct *MonitoredConstruct = dynamic_cast<FiveLevelNetShortCounterConstruct*>(InputConstruct);
   
}