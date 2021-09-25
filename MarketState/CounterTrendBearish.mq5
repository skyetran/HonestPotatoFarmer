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
          PriceToPointCvt(MathAbs(IP.GetFastFAMA(CURRENT_BAR) - GetLastLowestFastFAMA())) > MW.GetWiggleBuffer() &&
          IP.HasTouchedLowerSSB(CURRENT_BAR)                                                                                      ;
}

bool CounterTrendBearish::IsCounterTrendBearishToWithTrendBullish(void) {
   return IP.GetFastFAMA(CURRENT_BAR) > IP.GetSlowFAMA(CURRENT_BAR)             &&
          IP.GetDiffFastFAMA_SlowFAMA_Pts(CURRENT_BAR) > MW.GetOutChannelBuffer();
}

double CounterTrendBearish::GetLastLowestFastFAMA(void) {
   static double LastLowestFastFAMA;
   if (OneTimeExecutionFlag) {
      LastLowestFastFAMA = MW.GetLowestFastFAMA() - PointToPriceCvt(MW.GetWiggleBuffer());
      OneTimeExecutionFlag = false;
   }
   return LastLowestFastFAMA;
}

string CounterTrendBearish::GetStateName(void) {
   return "Counter-Trend Bearish";
}

int CounterTrendBearish::GetMaxIntervalSize(void) {
   int FirstMaxIntervalSizeOption  = PriceToPointCvt(IP.GetUpperSSB(CURRENT_BAR) - GetCapstoneLevel());
   int SecondMaxIntervalSizeOption = IP.GetTakeProfitVolatilityInPts(CURRENT_BAR);
   return MathMax(FirstMaxIntervalSizeOption, SecondMaxIntervalSizeOption);
}

int CounterTrendBearish::GetStopLossSize(void) {
   return PriceToPointCvt(GetCapstoneLevel() - GetStopLossLevel());
}

double CounterTrendBearish::GetStopLossLevel(void) {
   double FirstStopLossLevelOption = IP.GetBuyStopLossLevel(CURRENT_BAR);
   double SecondStopLossLevelOption = GetCapstoneLevel() - IP.GetStopLossVolatilityInPrice(CURRENT_BAR);
   return MathMin(FirstStopLossLevelOption, SecondStopLossLevelOption);
}

double CounterTrendBearish::GetCapstoneLevel(void) {
   if (IsFirstPosition()) {
      return IP.GetFastMAMA(CURRENT_BAR);
   }
   return IP.GetFastFAMA(CURRENT_BAR);
}