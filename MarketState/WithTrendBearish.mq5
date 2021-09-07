#property strict

#include "../MarketState/WithTrendBearish.mqh"

void WithTrendBearish::MonitorStateTransition(void) {
   if (IsWithTrendBearishToRanging()) {
      MW.ResetTrackingVariables();
      MW.ChangeState(new Ranging());
   }
   if (IsWithTrendBearishToCounterTrendBearish()) {
      MW.ResetTrackingVariables();
      MW.ChangeState(new CounterTrendBearish());
   }
}

bool WithTrendBearish::IsWithTrendBearishToRanging(void) {
   return MW.GetCurrentDiffFastFAMA_LowestFastFAMA_Pts() <= MW.GetWiggleBuffer() &&
          IP.GetDiffFastFAMA_SlowFAMA_Pts(CURRENT_BAR) <= MW.GetInChannelBuffer() ;
}

bool WithTrendBearish::IsWithTrendBearishToCounterTrendBearish(void) {
   return MW.GetCurrentDiffFastFAMA_LowestFastFAMA_Pts() > MW.GetWiggleBuffer() &&
          IP.GetFastFAMA(CURRENT_BAR) > MW.GetLowestFastFAMA()                   ;
}

string WithTrendBearish::GetStateName(void) {
   return "With-Trend Bearish";
}

double WithTrendBearish::GetCapstoneLevel(void) {
   if (IsFirstPosition()) {
      return IP.GetFastMAMA(CURRENT_BAR);
   }
   return IP.GetFastFAMA(CURRENT_BAR);
}

double WithTrendBearish::GetApexLevel(void) {
   if (IsFirstPosition()) {
      return IP.GetBuyStopLossLevel(CURRENT_BAR);
   }
   return IP.GetLowerSSB(CURRENT_BAR);
}

double WithTrendBearish::GetStopLossLevel(void) {
   return IP.GetSellStopLossLevel(CURRENT_BAR);
}