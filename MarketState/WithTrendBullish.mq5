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

int WithTrendBullish::GetMaxIntervalSize(void) {
   int FirstMaxIntervalSizeOption  = PriceToPointCvt(IP.GetUpperSSB(CURRENT_BAR) - GetCapstoneLevel());
   int SecondMaxIntervalSizeOption = IP.GetTakeProfitVolatilityInPts(CURRENT_BAR);
   return MathMax(FirstMaxIntervalSizeOption, SecondMaxIntervalSizeOption);
}

int WithTrendBullish::GetStopLossSize(void) {
   return PriceToPointCvt(GetCapstoneLevel() - GetStopLossLevel());
}

double WithTrendBullish::GetStopLossLevel(void) {
   double FirstStopLossLevelOption = IP.GetBuyStopLossLevel(CURRENT_BAR);
   double SecondStopLossLevelOption = GetCapstoneLevel() - IP.GetStopLossVolatilityInPrice(CURRENT_BAR);
   return MathMin(FirstStopLossLevelOption, SecondStopLossLevelOption);
}

double WithTrendBullish::GetCapstoneLevel(void) {
   if (IsFirstPosition()) {
      return IP.GetFastMAMA(CURRENT_BAR);
   }
   return IP.GetFastFAMA(CURRENT_BAR);
}