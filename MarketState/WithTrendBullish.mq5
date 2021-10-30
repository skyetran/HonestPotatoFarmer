#property strict

#include "../MarketState/WithTrendBullish.mqh"

//--- Main Constructor
WithTrendBullish::WithTrendBullish() { 
   StateName = "With-Trend Bullish";
   BoomerangStatus = BOOMERANG_ALLOWED;
   BearishStopLossLevel = NOT_APPLICABLE;
}

//--- Behavioral Logics
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

//--- Helper Functions: State Transition
bool WithTrendBullish::IsWithTrendBullishToRanging(void) {
   return MW.GetCurrentDiffFastFAMA_HighestFastFAMA_Pts() <= MW.GetWiggleBuffer() &&
          IP.GetDiffFastFAMA_SlowFAMA_Pts(CURRENT_BAR) <= MW.GetInChannelBuffer()  ;
}

//--- Helper Functions: State Transition
bool WithTrendBullish::IsWithTrendBullishToCounterTrendBullish(void) {
   return MW.GetCurrentDiffFastFAMA_HighestFastFAMA_Pts() > MW.GetWiggleBuffer() &&
          IP.GetFastFAMA(CURRENT_BAR) < MW.GetHighestFastFAMA()                   ;
}

//--- Behavioral Logics
void WithTrendBullish::MonitorCurrentState(void) {
   if (IsNewEntry()) {
      MonitorCapstoneLevel();
      MonitorMaxFullyDefensiveAccumulationLevel();
      MonitorBullishStopLossLevel();
      MonitorBearishStopLossLevel();
   }
}

//--- Helper Functions: MonitorCurrentState
void WithTrendBullish::MonitorCapstoneLevel(void) {
   if (IsFirstPosition()) {
      CapstoneLevel = IP.GetFastMAMA(CURRENT_BAR);
   } else {
      CapstoneLevel = IP.GetFastFAMA(CURRENT_BAR);
   }
}

//--- Helper Functions: MonitorCurrentState
void WithTrendBullish::MonitorMaxFullyDefensiveAccumulationLevel(void) {
   MaxFullyDefensiveAccumulationLevel = GetCapstoneLevel() + GetMaxIntervalSizeInPrice();
}

//--- Helper Functions: GetMaxFullyDefensiveAccumulationLevel
double WithTrendBullish::GetMaxIntervalSizeInPrice(void) {
   return PointToPriceCvt(GetMaxIntervalSizeInPts());
}

//--- Helper Functions: GetMaxFullyDefensiveAccumulationLevel
int WithTrendBullish::GetMaxIntervalSizeInPts(void) {
   int FirstMaxIntervalSizeOption  = PriceToPointCvt(IP.GetUpperSSB(CURRENT_BAR) - GetCapstoneLevel());
   int SecondMaxIntervalSizeOption = IP.GetTakeProfitVolatilityInPts(CURRENT_BAR);
   return MathMax(FirstMaxIntervalSizeOption, SecondMaxIntervalSizeOption);
}

//--- Helper Functions: MonitorCurrentState
void WithTrendBullish::MonitorBullishStopLossLevel(void) {
   BullishStopLossLevel = GetBullishStopLossLevel();
}

//--- Helper Functions: MonitorCurrentState
void WithTrendBullish::MonitorBearishStopLossLevel(void) {
   //--- Intentionally Left Blank
}

//--- Behavioral Logics
void WithTrendBullish::MonitorBoomerang(void) {
   if (IP.GetBidPrice(CURRENT_BAR) >= BoomerangLevel) {
      BoomerangStatus = BOOMERANG_ALLOWED;
   }
}

//--- Behavioral Logics
void WithTrendBullish::MonitorDownsideBoomerang(void) {
   if (IP.GetBidPrice(CURRENT_BAR) <= DownsideBoomerangLevel) {
      BoomerangStatus = BOOMERANG_ALLOWED;
   }
}

//--- Helper Functions
bool WithTrendBullish::IsNewEntry(void) {
   if (BoomerangStatus == BOOMERANG_ALLOWED) {
      if (IsFirstPositionNewEntry()) {
         NewEntryProtocol(IP.GetFastMAMA(CURRENT_BAR) + PMHP.GetMinIntervalSizeInPrice(), GetBullishStopLossLevel() - IP.GetAverageSpreadInPrice(CURRENT_BAR));
         return true;
      }
      if (IsOtherPositionNewEntry()) {
         NewEntryProtocol(IP.GetFastFAMA(CURRENT_BAR) + PMHP.GetMinIntervalSizeInPrice(), GetBullishStopLossLevel() - IP.GetAverageSpreadInPrice(CURRENT_BAR));
         return true;
      }
   }
   return false;
}

//--- Helper Functions: IsNewEntry
bool WithTrendBullish::IsFirstPositionNewEntry(void) {
   return IsLookingForFirstPosition()                                                                &&
          IP.GetAskPrice(CURRENT_BAR) <= IP.GetFastMAMA(CURRENT_BAR) - 1 * PMHP.GetSlippageInPrice() &&
          IP.GetAskPrice(CURRENT_BAR) >= IP.GetFastMAMA(CURRENT_BAR) - 2 * PMHP.GetSlippageInPrice() ;
}

//--- Helper Functions: IsNewEntry
bool WithTrendBullish::IsOtherPositionNewEntry(void) {
   return !IsLookingForFirstPosition()                                                               &&
          IP.GetAskPrice(CURRENT_BAR) <= IP.GetFastFAMA(CURRENT_BAR) - 1 * PMHP.GetSlippageInPrice() &&
          IP.GetAskPrice(CURRENT_BAR) >= IP.GetFastFAMA(CURRENT_BAR) - 2 * PMHP.GetSlippageInPrice() ;
}

//--- Utility Functions
double WithTrendBullish::GetBullishStopLossLevel(void) {
   double FirstStopLossLevelOption = IP.GetBuyStopLossLevel(CURRENT_BAR);
   double SecondStopLossLevelOption = GetCapstoneLevel() - IP.GetStopLossVolatilityInPrice(CURRENT_BAR);
   return MathMin(FirstStopLossLevelOption, SecondStopLossLevelOption);
}