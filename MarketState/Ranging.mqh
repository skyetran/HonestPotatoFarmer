#ifndef RANGING_H
#define RANGING_H

#include "MarketState.mqh"

class Ranging : public MarketState
{
public:
   //--- Main Constructor
   Ranging(void);
   
private:
   //--- Tracking Variables
   int    LongBigHedgeEntryPositionID, ShortBigHedgeEntryPositionID;
   double LongBigHedgeCapstoneLevel, ShortBigHedgeCapstoneLevel;
   double LongBigHedgeStopLossLevel, ShortBigHedgeStopLossLevel;
   
   double LongOutOfBoundLevelBid, LongOutOfBoundLevelAsk;
   double ShortOutOfBoundLevelBid, ShortOutOfBoundLevelAsk;
   
   double LongBoomerangLevel;
   double ShortBoomerangLevel;
   bool   LongBoomerangStatus, ShortBoomerangStatus;

   //--- Behavioral Logics
   void   MonitorStateTransition(void) override;
   void   MonitorCurrentState(void)    override;
   void   MonitorBoomerang(void)       override;

   //--- Helper Functions: MonitorStateTransition
   bool   IsRangingToWithTrendBullish(void);
   bool   IsRangingToWithTrendBearish(void);
   
   //--- Helper Functions: MonitorCurrentState
   void   MonitorCapstoneLevel(void)                      override;
   void   MonitorMaxFullyDefensiveAccumulationLevel(void) override;
   void   MonitorBullishStopLossLevel(void)               override;
   void   MonitorBearishStopLossLevel(void)               override;
   
   //--- Helper Functions: MonitorMaxFullyDefensiveAccumulationLevel
   void   MonitorLongMaxFullyDefensiveAccumulationLevel(void);
   void   MonitorShortMaxFullyDefensiveAccumulationLevel(void);
   
   //--- Helper Functions: MonitorBoomerang
   void   MonitorLongBoomerang(void);
   void   MonitorShortBoomerang(void);
   
   //--- Helper Functions: Extract Long Big Hedge Attributes
   double GetLongBigHedgeCapstoneLevel(void);
   double GetLongBigHedgeStopLossLevel(void);
   
   //--- Helper Functions: Extract Short Big Hedge Attributes
   double GetShortBigHedgeCapstoneLevel(void);
   double GetShortBigHedgeStopLossLevel(void);
   
   //--- Helper Functions
   bool   IsNewEntry(void) override;
   bool   IsNewLongEntry(void);
   bool   IsNewShortEntry(void);
   
   //--- Helper Functions: IsNewLongEntry
   bool   IsFirstNewLongEntry(void);
   bool   IsOutOfBoundNewLongEntry(void);
   bool   IsBoomerangNewLongEntry(void);
   void   UpdateLongCapstoneLevel(void);
   void   UpdateLongFirstCapstoneLevel(void);
   void   UpdateLongOutOfBoundCapstoneLevel(void);
   void   UpdateLongBoomerangCapstoneLevel(void);
   void   UpdateLongGeneralInfo(void);
   void   UpdateLongBoundaryInfo(void);
   
   //--- Helper Functions: IsNewShortEntry
   bool   IsFirstNewShortEntry(void);
   bool   IsOutOfBoundNewShortEntry(void);
   bool   IsBoomerangNewShortEntry(void);
   void   UpdateShortCapstoneLevel(void);
   void   UpdateShortFirstCapstoneLevel(void);
   void   UpdateShortOutOfBoundCapstoneLevel(void);
   void   UpdateShortBoomerangCapstoneLevel(void);
   void   UpdateShortGeneralInfo(void);
   void   UpdateShortBoundaryInfo(void);
   
   //--- Utility Functions
   void   IncrementLongBigHedgeEntryPositionID(void);
   void   IncrementShortBigHedgeEntryPositionID(void);
   
   bool   IsFirstLongBigHedgeEntryPositionID(void);
   bool   IsFirstShortBigHedgeEntryPositionID(void);
   
   bool   IsLookingForFirstLongBigHedgeEntryPositionID(void);
   bool   IsLookingForFirstShortBigHedgeEntryPositionID(void);
   
   void   SetEntryPositionID(const int InputEntryPositionID);
   void   SetLongEntryPositionID();
   void   SetShortEntryPositionID();
   
   void   SetCapstoneLevel(const double InputCapstoneLevel);
   void   SetLongCapstoneLevel(void);
   void   SetShortCapstoneLevel(void);
   
   void   SetBullishStopLossLevel(void);
   void   SetBearishStopLossLevel(void);
   
   void   ResetBullishStopLossLevel(void);
   void   ResetBearishStopLossLevel(void);
   
   void   SetLongBoomerangLevel(void);
   void   SetShortBoomerangLevel(void);
   
   void   SetBoomerangStatus(void);
   
   bool   IsAboveFilteredPrice(void);
   bool   IsBelowFilteredPrice(void);
};

#endif