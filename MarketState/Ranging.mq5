#property strict

#include "../MarketState/Ranging.mqh"

//--- Main Constructor
Ranging::Ranging(void) {
   StateName = "Ranging";
   LongBigHedgeEntryPositionID = 0;
   ShortBigHedgeEntryPositionID = 0;
   LongBoomerangStatus = BOOMERANG_ALLOWED;
   ShortBoomerangStatus = BOOMERANG_ALLOWED;
}

//--- Behavioral Logics
void Ranging::MonitorStateTransition(void) {
   if (IsRangingToWithTrendBullish()) {
      MW.ResetTrackingVariables();
      MW.ChangeState(new WithTrendBullish());
   }
   if (IsRangingToWithTrendBearish()) {
      MW.ResetTrackingVariables();
      MW.ChangeState(new WithTrendBearish());
   }
}

//--- Helper Functions: State Transition
bool Ranging::IsRangingToWithTrendBullish(void) {
   return IP.GetFastFAMA(CURRENT_BAR) > IP.GetSlowFAMA(CURRENT_BAR) &&
          IP.GetDiffFastFAMA_SlowFAMA_Pts(CURRENT_BAR) > MW.GetOutChannelBuffer();
}

//--- Helper Functions: State Transition
bool Ranging::IsRangingToWithTrendBearish(void) {
   return IP.GetFastFAMA(CURRENT_BAR) < IP.GetSlowFAMA(CURRENT_BAR) &&
          IP.GetDiffFastFAMA_SlowFAMA_Pts(CURRENT_BAR) > MW.GetOutChannelBuffer();
}

//--- Behavioral Logics
void Ranging::MonitorCurrentState(void) {
   if (IsNewEntry()) {
      MonitorMaxFullyDefensiveAccumulationLevel();
      MonitorBullishStopLossLevel();
      MonitorBearishStopLossLevel();
   }
}

//--- Helper Functions: MonitorCurrentState
void Ranging::MonitorCapstoneLevel(void) {
   //--- Intentionally Left Blank
}

//--- Helper Functions: MonitorCurrentState
void Ranging::MonitorMaxFullyDefensiveAccumulationLevel(void) {
   MonitorLongMaxFullyDefensiveAccumulationLevel();
   MonitorShortMaxFullyDefensiveAccumulationLevel();
}

//--- Helper Functions: MonitorMaxFullyDefensiveAccuulationLevel
void Ranging::MonitorLongMaxFullyDefensiveAccumulationLevel(void) {
   if (IsAboveFilteredPrice()) {
      double FirstDefensiveAccumulationLevelOption  = GetLongBigHedgeStopLossLevel() + PMHP.GetOutOfBoundBufferInPrice();
      double SecondDefensiveAccumulationLevelOption = NormalizeDouble((GetLongBigHedgeStopLossLevel() + GetShortBigHedgeCapstoneLevel()) / 2, Digits());
      MaxFullyDefensiveAccumulationLevel = MathMin(FirstDefensiveAccumulationLevelOption, SecondDefensiveAccumulationLevelOption);
   }
}

//--- Helper Functions: MonitorMaxFullyDefensiveAccumulationLevel
void Ranging::MonitorShortMaxFullyDefensiveAccumulationLevel(void) {
   if (IsBelowFilteredPrice()) {
      double FirstDefensiveAccumulationLevelOption  = GetShortBigHedgeStopLossLevel() - PMHP.GetOutOfBoundBufferInPrice();
      double SecondDefensiveAccumulationLevelOption = NormalizeDouble((GetShortBigHedgeStopLossLevel() + GetLongBigHedgeCapstoneLevel()) / 2, Digits());
      MaxFullyDefensiveAccumulationLevel = MathMin(FirstDefensiveAccumulationLevelOption, SecondDefensiveAccumulationLevelOption);
   }
}

//--- Helper Functions: MonitorCurrentState
void Ranging::MonitorBullishStopLossLevel(void) {
   if (IsAboveFilteredPrice()) {
      LongBigHedgeStopLossLevel = GetLongBigHedgeStopLossLevel();
      SetBullishStopLossLevel();
      ResetBearishStopLossLevel();
   }
}

//--- Helper Functions: MonitorCurrentState
void Ranging::MonitorBearishStopLossLevel(void) {
   if (IsBelowFilteredPrice()) {
      ShortBigHedgeStopLossLevel = GetShortBigHedgeStopLossLevel();
      SetBearishStopLossLevel();
      ResetBullishStopLossLevel();
   }
}

