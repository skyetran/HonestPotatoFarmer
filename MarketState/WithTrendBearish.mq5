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

int WithTrendBearish::GetMaxIntervalSize(void) {
   int FirstMaxIntervalSizeOption  = PriceToPointCvt(GetCapstoneLevel() - IP.GetLowerSSB(CURRENT_BAR));
   int SecondMaxIntervalSizeOption = IP.GetTakeProfitVolatilityInPts(CURRENT_BAR);
   return MathMax(FirstMaxIntervalSizeOption, SecondMaxIntervalSizeOption);
}

int WithTrendBearish::GetStopLossSize(void) {
   return PriceToPointCvt(GetStopLossLevel() - GetCapstoneLevel());
}

double WithTrendBearish::GetStopLossLevel(void) {
   double FirstStopLossLevelOption = IP.GetSellStopLossLevel(CURRENT_BAR);
   double SecondStopLossLevelOption = GetCapstoneLevel() + IP.GetStopLossVolatilityInPrice(CURRENT_BAR);
   return MathMax(FirstStopLossLevelOption, SecondStopLossLevelOption);
}

double WithTrendBearish::GetCapstoneLevel(void) {
   if (IsFirstPosition()) {
      return IP.GetFastMAMA(CURRENT_BAR);
   }
   return IP.GetFastFAMA(CURRENT_BAR);
}