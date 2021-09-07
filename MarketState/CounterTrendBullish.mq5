#property strict

#include "../MarketState/CounterTrendBullish.mqh"

CounterTrendBullish::CounterTrendBullish(void) {
   MarketState();
   OneTimeExecutionFlag = true;
}

void CounterTrendBullish::MonitorStateTransition(void) {
   if (IsCounterTrendBullishToWithTrendBullish()) {
      MW.ResetTrackingVariables();
      MW.ChangeState(new WithTrendBullish());
   }
   if (IsCounterTrendBullishToRanging()) {
      MW.ResetTrackingVariables();
      MW.ChangeState(new Ranging());
   }
   if (IsCounterTrendBullishToWithTrendBearish()) {
      MW.ResetTrackingVariables();
      MW.ChangeState(new WithTrendBearish());
   }
}

bool CounterTrendBullish::IsCounterTrendBullishToWithTrendBullish(void) {
   return IP.GetFastFAMA(CURRENT_BAR) >= GetLastHighestFastFAMA();
}

bool CounterTrendBullish::IsCounterTrendBullishToRanging(void) {
   return IP.GetFastFAMA(CURRENT_BAR) < GetLastHighestFastFAMA()                                                                  &&
          PriceToPointCvt(IP.GetSymbol(), MathAbs(IP.GetFastFAMA(CURRENT_BAR) - GetLastHighestFastFAMA())) > MW.GetWiggleBuffer() &&
          IP.HasTouchedUpperSSB(CURRENT_BAR)                                                                                       ;
}

bool CounterTrendBullish::IsCounterTrendBullishToWithTrendBearish(void) {
   return IP.GetFastFAMA(CURRENT_BAR) < IP.GetSlowFAMA(CURRENT_BAR)             &&
          IP.GetDiffFastFAMA_SlowFAMA_Pts(CURRENT_BAR) > MW.GetOutChannelBuffer();
}

double CounterTrendBullish::GetLastHighestFastFAMA(void) {
   static double LastHighestFastFAMA;
   if (OneTimeExecutionFlag) {
      LastHighestFastFAMA = MW.GetHighestFastFAMA() + PointToPriceCvt(IP.GetSymbol(), MW.GetWiggleBuffer());
      OneTimeExecutionFlag = false;
   }
   return LastHighestFastFAMA;
}

string CounterTrendBullish::GetStateName(void) {
   return "Counter-Trend Bullish";
}

double CounterTrendBullish::GetCapstoneLevel(void) {
   if (IsFirstPosition()) {
      return IP.GetFastMAMA(CURRENT_BAR);
   }
   return IP.GetFastFAMA(CURRENT_BAR);
}

double CounterTrendBullish::GetApexLevel(void) {
   return IP.GetLowerSSB(CURRENT_BAR);
}

double CounterTrendBullish::GetStopLossLevel(void) {
   return IP.GetSellStopLossLevel(CURRENT_BAR);
}