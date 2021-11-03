#property strict

#include "../../../../../ConstructManagement/Manager/Monitor/BigHedge/Long/Five.mqh"

namespace _AnonymousFiveLevelNetLongBigHedgeConstructNameSpaceClone {
   // Create The Construct Object To Register The Type At Run Time
   FiveLevelNetLongBigHedgeConstruct AnonymousFiveLevelNetLongBigHedgeConstructClone;
}

//--- Constructor
//--- Call To Register Type
FiveLevelNetLongBigHedgeConstructMonitor::FiveLevelNetLongBigHedgeConstructMonitor(void) {
   Type = _AnonymousFiveLevelNetLongBigHedgeConstructNameSpaceClone::AnonymousFiveLevelNetLongBigHedgeConstructClone.GetConstructType();
   Construct::RegisterMonitor(Type, GetPointer(this));
}

//--- Operations
void FiveLevelNetLongBigHedgeConstructMonitor::UpdateTradePool(Construct *InputConstruct) {
   FiveLevelNetLongBigHedgeConstruct *MonitoredConstruct = dynamic_cast<FiveLevelNetLongBigHedgeConstruct*>(InputConstruct);
   MonitoredConstruct.GetFullConstructTradePool().UpdateRecurrentTradeBoomerangStatus(IP.GetBidPrice(CURRENT_BAR));
   MonitoredConstruct.GetConstructTradePool().AddNewRequest(MonitoredConstruct.GetFullConstructTradePool().GetRequest(IP.GetBidPrice(CURRENT_BAR)));
}

//--- Operations
void FiveLevelNetLongBigHedgeConstructMonitor::UpdateFinance(Construct *InputConstruct) {
   FiveLevelNetLongBigHedgeConstruct *MonitoredConstruct = dynamic_cast<FiveLevelNetLongBigHedgeConstruct*>(InputConstruct);
   
   //MonitoredConstruct.GetConstructRollingInfo().
}

//--- Operations
void FiveLevelNetLongBigHedgeConstructMonitor::UpdateRisk(Construct *InputConstruct) {
   FiveLevelNetLongBigHedgeConstruct *MonitoredConstruct = dynamic_cast<FiveLevelNetLongBigHedgeConstruct*>(InputConstruct);
   ConstructPreCheckInfo *PreCheckInfo = MonitoredConstruct.GetConstructPreCheckInfo();
   
   MonitoredConstruct.GetConstructResultInfo().UpdateMaxRisk(PreCheckInfo.GetMaxLotSizeExposure());
   
   delete PreCheckInfo;
}