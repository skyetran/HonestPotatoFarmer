#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/BigHedge/Long/Four.mqh"

namespace _AnonymousFourLevelNetLongBigHedgeConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   FourLevelNetLongBigHedgeConstruct AnonymousFourLevelNetLongBigHedgeConstructClone;
}

//--- Constructor
//--- Call To Register Type
FourLevelNetLongBigHedgeConstructMonitor::FourLevelNetLongBigHedgeConstructMonitor(void) {
   Type = _AnonymousFourLevelNetLongBigHedgeConstructNameSpaceClone::AnonymousFourLevelNetLongBigHedgeConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void FourLevelNetLongBigHedgeConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   FourLevelNetLongBigHedgeConstruct *MonitoredConstruct = dynamic_cast<FourLevelNetLongBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void FourLevelNetLongBigHedgeConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   FourLevelNetLongBigHedgeConstruct *MonitoredConstruct = dynamic_cast<FourLevelNetLongBigHedgeConstruct*>(InputConstruct);

}

//--- Operations
void FourLevelNetLongBigHedgeConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   FourLevelNetLongBigHedgeConstruct *MonitoredConstruct = dynamic_cast<FourLevelNetLongBigHedgeConstruct*>(InputConstruct);
   
}