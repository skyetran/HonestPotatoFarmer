#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/BigHedge/Short/Two.mqh"

namespace _AnonymousTwoLevelNetShortBigHedgeConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   TwoLevelNetShortBigHedgeConstruct AnonymousTwoLevelNetShortBigHedgeConstructClone;
}

//--- Constructor
//--- Call To Register Type
TwoLevelNetShortBigHedgeConstructMonitor::TwoLevelNetShortBigHedgeConstructMonitor(void) {
   Type = _AnonymousTwoLevelNetShortBigHedgeConstructNameSpaceClone::AnonymousTwoLevelNetShortBigHedgeConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void TwoLevelNetShortBigHedgeConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   TwoLevelNetShortBigHedgeConstruct *MonitoredConstruct = dynamic_cast<TwoLevelNetShortBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void TwoLevelNetShortBigHedgeConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   TwoLevelNetShortBigHedgeConstruct *MonitoredConstruct = dynamic_cast<TwoLevelNetShortBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void TwoLevelNetShortBigHedgeConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   TwoLevelNetShortBigHedgeConstruct *MonitoredConstruct = dynamic_cast<TwoLevelNetShortBigHedgeConstruct*>(InputConstruct);
   
}