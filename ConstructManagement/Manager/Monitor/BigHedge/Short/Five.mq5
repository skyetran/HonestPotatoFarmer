#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/BigHedge/Short/Five.mqh"

namespace _AnonymousFiveLevelNetShortBigHedgeConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   FiveLevelNetShortBigHedgeConstruct AnonymousFiveLevelNetShortBigHedgeConstructClone;
}

//--- Constructor
//--- Call To Register Type
FiveLevelNetShortBigHedgeConstructMonitor::FiveLevelNetShortBigHedgeConstructMonitor(void) {
   Type = _AnonymousFiveLevelNetShortBigHedgeConstructNameSpaceClone::AnonymousFiveLevelNetShortBigHedgeConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void FiveLevelNetShortBigHedgeConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   FiveLevelNetShortBigHedgeConstruct *MonitoredConstruct = dynamic_cast<FiveLevelNetShortBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void FiveLevelNetShortBigHedgeConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   FiveLevelNetShortBigHedgeConstruct *MonitoredConstruct = dynamic_cast<FiveLevelNetShortBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void FiveLevelNetShortBigHedgeConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   FiveLevelNetShortBigHedgeConstruct *MonitoredConstruct = dynamic_cast<FiveLevelNetShortBigHedgeConstruct*>(InputConstruct);
   
}