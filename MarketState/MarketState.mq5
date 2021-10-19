#property strict

#include "../MarketState/MarketState.mqh"

//--- Main Constructor
MarketState::MarketState(void) {
   IP   = IndicatorProcessor::GetInstance();
   PMHP = PositionManagementHyperParameters::GetInstance();
   EntryPositionID = 0;
}

//--- Set Reference Back To The Main Cordinator
void MarketState::SetMarketWatcher(MarketWatcher *Watcher) {
   MW = Watcher;
}

//--- Getters
int    MarketState::GetEntryPositionID(void)                      { return EntryPositionID;                    }
bool   MarketState::IsFirstPosition(void)                         { return EntryPositionID == 0;               }
string MarketState::GetStateName(void)                            { return StateName;                          }
double MarketState::GetCapstoneLevel(void)                        { return CapstoneLevel;                      }
double MarketState::GetMaxFullyDefensiveAccumulationLevel(void)   { return MaxFullyDefensiveAccumulationLevel; }
double MarketState::GetBullishStopLossLevel(void)                 { return BullishStopLossLevel;               }
double MarketState::GetBearishStopLossLevel(void)                 { return BearishStopLossLevel;               }

//--- Update: OnTick Function
void MarketState::Monitor(void) {
   MonitorStateTransition();
   MonitorCurrentState();
}

//--- Helper Functions
void MarketState::NewEntryProtocol(const double InputBoomerangLevel) {
   IncrementEntryPosition();
   BoomerangStatus = BOOMERANG_NOT_ALLOWED;
   BoomerangLevel  = InputBoomerangLevel;
}

//--- Helper Functions
void MarketState::IncrementEntryPosition(void) { EntryPositionID++; }