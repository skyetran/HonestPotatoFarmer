#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/BigHedge/Short/Seven.mqh"

namespace _AnonymousSevenLevelNetShortBigHedgeConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   SevenLevelNetShortBigHedgeConstruct AnonymousSevenLevelNetShortBigHedgeConstructClone;
}

//--- Constructor
//--- Call To Register Type
SevenLevelNetShortBigHedgeConstructMonitor::SevenLevelNetShortBigHedgeConstructMonitor(void) {
   Type = _AnonymousSevenLevelNetShortBigHedgeConstructNameSpaceClone::AnonymousSevenLevelNetShortBigHedgeConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void SevenLevelNetShortBigHedgeConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   SevenLevelNetShortBigHedgeConstruct *MonitoredConstruct = dynamic_cast<SevenLevelNetShortBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void SevenLevelNetShortBigHedgeConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   SevenLevelNetShortBigHedgeConstruct *MonitoredConstruct = dynamic_cast<SevenLevelNetShortBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void SevenLevelNetShortBigHedgeConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   SevenLevelNetShortBigHedgeConstruct *MonitoredConstruct = dynamic_cast<SevenLevelNetShortBigHedgeConstruct*>(InputConstruct);
   
}