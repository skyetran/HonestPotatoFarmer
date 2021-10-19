#ifndef MARKET_STATE_H
#define MARKET_STATE_H

#include "../General/GlobalConstants.mqh"
#include "../General/IndicatorProcessor.mqh"
#include "../General/PositionManagementHyperParameters.mqh"

class MarketWatcher;

class MarketState
{
public:
   //--- Main Constructor
   MarketState(void);
   
   //--- Set Reference Back To The Main Cordinator
   void SetMarketWatcher(MarketWatcher *Watcher);
   
   //--- Getters
   int    GetEntryPositionID(void);
   bool   IsFirstPosition(void);
   string GetStateName(void);
   double GetMaxFullyDefensiveAccumulationLevel(void);
   double GetCapstoneLevel(void);
   double GetBullishStopLossLevel(void);
   double GetBearishStopLossLevel(void);
   
   //--- Update: OnTick Functions
   void Monitor(void);
   
protected:
   //--- External Entities
   IndicatorProcessor* IP;
   PositionManagementHyperParameters *PMHP;
   
   //--- Attributes
   int    EntryPositionID;
   string StateName;
   double CapstoneLevel;
   double MaxFullyDefensiveAccumulationLevel;
   double BullishStopLossLevel;
   double BearishStopLossLevel;
   double BoomerangLevel;
   bool   BoomerangStatus;
   
   //--- Behavioral Logics
   virtual void MonitorStateTransition(void) = NULL;
   virtual void MonitorCurrentState(void)    = NULL;
   virtual void MonitorBoomerang(void)       = NULL;
   
   //--- Helper Functions: MonitorCurrentState
   virtual void MonitorCapstoneLevel(void)                      = NULL;
   virtual void MonitorMaxFullyDefensiveAccumulationLevel(void) = NULL;
   virtual void MonitorBullishStopLossLevel(void)               = NULL;
   virtual void MonitorBearishStopLossLevel(void)               = NULL;
   
   //--- Helper Functions
   void NewEntryProtocol(const double InputBoomerangLevel);
   void IncrementEntryPosition(void);
   virtual bool IsNewEntry(void) = NULL;
};

#endif