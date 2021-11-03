#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/FreeStyling/Short/Seven.mqh"

namespace _AnonymousSevenLevelNetShortFreeStylingConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   SevenLevelNetShortFreeStylingConstruct AnonymousSevenLevelNetShortFreeStylingConstructClone;
}

//--- Constructor
//--- Call To Register Type
SevenLevelNetShortFreeStylingConstructMonitor::SevenLevelNetShortFreeStylingConstructMonitor(void) {
   Type = _AnonymousSevenLevelNetShortFreeStylingConstructNameSpaceClone::AnonymousSevenLevelNetShortFreeStylingConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void SevenLevelNetShortFreeStylingConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   SevenLevelNetShortFreeStylingConstruct *MonitoredConstruct = dynamic_cast<SevenLevelNetShortFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void SevenLevelNetShortFreeStylingConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   SevenLevelNetShortFreeStylingConstruct *MonitoredConstruct = dynamic_cast<SevenLevelNetShortFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void SevenLevelNetShortFreeStylingConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   SevenLevelNetShortFreeStylingConstruct *MonitoredConstruct = dynamic_cast<SevenLevelNetShortFreeStylingConstruct*>(InputConstruct);
   
}