//--- Behavioral Logics
void Ranging::MonitorBoomerang(void) {
   MonitorLongBoomerang();
   MonitorShortBoomerang();
   SetBoomerangStatus();
}

//--- Helper Functions: MonitorBoomerang
void Ranging::MonitorLongBoomerang(void) {
   if (IP.GetBidPrice(CURRENT_BAR) <= LongBoomerangLevel) {
      LongBoomerangStatus = BOOMERANG_ALLOWED;
   }
}

//--- Helper Functions: MonitorBoomerang
void Ranging::MonitorShortBoomerang(void) {
   if (IP.GetAskPrice(CURRENT_BAR) >= ShortBoomerangLevel) {
      ShortBoomerangStatus = BOOMERANG_ALLOWED;
   }
}

//--- Helper Functions: Extract Long Big Hedge Attributes
double Ranging::GetLongBigHedgeCapstoneLevel(void) {
   return IP.GetUpperSSB(CURRENT_BAR);
}

//--- Helper Functions: Extract Long Big Hedge Attributes
double Ranging::GetLongBigHedgeStopLossLevel(void) {
   return MathMin(MW.GetLowestBuyStopLossLevel(), MW.GetLowestBidPrice());
}

//--- Helper Functions: Extract Short Big Hedge Attributes
double Ranging::GetShortBigHedgeCapstoneLevel(void) {
   return IP.GetLowerSSB(CURRENT_BAR);
}

//--- Helper Functions: Extract Short Big Hedge Attributes
double Ranging::GetShortBigHedgeStopLossLevel(void) {
   return MathMax(MW.GetHighestSellStopLossLevel(), MW.GetHighestBidPrice());
}

//--- Helper Functions
bool Ranging::IsNewEntry(void) {
   if (IsAboveFilteredPrice()) {
      return IsNewLongEntry();
   }
   return IsNewShortEntry();
}

//--- Helper Functions
bool Ranging::IsNewLongEntry(void) {
   if (IsFirstNewLongEntry() || IsOutOfBoundNewLongEntry() || IsBoomerangNewLongEntry()) {
      UpdateLongCapstoneLevel();
      UpdateLongGeneralInfo();
      return true;
   }
   return false;
}

//--- Helper Functions: IsNewLongEntry
bool Ranging::IsFirstNewLongEntry(void) {
   return IsLookingForFirstLongBigHedgeEntryPositionID()              &&
          IP.GetBidPrice(CURRENT_BAR) >= GetLongBigHedgeCapstoneLevel();
}

//--- Helper Functions: IsNewLongEntry
bool Ranging::IsOutOfBoundNewLongEntry(void) {
   return !IsLookingForFirstLongBigHedgeEntryPositionID()       &&
          IP.GetBidPrice(CURRENT_BAR) >= LongOutOfBoundLevelBid &&
          IP.GetAskPrice(CURRENT_BAR) >= LongOutOfBoundLevelAsk &&
          LongBoomerangStatus == BOOMERANG_NOT_ALLOWED           ;
}

//--- Helper Functions: IsNewLongEntry
bool Ranging::IsBoomerangNewLongEntry(void) {
   return !IsLookingForFirstLongBigHedgeEntryPositionID()               &&
          IP.GetBidPrice(CURRENT_BAR) >= GetLongBigHedgeCapstoneLevel() &&
          LongBoomerangStatus == BOOMERANG_ALLOWED                       ;
}

//--- Helper Functions: IsNewLongEntry
void Ranging::UpdateLongCapstoneLevel(void) {
   if (IsFirstNewLongEntry()) {
      UpdateLongFirstCapstoneLevel();
   } else if (IsOutOfBoundNewLongEntry()) {
      UpdateLongOutOfBoundCapstoneLevel();
   } else if (IsBoomerangNewLongEntry()) {
      UpdateLongBoomerangCapstoneLevel();
   }
   SetLongCapstoneLevel();
}

//--- Helper Functions: UpdateLongCapstoneLevel
void Ranging::UpdateLongFirstCapstoneLevel(void) {
   LongBigHedgeCapstoneLevel = GetLongBigHedgeCapstoneLevel();
}

//--- Helper Functions: UpdateLongCapstoneLevel
void Ranging::UpdateLongOutOfBoundCapstoneLevel(void) {
   LongBigHedgeCapstoneLevel += PMHP.GetOutOfBoundBufferInPrice();
}

//--- Helper Functions: UpdateLongCapstoneLevel
void Ranging::UpdateLongBoomerangCapstoneLevel(void) {
   LongBigHedgeCapstoneLevel = GetLongBigHedgeCapstoneLevel();
}

