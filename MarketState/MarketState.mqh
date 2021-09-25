#ifndef MARKET_STATE_H
#define MARKET_STATE_H

#include "../General/GlobalConstants.mqh"
#include "../General/IndicatorProcessor.mqh"

class MarketWatcher;

class MarketState
{
public:
   //--- Main Constructor
   MarketState(void);
   
   //--- Set Reference Back To The Main Cordinator
   void SetMarketWatcher(MarketWatcher *Watcher);
   
   //--- Tracking Functions
   int GetEntryPosition(void);
   void IncrementEntryPosition(void);
   bool IsFirstPosition(void);
   
   //--- Behavioral Logics
   virtual void MonitorStateTransition(void) = NULL;
   virtual string GetStateName(void)         = NULL;
   
protected:
   MarketWatcher* MW;
   IndicatorProcessor* IP;
   
   int EntryPositionID;
};

#endif