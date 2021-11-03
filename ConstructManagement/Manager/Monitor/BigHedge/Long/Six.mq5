#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/BigHedge/Long/Six.mqh"

namespace _AnonymousSixLevelNetLongBigHedgeConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   SixLevelNetLongBigHedgeConstruct AnonymousSixLevelNetLongBigHedgeConstructClone;
}

//--- Constructor
//--- Call To Register Type
SixLevelNetLongBigHedgeConstructMonitor::SixLevelNetLongBigHedgeConstructMonitor(void) {
   Type = _AnonymousSixLevelNetLongBigHedgeConstructNameSpaceClone::AnonymousSixLevelNetLongBigHedgeConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void SixLevelNetLongBigHedgeConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   SixLevelNetLongBigHedgeConstruct *MonitoredConstruct = dynamic_cast<SixLevelNetLongBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void SixLevelNetLongBigHedgeConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   SixLevelNetLongBigHedgeConstruct *MonitoredConstruct = dynamic_cast<SixLevelNetLongBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void SixLevelNetLongBigHedgeConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   SixLevelNetLongBigHedgeConstruct *MonitoredConstruct = dynamic_cast<SixLevelNetLongBigHedgeConstruct*>(InputConstruct);
   
}