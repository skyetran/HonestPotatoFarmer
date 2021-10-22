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
int      MarketState::GetEntryPositionID(void)                      { return EntryPositionID;                    }
bool     MarketState::IsFirstPosition(void)                         { return EntryPositionID == 1;               }
string   MarketState::GetStateName(void)                            { return StateName;                          }
double   MarketState::GetCapstoneLevel(void)                        { return CapstoneLevel;                      }
double   MarketState::GetMaxFullyDefensiveAccumulationLevel(void)   { return MaxFullyDefensiveAccumulationLevel; }
double   MarketState::GetBullishStopLossLevel(void)                 { return BullishStopLossLevel;               }
double   MarketState::GetBearishStopLossLevel(void)                 { return BearishStopLossLevel;               }
double   MarketState::GetBoomerangLevel(void)                       { return BoomerangLevel;                     }
bool     MarketState::GetBoomerangStatus(void)                      { return BoomerangStatus;                    }
datetime MarketState::GetEntryDateTime(void)                        { return EntryDateTime;                      }

//--- Update: OnTick Function
void MarketState::Monitor(void) {
   MonitorStateTransition();
   MonitorCurrentState();
   MonitorBoomerang();
}

//--- Helper Functions
void MarketState::NewEntryProtocol(const double InputBoomerangLevel) {
   IncrementEntryPosition();
   BoomerangLevel  = InputBoomerangLevel;
   BoomerangStatus = BOOMERANG_NOT_ALLOWED;
   EntryDateTime   = TimeGMT();
}

//--- Helper Functions
void MarketState::IncrementEntryPosition(void)     { EntryPositionID++; }
bool MarketState::IsLookingForFirstPosition(void)  { return EntryPositionID == 0; }