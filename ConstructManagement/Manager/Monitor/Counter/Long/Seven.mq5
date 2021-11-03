#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/Counter/Long/Seven.mqh"

namespace _AnonymousSevenLevelNetLongCounterConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   SevenLevelNetLongCounterConstruct AnonymousSevenLevelNetLongCounterConstructClone;
}

//--- Constructor
//--- Call To Register Type
SevenLevelNetLongCounterConstructMonitor::SevenLevelNetLongCounterConstructMonitor(void) {
   Type = _AnonymousSevenLevelNetLongCounterConstructNameSpaceClone::AnonymousSevenLevelNetLongCounterConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void SevenLevelNetLongCounterConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   SevenLevelNetLongCounterConstruct *MonitoredConstruct = dynamic_cast<SevenLevelNetLongCounterConstruct*>(InputConstruct);

}

//--- Operations
void SevenLevelNetLongCounterConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   SevenLevelNetLongCounterConstruct *MonitoredConstruct = dynamic_cast<SevenLevelNetLongCounterConstruct*>(InputConstruct);

}

//--- Operations
void SevenLevelNetLongCounterConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   SevenLevelNetLongCounterConstruct *MonitoredConstruct = dynamic_cast<SevenLevelNetLongCounterConstruct*>(InputConstruct);
   
}