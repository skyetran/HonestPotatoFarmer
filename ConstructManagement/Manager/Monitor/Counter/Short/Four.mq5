#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/Counter/Short/Four.mqh"

namespace _AnonymousFourLevelNetShortCounterConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   FourLevelNetShortCounterConstruct AnonymousFourLevelNetShortCounterConstructClone;
}

//--- Constructor
//--- Call To Register Type
FourLevelNetShortCounterConstructMonitor::FourLevelNetShortCounterConstructMonitor(void) {
   Type = _AnonymousFourLevelNetShortCounterConstructNameSpaceClone::AnonymousFourLevelNetShortCounterConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void FourLevelNetShortCounterConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   FourLevelNetShortCounterConstruct *MonitoredConstruct = dynamic_cast<FourLevelNetShortCounterConstruct*>(InputConstruct);

}

//--- Operations
void FourLevelNetShortCounterConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   FourLevelNetShortCounterConstruct *MonitoredConstruct = dynamic_cast<FourLevelNetShortCounterConstruct*>(InputConstruct);

}

//--- Operations
void FourLevelNetShortCounterConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   FourLevelNetShortCounterConstruct *MonitoredConstruct = dynamic_cast<FourLevelNetShortCounterConstruct*>(InputConstruct);
   
}