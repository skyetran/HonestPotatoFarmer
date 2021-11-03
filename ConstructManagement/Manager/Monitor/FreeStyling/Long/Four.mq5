#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/FreeStyling/Long/Four.mqh"

namespace _AnonymousFourLevelNetLongFreeStylingConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   FourLevelNetLongFreeStylingConstruct AnonymousFourLevelNetLongFreeStylingConstructClone;
}

//--- Constructor
//--- Call To Register Type
FourLevelNetLongFreeStylingConstructMonitor::FourLevelNetLongFreeStylingConstructMonitor(void) {
   Type = _AnonymousFourLevelNetLongFreeStylingConstructNameSpaceClone::AnonymousFourLevelNetLongFreeStylingConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void FourLevelNetLongFreeStylingConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   FourLevelNetLongFreeStylingConstruct *MonitoredConstruct = dynamic_cast<FourLevelNetLongFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void FourLevelNetLongFreeStylingConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   FourLevelNetLongFreeStylingConstruct *MonitoredConstruct = dynamic_cast<FourLevelNetLongFreeStylingConstruct*>(InputConstruct);

}

//--- Operations
void FourLevelNetLongFreeStylingConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   FourLevelNetLongFreeStylingConstruct *MonitoredConstruct = dynamic_cast<FourLevelNetLongFreeStylingConstruct*>(InputConstruct);
   
}