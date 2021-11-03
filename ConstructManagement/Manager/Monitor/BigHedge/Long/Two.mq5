#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/BigHedge/Long/Two.mqh"

namespace _AnonymousTwoLevelNetLongBigHedgeConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   TwoLevelNetLongBigHedgeConstruct AnonymousTwoLevelNetLongBigHedgeConstructClone;
}

//--- Constructor
//--- Call To Register Type
TwoLevelNetLongBigHedgeConstructMonitor::TwoLevelNetLongBigHedgeConstructMonitor(void) {
   Type = _AnonymousTwoLevelNetLongBigHedgeConstructNameSpaceClone::AnonymousTwoLevelNetLongBigHedgeConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void TwoLevelNetLongBigHedgeConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   TwoLevelNetLongBigHedgeConstruct *MonitoredConstruct = dynamic_cast<TwoLevelNetLongBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void TwoLevelNetLongBigHedgeConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   TwoLevelNetLongBigHedgeConstruct *MonitoredConstruct = dynamic_cast<TwoLevelNetLongBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void TwoLevelNetLongBigHedgeConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   TwoLevelNetLongBigHedgeConstruct *MonitoredConstruct = dynamic_cast<TwoLevelNetLongBigHedgeConstruct*>(InputConstruct);
   
}