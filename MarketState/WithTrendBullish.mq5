#property strict

#include "../MarketState/WithTrendBullish.mqh"

void WithTrendBullish::MonitorStateTransition(void) {
   if (IsWithTrendBullishToRanging()) {
      MW.ResetTrackingVariables();
      MW.ChangeState(new Ranging());
   }
   if (IsWithTrendBullishToCounterTrendBullish()) {
      MW.ResetTrackingVariables();
      MW.ChangeState(new CounterTrendBullish());
   }
}

bool WithTrendBullish::IsWithTrendBullishToRanging(void) {
   return MW.GetCurrentDiffFastFAMA_HighestFastFAMA_Pts() <= MW.GetWiggleBuffer() &&
          IP.GetDiffFastFAMA_SlowFAMA_Pts(CURRENT_BAR) <= MW.GetInChannelBuffer()  ;
}

bool WithTrendBullish::IsWithTrendBullishToCounterTrendBullish(void) {
   return MW.GetCurrentDiffFastFAMA_HighestFastFAMA_Pts() > MW.GetWiggleBuffer() &&
          IP.GetFastFAMA(CURRENT_BAR) < MW.GetHighestFastFAMA()                   ;
}

string WithTrendBullish::GetStateName(void) {
   return "With-Trend Bullish";
}

double WithTrendBullish::GetCapstoneLevel(void) {
   if (IsFirstPosition()) {
      return IP.GetFastMAMA(CURRENT_BAR);
   }
   return IP.GetFastFAMA(CURRENT_BAR);
}

double WithTrendBullish::GetApexLevel(void) {
   if (IsFirstPosition()) {
      return IP.GetSellStopLossLevel(CURRENT_BAR);
   }
   return IP.GetUpperSSB(CURRENT_BAR);
}

double WithTrendBullish::GetStopLossLevel(void) {
   return IP.GetBuyStopLossLevel(CURRENT_BAR);
}