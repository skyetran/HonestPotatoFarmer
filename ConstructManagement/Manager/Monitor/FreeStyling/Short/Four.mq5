#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/FreeStyling/Short/Four.mqh"

namespace _AnonymousFourLevelNetShortFreeStylingConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   FourLevelNetShortFreeStylingConstruct AnonymousFourLevelNetShortFreeStylingConstructClone;
}

//--- Constructor
//--- Call To Register Type
FourLevelNetShortFreeStylingConstructMonitor::FourLevelNetShortFreeStylingConstructMonitor(void) {
   Type = _AnonymousFourLevelNetShortFreeStylingConstructNameSpaceClone::AnonymousFourLevelNetShortFreeStylingConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void FourLevelNetShortFreeStylingConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   FourLevelNetShortFreeStylingConstruct *MonitoredConstruct = dynamic_cast<FourLevelNetShortFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void FourLevelNetShortFreeStylingConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   FourLevelNetShortFreeStylingConstruct *MonitoredConstruct = dynamic_cast<FourLevelNetShortFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void FourLevelNetShortFreeStylingConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   FourLevelNetShortFreeStylingConstruct *MonitoredConstruct = dynamic_cast<FourLevelNetShortFreeStylingConstruct*>(InputConstruct);
   
}