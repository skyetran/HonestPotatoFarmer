#property strict

#include "../MarketState/WithTrendBearish.mqh"

//--- Main Constructor
WithTrendBearish::WithTrendBearish() {
   StateName = "With-Trend Bearish";
   BoomerangStatus = BOOMERANG_ALLOWED;
   BullishStopLossLevel = NOT_APPLICABLE;
}

//--- Behavioral Logics
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

//--- Helper Functions: State Transition
bool WithTrendBearish::IsWithTrendBearishToRanging(void) {
   return MW.GetCurrentDiffFastFAMA_LowestFastFAMA_Pts() <= MW.GetWiggleBuffer() &&
          IP.GetDiffFastFAMA_SlowFAMA_Pts(CURRENT_BAR) <= MW.GetInChannelBuffer() ;
}

//--- Helper Functions: State Transition
bool WithTrendBearish::IsWithTrendBearishToCounterTrendBearish(void) {
   return MW.GetCurrentDiffFastFAMA_LowestFastFAMA_Pts() > MW.GetWiggleBuffer() &&
          IP.GetFastFAMA(CURRENT_BAR) > MW.GetLowestFastFAMA()                   ;
}

//--- Behavioral Logics
void WithTrendBearish::MonitorCurrentState(void) {
   if (IsNewEntry()) {
      MonitorCapstoneLevel();
      MonitorMaxFullyDefensiveAccumulationLevel();
      MonitorBullishStopLossLevel();
      MonitorBearishStopLossLevel();
   }
}

//--- Helper Functions: MonitorCurrentState
void WithTrendBearish::MonitorCapstoneLevel(void) {
   if (IsFirstPosition()) {
      CapstoneLevel = IP.GetFastMAMA(CURRENT_BAR);
   } else {
      CapstoneLevel = IP.GetFastFAMA(CURRENT_BAR);
   }
}

//--- Helper Functions: MonitorCurrentState
void WithTrendBearish::MonitorMaxFullyDefensiveAccumulationLevel(void) {
   MaxFullyDefensiveAccumulationLevel = GetCapstoneLevel() - GetMaxIntervalSizeInPrice();
}

//--- Helper Functions: GetMaxFullyDefensiveAccumulationLevel
double WithTrendBearish::GetMaxIntervalSizeInPrice(void) {
   return PointToPriceCvt(GetMaxIntervalSizeInPts());
}

//--- Helper Functions: GetMaxFullyDefensiveAccumulationLevel
int WithTrendBearish::GetMaxIntervalSizeInPts(void) {
   int FirstMaxIntervalSizeOption  = PriceToPointCvt(GetCapstoneLevel() - IP.GetLowerSSB(CURRENT_BAR));
   int SecondMaxIntervalSizeOption = IP.GetTakeProfitVolatilityInPts(CURRENT_BAR);
   return MathMax(FirstMaxIntervalSizeOption, SecondMaxIntervalSizeOption);
}

//--- Helper Functions: MonitorCurrentState
void WithTrendBearish::MonitorBullishStopLossLevel(void) {
   //--- Intentionally Left Blank
}

//--- Helper Functions: MonitorCurrentState
void WithTrendBearish::MonitorBearishStopLossLevel(void) {
   BearishStopLossLevel = GetBearishStopLossLevel();
}

//--- Behavioral Logics
void WithTrendBearish::MonitorBoomerang(void) {
   if (IP.GetAskPrice(CURRENT_BAR) <= BoomerangLevel) {
      BoomerangStatus = BOOMERANG_ALLOWED;
   }
}

//--- Behavioral Logics
void WithTrendBearish::MonitorDownsideBoomerang(void) {
   if (IP.GetAskPrice(CURRENT_BAR) >= DownsideBoomerangLevel) {
      BoomerangStatus = BOOMERANG_ALLOWED;
   }
}

//--- Helper Function
bool WithTrendBearish::IsNewEntry(void) {
   if (BoomerangStatus == BOOMERANG_ALLOWED) {
      if (IsFirstPositionNewEntry()) {
         NewEntryProtocol(IP.GetFastMAMA(CURRENT_BAR) - PMHP.GetMinIntervalSizeInPrice(), GetBearishStopLossLevel() + IP.GetAverageSpreadInPrice(CURRENT_BAR));
         return true;
      }
      if (IsOtherPositionNewEntry()) {
         NewEntryProtocol(IP.GetFastFAMA(CURRENT_BAR) - PMHP.GetMinIntervalSizeInPrice(), GetBearishStopLossLevel() + IP.GetAverageSpreadInPrice(CURRENT_BAR));
         return true;
      }
   }
   return false;
}

//--- Helper Functions: IsNewEntry
bool WithTrendBearish::IsFirstPositionNewEntry(void) {
   return IsLookingForFirstPosition()                                                                &&
          IP.GetBidPrice(CURRENT_BAR) >= IP.GetFastMAMA(CURRENT_BAR) + 1 * PMHP.GetSlippageInPrice() &&
          IP.GetBidPrice(CURRENT_BAR) <= IP.GetFastMAMA(CURRENT_BAR) + 2 * PMHP.GetSlippageInPrice() ;
}

//--- Helper Functions: IsNewEntry
bool WithTrendBearish::IsOtherPositionNewEntry(void) {
   return !IsLookingForFirstPosition()                                                               &&
          IP.GetBidPrice(CURRENT_BAR) >= IP.GetFastFAMA(CURRENT_BAR) + 1 * PMHP.GetSlippageInPrice() &&
          IP.GetBidPrice(CURRENT_BAR) <= IP.GetFastFAMA(CURRENT_BAR) + 2 * PMHP.GetSlippageInPrice() ;
}

//--- Utility Functions
double WithTrendBearish::GetBearishStopLossLevel(void) {
   double FirstStopLossLevelOption = IP.GetSellStopLossLevel(CURRENT_BAR);
   double SecondStopLossLevelOption = GetCapstoneLevel() + IP.GetStopLossVolatilityInPrice(CURRENT_BAR);
   return MathMax(FirstStopLossLevelOption, SecondStopLossLevelOption);
}