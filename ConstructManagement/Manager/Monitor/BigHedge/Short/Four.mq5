#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/BigHedge/Short/Four.mqh"

namespace _AnonymousFourLevelNetShortBigHedgeConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   FourLevelNetShortBigHedgeConstruct AnonymousFourLevelNetShortBigHedgeConstructClone;
}

//--- Constructor
//--- Call To Register Type
FourLevelNetShortBigHedgeConstructMonitor::FourLevelNetShortBigHedgeConstructMonitor(void) {
   Type = _AnonymousFourLevelNetShortBigHedgeConstructNameSpaceClone::AnonymousFourLevelNetShortBigHedgeConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void FourLevelNetShortBigHedgeConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   FourLevelNetShortBigHedgeConstruct *MonitoredConstruct = dynamic_cast<FourLevelNetShortBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void FourLevelNetShortBigHedgeConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   FourLevelNetShortBigHedgeConstruct *MonitoredConstruct = dynamic_cast<FourLevelNetShortBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void FourLevelNetShortBigHedgeConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   FourLevelNetShortBigHedgeConstruct *MonitoredConstruct = dynamic_cast<FourLevelNetShortBigHedgeConstruct*>(InputConstruct);
   
}