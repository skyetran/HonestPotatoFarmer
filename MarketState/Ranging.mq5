#property strict

#include "../MarketState/Ranging.mqh"

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

bool Ranging::IsRangingToWithTrendBullish(void) {
   return IP.GetFastFAMA(CURRENT_BAR) > IP.GetSlowFAMA(CURRENT_BAR) &&
          IP.GetDiffFastFAMA_SlowFAMA_Pts(CURRENT_BAR) > MW.GetOutChannelBuffer();
}

bool Ranging::IsRangingToWithTrendBearish(void) {
   return IP.GetFastFAMA(CURRENT_BAR) < IP.GetSlowFAMA(CURRENT_BAR) &&
          IP.GetDiffFastFAMA_SlowFAMA_Pts(CURRENT_BAR) > MW.GetOutChannelBuffer();
}

string Ranging::GetStateName(void) {
   return "Ranging";
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