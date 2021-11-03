#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/FreeStyling/Long/Seven.mqh"

namespace _AnonymousSevenLevelNetLongFreeStylingConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   SevenLevelNetLongFreeStylingConstruct AnonymousSevenLevelNetLongFreeStylingConstructClone;
}

//--- Constructor
//--- Call To Register Type
SevenLevelNetLongFreeStylingConstructMonitor::SevenLevelNetLongFreeStylingConstructMonitor(void) {
   Type = _AnonymousSevenLevelNetLongFreeStylingConstructNameSpaceClone::AnonymousSevenLevelNetLongFreeStylingConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void SevenLevelNetLongFreeStylingConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   SevenLevelNetLongFreeStylingConstruct *MonitoredConstruct = dynamic_cast<SevenLevelNetLongFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void SevenLevelNetLongFreeStylingConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   SevenLevelNetLongFreeStylingConstruct *MonitoredConstruct = dynamic_cast<SevenLevelNetLongFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void SevenLevelNetLongFreeStylingConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   SevenLevelNetLongFreeStylingConstruct *MonitoredConstruct = dynamic_cast<SevenLevelNetLongFreeStylingConstruct*>(InputConstruct);
   
}