#property strict

#include "../MarketState/CounterTrendBearish.mqh"

CounterTrendBearish::CounterTrendBearish(void) {
   MarketState();
   OneTimeExecutionFlag = true;
}

void CounterTrendBearish::MonitorStateTransition(void) {
   if (IsCounterTrendBearishToWithTrendBearish()) {
      MW.ResetTrackingVariables();
      MW.ChangeState(new WithTrendBearish());
   }
   if (IsCounterTrendBearishToRanging()) {
      MW.ResetTrackingVariables();
      MW.ChangeState(new Ranging());
   }
   if (IsCounterTrendBearishToWithTrendBullish()) {
      MW.ResetTrackingVariables();
      MW.ChangeState(new WithTrendBullish());
   }
}

bool CounterTrendBearish::IsCounterTrendBearishToWithTrendBearish(void) {
   return IP.GetFastFAMA(CURRENT_BAR) <= GetLastLowestFastFAMA();
}

bool CounterTrendBearish::IsCounterTrendBearishToRanging(void) {
   return IP.GetFastFAMA(CURRENT_BAR) > GetLastLowestFastFAMA()                                                                  &&
          PriceToPointCvt(IP.GetSymbol(), MathAbs(IP.GetFastFAMA(CURRENT_BAR) - GetLastLowestFastFAMA())) > MW.GetWiggleBuffer() &&
          IP.HasTouchedLowerSSB(CURRENT_BAR)                                                                                      ;
}

bool CounterTrendBearish::IsCounterTrendBearishToWithTrendBullish(void) {
   return IP.GetFastFAMA(CURRENT_BAR) > IP.GetSlowFAMA(CURRENT_BAR)             &&
          IP.GetDiffFastFAMA_SlowFAMA_Pts(CURRENT_BAR) > MW.GetOutChannelBuffer();
}

double CounterTrendBearish::GetLastLowestFastFAMA(void) {
   static double LastLowestFastFAMA;
   if (OneTimeExecutionFlag) {
      LastLowestFastFAMA = MW.GetLowestFastFAMA() - PointToPriceCvt(IP.GetSymbol(), MW.GetWiggleBuffer());
      OneTimeExecutionFlag = false;
   }
   return LastLowestFastFAMA;
}

string CounterTrendBearish::GetStateName(void) {
   return "Counter-Trend Bearish";
}

double CounterTrendBearish::GetCapstoneLevel(void) {
   if (IsFirstPosition()) {
      return IP.GetFastMAMA(CURRENT_BAR);
   }
   return IP.GetFastFAMA(CURRENT_BAR);
}

double CounterTrendBearish::GetApexLevel(void) {
   return IP.GetUpperSSB(CURRENT_BAR);
}

double CounterTrendBearish::GetStopLossLevel(void) {
   return IP.GetBuyStopLossLevel(CURRENT_BAR);
}