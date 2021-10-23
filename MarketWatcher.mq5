#property strict

#include "MarketWatcher.mqh"

//--- Default Constructor
MarketWatcher::MarketWatcher(void) { }

//--- Main Constructor
MarketWatcher::MarketWatcher(MarketState *InitialState) {
   this.ChangeState(InitialState);
   IP = IndicatorProcessor::GetInstance();
   PMHP = PositionManagementHyperParameters::GetInstance();
   LastEntryDateTime     = TimeGMT();
   LastLastEntryDateTime = TimeGMT();
}

//--- Destructor
MarketWatcher::~MarketWatcher(void) {
   delete CurrentState;
}

//--- Debug
string MarketWatcher::GetDebugMessage(void) {
   string Msg;
   Msg += "In-Channel Buffer: "  + IntegerToString(GetInChannelBuffer())                     + "\n";
   Msg += "Out-Channel Buffer: " + IntegerToString(GetOutChannelBuffer())                    + "\n";
   Msg += "Wiggle Buffer: "      + IntegerToString(GetWiggleBuffer())                        + "\n";
   Msg += "Slippage In Price: "  + DoubleToString(PMHP.GetSlippageInPrice())                 + "\n";
   Msg += "Min Interval Size In Price: "  + DoubleToString(PMHP.GetMinIntervalSizeInPrice()) + "\n";
   Msg += "\n";
   Msg += "Highest Fast FAMA: " + DoubleToString(GetHighestFastFAMA()) + "\n";
   Msg += "Highest Bid Price: " + DoubleToString(GetHighestBidPrice()) + "\n";
   Msg += "Highest Ask Price: " + DoubleToString(GetHighestAskPrice()) + "\n";
   Msg += "Highest Sell Stop Loss Level: " + DoubleToString(GetHighestSellStopLossLevel()) + "\n";
   Msg += "\n";
   Msg += "Lowest Fast FAMA: " + DoubleToString(GetLowestFastFAMA()) + "\n";
   Msg += "Lowest Bid Price: " + DoubleToString(GetLowestBidPrice()) + "\n";
   Msg += "Lowest Ask Price: " + DoubleToString(GetLowestAskPrice()) + "\n";
   Msg += "Lowest Buy Stop Loss Level: " + DoubleToString(GetLowestBuyStopLossLevel()) + "\n";
   Msg += "\n";
   Msg += "Difference Fast FAMA --- Highest Fast FAMA: " + IntegerToString(GetCurrentDiffFastFAMA_HighestFastFAMA_Pts()) + "\n";
   Msg += "Difference Fast FAMA --- Lowest Fast FAMA: "  + IntegerToString(GetCurrentDiffFastFAMA_LowestFastFAMA_Pts())  + "\n";
   Msg += "\n";
   Msg += "Start Entry Date & Time: " + GetStartCacheDateTime()                                                + "\n";
   Msg += "Market State Name: " + GetStateName()                                                               + "\n";
   Msg += "Entry Position ID: " + IntegerToString(GetEntryPositionID())                                        + "\n";
   Msg += "Capstone Level: " + DoubleToString(GetCapstoneLevel())                                              + "\n";
   Msg += "Max Fully Defensive Accumulation Level: " + DoubleToString(GetMaxFullyDefensiveAccumulationLevel()) + "\n";
   Msg += "Bullish Stop Loss Level: " + DoubleToString(GetBullishStopLossLevel())                              + "\n";
   Msg += "Bearish Stop Loss Level: " + DoubleToString(GetBearishStopLossLevel())                              + "\n";
   Msg += "Boomerang Level: " + DoubleToString(GetBoomerangLevel())                                            + "\n";
   Msg += "Boomerang Status: " + GetBoomerangStatus()                                                          + "\n";
   Msg += "Entry Date & Time: " + GetEntryDateTime()                                                           + "\n";
   return Msg;
}

//--- Setters (Hyperparameters)
bool MarketWatcher::SetInChannelBuffer(const int &BufferZone) {
   if (!IsBufferZoneValid(BufferZone)) {
      return false;
   }
   InChannelBuffer = BufferZone;
   return true;
}