//--- Helper Functions: IsNewLongEntry
void Ranging::UpdateLongGeneralInfo(void) {
   UpdateLongBoundaryInfo();
   IncrementLongBigHedgeEntryPositionID();
   SetLongEntryPositionID();
   SetLongBoomerangLevel();
   LongBoomerangStatus = BOOMERANG_NOT_ALLOWED;
   EntryDateTime = TimeGMT();
}

//--- Helper Functions: UpdateLongGeneralInfo
void Ranging::UpdateLongBoundaryInfo(void) {
   if (IsLookingForFirstLongBigHedgeEntryPositionID()) {
      LongOutOfBoundLevelBid = GetLongBigHedgeCapstoneLevel() + PMHP.GetOutOfBoundBufferInPrice();
      LongOutOfBoundLevelAsk = LongOutOfBoundLevelBid + IP.GetAverageSpreadInPrice(CURRENT_BAR);
      LongBoomerangLevel     = GetLongBigHedgeStopLossLevel() - IP.GetAverageSpreadInPrice(CURRENT_BAR);
   } else {
      LongOutOfBoundLevelBid = LongBigHedgeCapstoneLevel + PMHP.GetOutOfBoundBufferInPrice();
      LongOutOfBoundLevelAsk = LongOutOfBoundLevelBid + IP.GetAverageSpreadInPrice(CURRENT_BAR);
      LongBoomerangLevel     = GetLongBigHedgeStopLossLevel() - IP.GetAverageSpreadInPrice(CURRENT_BAR);
   }
}

//--- Helper Functions
bool Ranging::IsNewShortEntry(void) {
   if (IsFirstNewShortEntry() || IsOutOfBoundNewShortEntry() || IsBoomerangNewShortEntry()) {
      UpdateShortCapstoneLevel();
      UpdateShortGeneralInfo();
      return true;
   }
   return false;
}

//--- Helper Functions: IsNewShortEntry
bool Ranging::IsFirstNewShortEntry(void) {
   return IsLookingForFirstShortBigHedgeEntryPositionID()              &&
          IP.GetAskPrice(CURRENT_BAR) <= GetShortBigHedgeCapstoneLevel();
}

//--- Helper Functions: IsNewShortEntry
bool Ranging::IsOutOfBoundNewShortEntry(void) {
   return !IsLookingForFirstShortBigHedgeEntryPositionID()       &&
          IP.GetBidPrice(CURRENT_BAR) <= ShortOutOfBoundLevelBid &&
          IP.GetAskPrice(CURRENT_BAR) <= ShortOutOfBoundLevelAsk &&
          ShortBoomerangStatus == BOOMERANG_NOT_ALLOWED           ;
}

//--- Helper Functions: IsNewShortEntry
bool Ranging::IsBoomerangNewShortEntry(void) {
   return !IsLookingForFirstShortBigHedgeEntryPositionID()               &&
          IP.GetAskPrice(CURRENT_BAR) <= GetShortBigHedgeCapstoneLevel() &&
          ShortBoomerangStatus == BOOMERANG_ALLOWED                       ;
}

//--- Helper Functions: IsNewShortEntry
void Ranging::UpdateShortCapstoneLevel(void) {
   if (IsFirstNewShortEntry()) {
      UpdateShortFirstCapstoneLevel();
   } else if (IsOutOfBoundNewShortEntry()) {
      UpdateShortOutOfBoundCapstoneLevel();
   } else if (IsBoomerangNewShortEntry()) {
      UpdateShortBoomerangCapstoneLevel();
   }
   SetShortCapstoneLevel();
}

//--- Helper Functions: UpdateShortCapstoneLevel
void Ranging::UpdateShortFirstCapstoneLevel(void) {
   ShortBigHedgeCapstoneLevel = GetShortBigHedgeCapstoneLevel();
}

//--- Helper Functions: UpdateShortCapstoneLevel
void Ranging::UpdateShortOutOfBoundCapstoneLevel(void) {
   ShortBigHedgeCapstoneLevel -= PMHP.GetOutOfBoundBufferInPrice();
}

//--- Helper Functions: UpdateShortCapstoneLevel
void Ranging::UpdateShortBoomerangCapstoneLevel(void) {
   ShortBigHedgeCapstoneLevel = GetShortBigHedgeCapstoneLevel();
}

//--- Helper Functions: IsNewShortEntry
void Ranging::UpdateShortGeneralInfo(void) {
   UpdateShortBoundaryInfo();
   IncrementShortBigHedgeEntryPositionID();
   SetShortEntryPositionID();
   SetShortBoomerangLevel();
   ShortBoomerangStatus = BOOMERANG_NOT_ALLOWED;
   EntryDateTime = TimeGMT();
}

