#property strict

#include "../MarketState/CounterTrendBullish.mqh"

//--- Main Constructor
CounterTrendBullish::CounterTrendBullish(void) {
   StateName = "Counter-Trend Bullish";
   BullishStopLossLevel = NOT_APPLICABLE;
   OneTimeExecutionFlag = true;
}

//--- Behavioral Logics
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

//--- Helper Functions: State Transition
bool CounterTrendBullish::IsCounterTrendBullishToWithTrendBullish(void) {
   return IP.GetFastFAMA(CURRENT_BAR) >= GetLastHighestFastFAMA();
}

//--- Helper Functions: State Transition
bool CounterTrendBullish::IsCounterTrendBullishToRanging(void) {
   return IP.GetFastFAMA(CURRENT_BAR) < GetLastHighestFastFAMA()                                                  &&
          PriceToPointCvt(MathAbs(IP.GetFastFAMA(CURRENT_BAR) - GetLastHighestFastFAMA())) > MW.GetWiggleBuffer() &&
          IP.HasTouchedUpperSSB(CURRENT_BAR)                                                                       ;
}

//--- Helper Functions: State Transition
bool CounterTrendBullish::IsCounterTrendBullishToWithTrendBearish(void) {
   return IP.GetFastFAMA(CURRENT_BAR) < IP.GetSlowFAMA(CURRENT_BAR)             &&
          IP.GetDiffFastFAMA_SlowFAMA_Pts(CURRENT_BAR) > MW.GetOutChannelBuffer();
}

//--- Helper Functions: State Transition
double CounterTrendBullish::GetLastHighestFastFAMA(void) {
   static double LastHighestFastFAMA;
   if (OneTimeExecutionFlag) {
      LastHighestFastFAMA = MW.GetHighestFastFAMA() + PointToPriceCvt(MW.GetWiggleBuffer());
      OneTimeExecutionFlag = false;
   }
   return LastHighestFastFAMA;
}

//--- Behavioral Logics
void CounterTrendBullish::MonitorCurrentState(void) {
   if (IsNewEntry()) {
      MonitorCapstoneLevel();
      MonitorMaxFullyDefensiveAccumulationLevel();
      MonitorBullishStopLossLevel();
      MonitorBearishStopLossLevel();
   }
}

//--- Helper Functions: MonitorCurrentState
void CounterTrendBullish::MonitorCapstoneLevel(void) {
   if (IsFirstPosition()) {
      CapstoneLevel = IP.GetFastMAMA(CURRENT_BAR);
   } else {
      CapstoneLevel = IP.GetFastFAMA(CURRENT_BAR);
   }
}

//--- Helper Functions: MonitorCurrentState
void CounterTrendBullish::MonitorMaxFullyDefensiveAccumulationLevel(void) {
   MaxFullyDefensiveAccumulationLevel = GetCapstoneLevel() - GetMaxIntervalSizeInPrice();
}

//--- Helper Functions: GetMaxFullyDefensiveAccumulationLevel
double CounterTrendBullish::GetMaxIntervalSizeInPrice(void) {
   return PointToPriceCvt(GetMaxIntervalSizeInPts());
}

//--- Helper Functions: GetMaxFullyDefensiveAccumulationLevel
int CounterTrendBullish::GetMaxIntervalSizeInPts(void) {
   int FirstMaxIntervalSizeOption  = PriceToPointCvt(GetCapstoneLevel() - IP.GetLowerSSB(CURRENT_BAR));
   int SecondMaxIntervalSizeOption = IP.GetTakeProfitVolatilityInPts(CURRENT_BAR);
   return MathMax(FirstMaxIntervalSizeOption, SecondMaxIntervalSizeOption);
}

//--- Helper Functions: MonitorCurrentState
void CounterTrendBullish::MonitorBullishStopLossLevel(void) {
   //--- Intentionally Left Blank
}

//--- Helper Functions: MonitorCurrentState
void CounterTrendBullish::MonitorBearishStopLossLevel(void) {
   double FirstStopLossLevelOption = IP.GetSellStopLossLevel(CURRENT_BAR);
   double SecondStopLossLevelOption = GetCapstoneLevel() + IP.GetStopLossVolatilityInPrice(CURRENT_BAR);
   BearishStopLossLevel = MathMax(FirstStopLossLevelOption, SecondStopLossLevelOption);
}

//--- Helper Functions
bool CounterTrendBullish::IsNewEntry(void) {
   if (IsFirstPosition()) {
      if (IP.GetFastMAMA(CURRENT_BAR) + PMHP.GetSlippageInPrice() == IP.GetBidPrice(CURRENT_BAR)) {
         IncrementEntryPosition();
         return true;
      }
   }
   if (IP.GetFastFAMA(CURRENT_BAR) + PMHP.GetSlippageInPrice() == IP.GetBidPrice(CURRENT_BAR)) {
      IncrementEntryPosition();
      return true;
   }
   return false;
}