bool MarketWatcher::SetOutChannelBuffer(const int &BufferZone) {
   if (!IsBufferZoneValid(BufferZone)) {
      return false;
   }
   OutChannelBuffer = BufferZone;
   return true;
}

bool MarketWatcher::SetWiggleBuffer(const int &BufferZone) {
   if (!IsBufferZoneValid(BufferZone)) {
      return false;
   }
   WiggleBuffer = BufferZone;
   return true;
}

//--- Validation: BufferZone
bool MarketWatcher::IsBufferZoneValid(const int &BufferZone) { return BufferZone >= MIN_BUFFER_ZONE; }

//--- Switch Current State
void MarketWatcher::ChangeState(MarketState *State) {
   if (!CurrentState) {
      delete CurrentState;
   }
   CurrentState = State;
   CurrentState.SetMarketWatcher(GetPointer(this));
}

//--- Execution Logics From The Current State
void   MarketWatcher::Monitor(void) { 
   CurrentState.Monitor();
   UpdateTrackingVariables();                                    
}

string   MarketWatcher::GetStateName(void)                          { return CurrentState.GetStateName();                          }
int      MarketWatcher::GetEntryPositionID(void)                    { return CurrentState.GetEntryPositionID();                    }
double   MarketWatcher::GetCapstoneLevel(void)                      { return CurrentState.GetCapstoneLevel();                      }
double   MarketWatcher::GetMaxFullyDefensiveAccumulationLevel(void) { return CurrentState.GetMaxFullyDefensiveAccumulationLevel(); }
double   MarketWatcher::GetBullishStopLossLevel(void)               { return CurrentState.GetBullishStopLossLevel();               }
double   MarketWatcher::GetBearishStopLossLevel(void)               { return CurrentState.GetBearishStopLossLevel();               }
double   MarketWatcher::GetBoomerangLevel(void)                     { return CurrentState.GetBoomerangLevel();                     }
bool     MarketWatcher::GetBoomerangStatus(void)                    { return CurrentState.GetBoomerangStatus();                    }
datetime MarketWatcher::GetEntryDateTime(void)                      { return CurrentState.GetEntryDateTime();                      }
datetime MarketWatcher::GetStartCacheDateTime(void)                 { return StartCacheDateTime;                                   }

//--- Services For State Class To Use
int MarketWatcher::GetInChannelBuffer(void)  { return InChannelBuffer;  }
int MarketWatcher::GetOutChannelBuffer(void) { return OutChannelBuffer; }
int MarketWatcher::GetWiggleBuffer(void)     { return WiggleBuffer;     }

double MarketWatcher::GetHighestFastFAMA(void)           { return HighestFastFAMA; }
double MarketWatcher::GetHighestBidPrice(void)           { return HighestBidPrice; }
double MarketWatcher::GetHighestAskPrice(void)           { return HighestAskPrice; }
double MarketWatcher::GetHighestSellStopLossLevel(void)  { return HighestSellStopLossLevel; }

double MarketWatcher::GetLowestFastFAMA(void)         { return LowestFastFAMA;  }
double MarketWatcher::GetLowestBidPrice(void)         { return LowestBidPrice;  }
double MarketWatcher::GetLowestAskPrice(void)         { return LowestAskPrice;  }
double MarketWatcher::GetLowestBuyStopLossLevel(void) { return LowestBuyStopLossLevel; }

int MarketWatcher::GetCurrentDiffFastFAMA_HighestFastFAMA_Pts(void) {
   return PriceToPointCvt(MathAbs(IP.GetFastFAMA(CURRENT_BAR) - GetHighestFastFAMA()));
}

int MarketWatcher::GetCurrentDiffFastFAMA_LowestFastFAMA_Pts(void) {
   return PriceToPointCvt(MathAbs(IP.GetFastFAMA(CURRENT_BAR) - GetLowestFastFAMA()));
}

//--- Tracking Helper Functions
void MarketWatcher::UpdateTrackingVariables(void) {
   UpdateHighestFastFAMA();
   UpdateHighestBidPrice();
   UpdateHighestAskPrice();
   UpdateHighestSellStopLossLevel();
   
   UpdateLowestFastFAMA();
   UpdateLowestBidPrice();
   UpdateLowestAskPrice();
   UpdateLowestBuyStopLossLevel();
   
   UpdateStartCacheDateTime();
}

