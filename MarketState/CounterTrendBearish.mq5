#property strict

#include "../MarketState/CounterTrendBearish.mqh"

//--- Main Constructor
CounterTrendBearish::CounterTrendBearish(void) {
   StateName = "Counter-Trend Bearish";
   BoomerangStatus = BOOMERANG_ALLOWED;
   BearishStopLossLevel = NOT_APPLICABLE;
   OneTimeExecutionFlag = true;
}

//--- Behavioral Logics
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

//--- Helper Functions: State Transition
bool CounterTrendBearish::IsCounterTrendBearishToWithTrendBearish(void) {
   return IP.GetFastFAMA(CURRENT_BAR) <= GetLastLowestFastFAMA();
}

//--- Helper Functions: State Transition
bool CounterTrendBearish::IsCounterTrendBearishToRanging(void) {
   return IP.GetFastFAMA(CURRENT_BAR) > GetLastLowestFastFAMA()                                                  &&
          PriceToPointCvt(MathAbs(IP.GetFastFAMA(CURRENT_BAR) - GetLastLowestFastFAMA())) > MW.GetWiggleBuffer() &&
          IP.HasTouchedLowerSSB(CURRENT_BAR)                                                                      ;
}

//--- Helper Functions: State Transition
bool CounterTrendBearish::IsCounterTrendBearishToWithTrendBullish(void) {
   return IP.GetFastFAMA(CURRENT_BAR) > IP.GetSlowFAMA(CURRENT_BAR)             &&
          IP.GetDiffFastFAMA_SlowFAMA_Pts(CURRENT_BAR) > MW.GetOutChannelBuffer();
}

//--- Helper Functions: State Transition
double CounterTrendBearish::GetLastLowestFastFAMA(void) {
   static double LastLowestFastFAMA;
   if (OneTimeExecutionFlag) {
      LastLowestFastFAMA = MW.GetLowestFastFAMA() - PointToPriceCvt(MW.GetWiggleBuffer());
      OneTimeExecutionFlag = false;
   }
   return LastLowestFastFAMA;
}

//--- Behavioral Logics
void CounterTrendBearish::MonitorCurrentState(void) {
   if (IsNewEntry()) {
      MonitorCapstoneLevel();
      MonitorMaxFullyDefensiveAccumulationLevel();
      MonitorBullishStopLossLevel();
      MonitorBearishStopLossLevel();
   }
}

//--- Helper Functions: MonitorCurrentState
void CounterTrendBearish::MonitorCapstoneLevel(void) {
   if (IsFirstPosition()) {
      CapstoneLevel = IP.GetFastMAMA(CURRENT_BAR);
   } else {
      CapstoneLevel = IP.GetFastFAMA(CURRENT_BAR);
   }
}

//--- Helper Functions: MonitorCurrentState
void CounterTrendBearish::MonitorMaxFullyDefensiveAccumulationLevel(void) {
   MaxFullyDefensiveAccumulationLevel = GetCapstoneLevel() + GetMaxIntervalSizeInPrice();
}

//--- Helper Functions: GetMaxFullyDefensiveAccumulationLevel
double CounterTrendBearish::GetMaxIntervalSizeInPrice(void) {
   return PointToPriceCvt(GetMaxIntervalSizeInPts());
}

//--- Helper Functions: GetMaxFullyDefensiveAccumulationLevel
int CounterTrendBearish::GetMaxIntervalSizeInPts(void) {
   int FirstMaxIntervalSizeOption  = PriceToPointCvt(IP.GetUpperSSB(CURRENT_BAR) - GetCapstoneLevel());
   int SecondMaxIntervalSizeOption = IP.GetTakeProfitVolatilityInPts(CURRENT_BAR);
   return MathMax(FirstMaxIntervalSizeOption, SecondMaxIntervalSizeOption);
}

//--- Helper Functions: MonitorCurrentState
void CounterTrendBearish::MonitorBullishStopLossLevel(void) {
   double FirstStopLossLevelOption = IP.GetBuyStopLossLevel(CURRENT_BAR);
   double SecondStopLossLevelOption = GetCapstoneLevel() - IP.GetStopLossVolatilityInPrice(CURRENT_BAR);
   BullishStopLossLevel = MathMin(FirstStopLossLevelOption, SecondStopLossLevelOption);
}

//--- Helper Functions: MonitorCurrentState
void CounterTrendBearish::MonitorBearishStopLossLevel(void) {
   //--- Intentionally Left Blank
}

//--- Behavioral Logics
void CounterTrendBearish::MonitorBoomerang(void) {
   if (IP.GetBidPrice(CURRENT_BAR) >= BoomerangLevel) {
      BoomerangStatus = BOOMERANG_ALLOWED;
   }
}

//--- Helper Functions
bool CounterTrendBearish::IsNewEntry(void) {
   if (BoomerangStatus == BOOMERANG_ALLOWED) {
      if (IsFirstPositionNewEntry()) {
         NewEntryProtocol(IP.GetFastMAMA(CURRENT_BAR) + PMHP.GetMinIntervalSizeInPrice());
         return true;
      }
      if (IsOtherPositionNewEntry()) {
         NewEntryProtocol(IP.GetFastFAMA(CURRENT_BAR) + PMHP.GetMinIntervalSizeInPrice());
         return true;
      }
   }
   return false;
}

//--- Helper Functions: IsNewEntry
bool CounterTrendBearish::IsFirstPositionNewEntry(void) {
   return  IsLookingForFirstPosition() && IP.GetFastMAMA(CURRENT_BAR) - PMHP.GetSlippageInPrice() >= IP.GetAskPrice(CURRENT_BAR);
}

//--- Helper Functions: IsNewEntry
bool CounterTrendBearish::IsOtherPositionNewEntry(void) {
   return !IsLookingForFirstPosition() && IP.GetFastFAMA(CURRENT_BAR) - PMHP.GetSlippageInPrice() >= IP.GetAskPrice(CURRENT_BAR);
}