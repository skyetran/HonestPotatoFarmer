#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/BigHedge/Short/Six.mqh"

namespace _AnonymousSixLevelNetShortBigHedgeConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   SixLevelNetShortBigHedgeConstruct AnonymousSixLevelNetShortBigHedgeConstructClone;
}

//--- Constructor
//--- Call To Register Type
SixLevelNetShortBigHedgeConstructMonitor::SixLevelNetShortBigHedgeConstructMonitor(void) {
   Type = _AnonymousSixLevelNetShortBigHedgeConstructNameSpaceClone::AnonymousSixLevelNetShortBigHedgeConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void SixLevelNetShortBigHedgeConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   SixLevelNetShortBigHedgeConstruct *MonitoredConstruct = dynamic_cast<SixLevelNetShortBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void SixLevelNetShortBigHedgeConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   SixLevelNetShortBigHedgeConstruct *MonitoredConstruct = dynamic_cast<SixLevelNetShortBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void SixLevelNetShortBigHedgeConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   SixLevelNetShortBigHedgeConstruct *MonitoredConstruct = dynamic_cast<SixLevelNetShortBigHedgeConstruct*>(InputConstruct);
   
}