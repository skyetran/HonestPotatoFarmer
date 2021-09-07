#property strict

#include "../MarketState/MarketState.mqh"

//--- Main Constructor
MarketState::MarketState(void) {
   IP = IndicatorProcessor::GetInstance();
   EntryPosition = 0;
}

//--- Set Reference Back To The Main Cordinator
void MarketState::SetMarketWatcher(MarketWatcher &Watcher) {
   MW = GetPointer(Watcher);
}

//--- Tracking Functions
int  MarketState::GetEntryPosition(void)       { return EntryPosition;      }
void MarketState::IncrementEntryPosition(void) { EntryPosition++;           }
bool MarketState::IsFirstPosition(void)        { return EntryPosition == 0; }