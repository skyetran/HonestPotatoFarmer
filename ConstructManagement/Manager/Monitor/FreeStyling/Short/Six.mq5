#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/FreeStyling/Short/Six.mqh"

namespace _AnonymousSixLevelNetShortFreeStylingConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   SixLevelNetShortFreeStylingConstruct AnonymousSixLevelNetShortFreeStylingConstructClone;
}

//--- Constructor
//--- Call To Register Type
SixLevelNetShortFreeStylingConstructMonitor::SixLevelNetShortFreeStylingConstructMonitor(void) {
   Type = _AnonymousSixLevelNetShortFreeStylingConstructNameSpaceClone::AnonymousSixLevelNetShortFreeStylingConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void SixLevelNetShortFreeStylingConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   SixLevelNetShortFreeStylingConstruct *MonitoredConstruct = dynamic_cast<SixLevelNetShortFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void SixLevelNetShortFreeStylingConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   SixLevelNetShortFreeStylingConstruct *MonitoredConstruct = dynamic_cast<SixLevelNetShortFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void SixLevelNetShortFreeStylingConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   SixLevelNetShortFreeStylingConstruct *MonitoredConstruct = dynamic_cast<SixLevelNetShortFreeStylingConstruct*>(InputConstruct);
   
}