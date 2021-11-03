#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/BigHedge/Long/Seven.mqh"

namespace _AnonymousSevenLevelNetLongBigHedgeConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   SevenLevelNetLongBigHedgeConstruct AnonymousSevenLevelNetLongBigHedgeConstructClone;
}

//--- Constructor
//--- Call To Register Type
SevenLevelNetLongBigHedgeConstructMonitor::SevenLevelNetLongBigHedgeConstructMonitor(void) {
   Type = _AnonymousSevenLevelNetLongBigHedgeConstructNameSpaceClone::AnonymousSevenLevelNetLongBigHedgeConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void SevenLevelNetLongBigHedgeConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   SevenLevelNetLongBigHedgeConstruct *MonitoredConstruct = dynamic_cast<SevenLevelNetLongBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void SevenLevelNetLongBigHedgeConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   SevenLevelNetLongBigHedgeConstruct *MonitoredConstruct = dynamic_cast<SevenLevelNetLongBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void SevenLevelNetLongBigHedgeConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   SevenLevelNetLongBigHedgeConstruct *MonitoredConstruct = dynamic_cast<SevenLevelNetLongBigHedgeConstruct*>(InputConstruct);
   
}