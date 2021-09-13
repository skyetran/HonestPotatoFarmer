#property strict

#include "../MarketState/MarketState.mqh"

//--- Main Constructor
MarketState::MarketState(void) {
   IP = IndicatorProcessor::GetInstance();
   EntryPositionID = 0;
}

//--- Set Reference Back To The Main Cordinator
void MarketState::SetMarketWatcher(MarketWatcher *Watcher) {
   MW = Watcher;
}

//--- Tracking Functions
int  MarketState::GetEntryPosition(void)       { return EntryPositionID;      }
void MarketState::IncrementEntryPosition(void) { EntryPositionID++;           }
bool MarketState::IsFirstPosition(void)        { return EntryPositionID == 0; }