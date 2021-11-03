#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/Counter/Short/Seven.mqh"

namespace _AnonymousSevenLevelNetShortCounterConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   SevenLevelNetShortCounterConstruct AnonymousSevenLevelNetShortCounterConstructClone;
}

//--- Constructor
//--- Call To Register Type
SevenLevelNetShortCounterConstructMonitor::SevenLevelNetShortCounterConstructMonitor(void) {
   Type = _AnonymousSevenLevelNetShortCounterConstructNameSpaceClone::AnonymousSevenLevelNetShortCounterConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void SevenLevelNetShortCounterConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   SevenLevelNetShortCounterConstruct *MonitoredConstruct = dynamic_cast<SevenLevelNetShortCounterConstruct*>(InputConstruct);

}

//--- Operations
void SevenLevelNetShortCounterConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   SevenLevelNetShortCounterConstruct *MonitoredConstruct = dynamic_cast<SevenLevelNetShortCounterConstruct*>(InputConstruct);

}

//--- Operations
void SevenLevelNetShortCounterConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   SevenLevelNetShortCounterConstruct *MonitoredConstruct = dynamic_cast<SevenLevelNetShortCounterConstruct*>(InputConstruct);
   
}