void MarketWatcher::UpdateHighestFastFAMA(void)          { HighestFastFAMA = MathMax(HighestFastFAMA, IP.GetFastFAMA(CURRENT_BAR)); }
void MarketWatcher::UpdateHighestBidPrice(void)          { HighestBidPrice = MathMax(HighestBidPrice, IP.GetCurrentBid());          }
void MarketWatcher::UpdateHighestAskPrice(void)          { HighestAskPrice = MathMax(HighestAskPrice, IP.GetCurrentAsk());          }
void MarketWatcher::UpdateHighestSellStopLossLevel(void) { HighestSellStopLossLevel = MathMax(HighestSellStopLossLevel, IP.GetSellStopLossLevel(CURRENT_BAR)); }

void MarketWatcher::UpdateLowestFastFAMA(void) { 
   if (LowestFastFAMA == 0) {
      LowestFastFAMA = IP.GetFastFAMA(CURRENT_BAR);
   } else {
      LowestFastFAMA = MathMin(LowestFastFAMA , IP.GetFastFAMA(CURRENT_BAR));
   }
}

void MarketWatcher::UpdateLowestBidPrice(void) {
   if (LowestBidPrice == 0) {
      LowestBidPrice = IP.GetBidPrice(CURRENT_BAR);
   } else {
      LowestBidPrice = MathMin(LowestBidPrice , IP.GetCurrentBid());
   }
}

void MarketWatcher::UpdateLowestAskPrice(void) {
   if (LowestAskPrice == 0) {
      LowestAskPrice = IP.GetAskPrice(CURRENT_BAR);
   } else {
      LowestAskPrice = MathMin(LowestAskPrice , IP.GetCurrentAsk());
   }
}

void MarketWatcher::UpdateLowestBuyStopLossLevel(void) {
   if (LowestBuyStopLossLevel == 0) {
      LowestBuyStopLossLevel = IP.GetBuyStopLossLevel(CURRENT_BAR);
   } else {
      LowestBuyStopLossLevel = MathMin(LowestBuyStopLossLevel, IP.GetBuyStopLossLevel(CURRENT_BAR));
   }
}

void MarketWatcher::ResetTrackingVariables(void) {
   ResetHighestFastFAMA();
   ResetHighestBidPrice();
   ResetHighestAskPrice();
   ResetHighestSellStopLossLevel();
   
   ResetLowestFastFAMA();
   ResetLowestBidPrice();
   ResetLowestAskPrice();
   ResetLowestBuyStopLossLevel();
}

void MarketWatcher::ResetHighestFastFAMA(void) { HighestFastFAMA = IP.GetFastFAMA(CURRENT_BAR); }
void MarketWatcher::ResetHighestBidPrice(void) { HighestBidPrice = IP.GetCurrentBid();          }
void MarketWatcher::ResetHighestAskPrice(void) { HighestAskPrice = IP.GetCurrentAsk();          }
void MarketWatcher::ResetHighestSellStopLossLevel(void) { HighestSellStopLossLevel = IP.GetSellStopLossLevel(CURRENT_BAR); }

void MarketWatcher::ResetLowestFastFAMA(void)  { LowestFastFAMA  = IP.GetFastFAMA(CURRENT_BAR); }
void MarketWatcher::ResetLowestBidPrice(void)  { LowestBidPrice  = IP.GetCurrentBid();          }
void MarketWatcher::ResetLowestAskPrice(void)  { LowestAskPrice  = IP.GetCurrentAsk();          }
void MarketWatcher::ResetLowestBuyStopLossLevel(void)   { LowestBuyStopLossLevel   = IP.GetBuyStopLossLevel(CURRENT_BAR);  }

void MarketWatcher::UpdateStartCacheDateTime(void) {
   if (LastEntryDateTime < GetEntryDateTime()) {
      StartCacheDateTime     = LastLastEntryDateTime;
      LastLastEntryDateTime  = LastEntryDateTime;
      LastEntryDateTime      = GetEntryDateTime();
   }
}