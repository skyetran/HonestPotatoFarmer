#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/BigHedge/Long/Three.mqh"

namespace _AnonymousThreeLevelNetLongBigHedgeConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   ThreeLevelNetLongBigHedgeConstruct AnonymousThreeLevelNetLongBigHedgeConstructClone;
}

//--- Constructor
//--- Call To Register Type
ThreeLevelNetLongBigHedgeConstructMonitor::ThreeLevelNetLongBigHedgeConstructMonitor(void) {
   Type = _AnonymousThreeLevelNetLongBigHedgeConstructNameSpaceClone::AnonymousThreeLevelNetLongBigHedgeConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void ThreeLevelNetLongBigHedgeConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   ThreeLevelNetLongBigHedgeConstruct *MonitoredConstruct = dynamic_cast<ThreeLevelNetLongBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void ThreeLevelNetLongBigHedgeConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   ThreeLevelNetLongBigHedgeConstruct *MonitoredConstruct = dynamic_cast<ThreeLevelNetLongBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void ThreeLevelNetLongBigHedgeConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   ThreeLevelNetLongBigHedgeConstruct *MonitoredConstruct = dynamic_cast<ThreeLevelNetLongBigHedgeConstruct*>(InputConstruct);
   
}