//--- Helper Functions: UpdateShortGeneralInfo
void Ranging::UpdateShortBoundaryInfo(void) {
   if (IsLookingForFirstShortBigHedgeEntryPositionID()) {
      ShortOutOfBoundLevelBid = GetShortBigHedgeCapstoneLevel() - PMHP.GetOutOfBoundBufferInPrice() - IP.GetAverageSpreadInPrice(CURRENT_BAR);
      ShortOutOfBoundLevelAsk = ShortOutOfBoundLevelBid + IP.GetAverageSpreadInPrice(CURRENT_BAR);
      ShortBoomerangLevel     = GetShortBigHedgeStopLossLevel() + IP.GetAverageSpreadInPrice(CURRENT_BAR);
   } else {
      ShortOutOfBoundLevelBid = ShortBigHedgeCapstoneLevel - PMHP.GetOutOfBoundBufferInPrice() - IP.GetAverageSpreadInPrice(CURRENT_BAR);
      ShortOutOfBoundLevelAsk = ShortOutOfBoundLevelBid + IP.GetAverageSpreadInPrice(CURRENT_BAR);
      ShortBoomerangLevel     = GetShortBigHedgeStopLossLevel() + IP.GetAverageSpreadInPrice(CURRENT_BAR);
   }
}

//--- Ultility Functions
void Ranging::IncrementLongBigHedgeEntryPositionID(void)          { LongBigHedgeEntryPositionID++;                     }
void Ranging::IncrementShortBigHedgeEntryPositionID(void)         { ShortBigHedgeEntryPositionID++;                    }

//--- Utility Functions
bool Ranging::IsFirstLongBigHedgeEntryPositionID(void)            { return LongBigHedgeEntryPositionID == 1;           }
bool Ranging::IsFirstShortBigHedgeEntryPositionID(void)           { return ShortBigHedgeEntryPositionID == 1;          }

//--- Utility Functions
bool Ranging::IsLookingForFirstLongBigHedgeEntryPositionID(void)  { return LongBigHedgeEntryPositionID == 0;           }
bool Ranging::IsLookingForFirstShortBigHedgeEntryPositionID(void) { return ShortBigHedgeEntryPositionID == 0;          }

//--- Utility Functions
void Ranging::SetEntryPositionID(const int InputEntryPositionID)  { EntryPositionID = InputEntryPositionID;            }
void Ranging::SetLongEntryPositionID(void)                        { SetEntryPositionID(LongBigHedgeEntryPositionID);   }
void Ranging::SetShortEntryPositionID(void)                       { SetEntryPositionID(ShortBigHedgeEntryPositionID);  }

//--- Utility Functions
void Ranging::SetCapstoneLevel(const double InputCapstoneLevel)   { CapstoneLevel = InputCapstoneLevel;                }
void Ranging::SetLongCapstoneLevel(void)                          { SetCapstoneLevel(LongBigHedgeCapstoneLevel);       }
void Ranging::SetShortCapstoneLevel(void)                         { SetCapstoneLevel(ShortBigHedgeCapstoneLevel);      }

//--- Utility Functions
void Ranging::SetBullishStopLossLevel(void)                       { BullishStopLossLevel = LongBigHedgeStopLossLevel;  }
void Ranging::SetBearishStopLossLevel(void)                       { BearishStopLossLevel = ShortBigHedgeStopLossLevel; }

//--- Utility Functions
void Ranging::ResetBullishStopLossLevel(void)                     { BullishStopLossLevel = 0;                          }
void Ranging::ResetBearishStopLossLevel(void)                     { BearishStopLossLevel = 0;                          }

//--- Utility Functions
void Ranging::SetLongBoomerangLevel(void)                         { BoomerangLevel = LongBoomerangLevel;               }
void Ranging::SetShortBoomerangLevel(void)                        { BoomerangLevel = ShortBoomerangLevel;              }

//--- Utility Functions
void Ranging::SetBoomerangStatus(void)                            { BoomerangStatus = (LongBoomerangStatus || ShortBoomerangStatus);       }

//--- Utility Functions
bool Ranging::IsAboveFilteredPrice(void)                          { return IP.GetBidPrice(CURRENT_BAR) > IP.GetFilteredPrice(CURRENT_BAR); }
bool Ranging::IsBelowFilteredPrice(void)                          { return IP.GetAskPrice(CURRENT_BAR) < IP.GetFilteredPrice(CURRENT_BAR); }