#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/BigHedge/Short/Three.mqh"

namespace _AnonymousThreeLevelNetShortBigHedgeConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   ThreeLevelNetShortBigHedgeConstruct AnonymousThreeLevelNetShortBigHedgeConstructClone;
}

//--- Constructor
//--- Call To Register Type
ThreeLevelNetShortBigHedgeConstructMonitor::ThreeLevelNetShortBigHedgeConstructMonitor(void) {
   Type = _AnonymousThreeLevelNetShortBigHedgeConstructNameSpaceClone::AnonymousThreeLevelNetShortBigHedgeConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void ThreeLevelNetShortBigHedgeConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   ThreeLevelNetShortBigHedgeConstruct *MonitoredConstruct = dynamic_cast<ThreeLevelNetShortBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void ThreeLevelNetShortBigHedgeConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   ThreeLevelNetShortBigHedgeConstruct *MonitoredConstruct = dynamic_cast<ThreeLevelNetShortBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void ThreeLevelNetShortBigHedgeConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   ThreeLevelNetShortBigHedgeConstruct *MonitoredConstruct = dynamic_cast<ThreeLevelNetShortBigHedgeConstruct*>(InputConstruct);
   
}