#property strict

#include "../MarketState/Ranging.mqh"

//--- Main Constructor
Ranging::Ranging(void) {
   StateName = "Ranging";
}

//--- Behavioral Logics
void Ranging::MonitorStateTransition(void) {
   if (IsRangingToWithTrendBullish()) {
      MW.ResetTrackingVariables();
      MW.ChangeState(new WithTrendBullish());
   }
   if (IsRangingToWithTrendBearish()) {
      MW.ResetTrackingVariables();
      MW.ChangeState(new WithTrendBearish());
   }
}

//--- Helper Functions: State Transition
bool Ranging::IsRangingToWithTrendBullish(void) {
   return IP.GetFastFAMA(CURRENT_BAR) > IP.GetSlowFAMA(CURRENT_BAR) &&
          IP.GetDiffFastFAMA_SlowFAMA_Pts(CURRENT_BAR) > MW.GetOutChannelBuffer();
}

//--- Helper Functions: State Transition
bool Ranging::IsRangingToWithTrendBearish(void) {
   return IP.GetFastFAMA(CURRENT_BAR) < IP.GetSlowFAMA(CURRENT_BAR) &&
          IP.GetDiffFastFAMA_SlowFAMA_Pts(CURRENT_BAR) > MW.GetOutChannelBuffer();
}

//--- Behavioral Logics
void Ranging::MonitorCurrentState(void) {

}

//--- Helper Functions: MonitorCurrentState
void Ranging::MonitorCapstoneLevel(void) {
   
}

//--- Helper Functions: MonitorCurrentState
void Ranging::MonitorMaxFullyDefensiveAccumulationLevel(void) {
   
}

//--- Helper Functions: MonitorCurrentState
void Ranging::MonitorBullishStopLossLevel(void) {
   
}

//--- Helper Functions: MonitorCurrentState
void Ranging::MonitorBearishStopLossLevel(void) {
   
}

double Ranging::GetTopCapstoneLevel(void) {
   return IP.GetLowerSSB(CURRENT_BAR);
}

double Ranging::GetTopApexLevel(void) {
   return MW.GetHighestSellStopLossLevel();
}

double Ranging::GetBotCapstoneLevel(void) {
   return IP.GetUpperSSB(CURRENT_BAR);
}

double Ranging::GetBotApexLevel(void) {
   return MW.GetLowestBuyStopLossLevel();
}