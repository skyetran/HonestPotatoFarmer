#ifndef MARKET_WATCHER_H
#define MARKET_WATCHER_H

#include "Wrapper/MqlTradeRequestWrapper.mqh"

#include "General/GlobalConstants.mqh"
#include "General/GlobalHelperFunctions.mqh"
#include "General/IndicatorProcessor.mqh"
#include "General/PositionManagementHyperParameters.mqh"
#include "MarketState/MarketState.mqh"

#define MIN_BUFFER_ZONE 0

class MarketWatcher
{
public:
   //--- Default Constructor
   MarketWatcher(void);
   
   //--- Main Constructor
   MarketWatcher(MarketState* InitialState);
   
   //--- Destructor
   ~MarketWatcher(void);
   
   //--- Debug
   string GetDebugMessage(void);
   
   //--- Setters (Hyperparameters)
   bool SetInChannelBuffer(const int &BufferZone);
   bool SetOutChannelBuffer(const int &BufferZone);
   bool SetWiggleBuffer(const int &BufferZone);
   
   //--- Switch Current State
   void ChangeState(MarketState* State);
   
   //--- Delegation Behavioral Logics To The Current State
   void     Monitor(void);
   string   GetStateName(void);
   int      GetEntryPositionID(void);
   double   GetMaxFullyDefensiveAccumulationLevel(void);
   double   GetCapstoneLevel(void);
   double   GetBullishStopLossLevel(void);
   double   GetBearishStopLossLevel(void);
   double   GetBoomerangLevel(void);
   bool     GetBoomerangStatus(void);
   datetime GetEntryDateTime(void);
   datetime GetStartCacheDateTime(void);
   
   //--- Services For State Class To Use
   int GetInChannelBuffer(void);
   int GetOutChannelBuffer(void);
   int GetWiggleBuffer(void);

   double GetHighestFastFAMA(void);
   double GetHighestBidPrice(void);
   double GetHighestAskPrice(void);
   double GetHighestSellStopLossLevel(void);
   
   double GetLowestFastFAMA(void);
   double GetLowestBidPrice(void);
   double GetLowestAskPrice(void);
   double GetLowestBuyStopLossLevel(void);
   
   int GetCurrentDiffFastFAMA_HighestFastFAMA_Pts(void);
   int GetCurrentDiffFastFAMA_LowestFastFAMA_Pts(void);
   
   //--- Monitor Tracking Variables
   void UpdateTrackingVariables(void);
   void ResetTrackingVariables(void);

private:
   //--- External Entities
   IndicatorProcessor *IP;
   PositionManagementHyperParameters *PMHP;
   
   //--- Hyperparameters
   int InChannelBuffer, OutChannelBuffer, WiggleBuffer;
   
   // Validation: BufferZone
   bool IsBufferZoneValid(const int &BufferZone);
   
   MarketState* CurrentState;
   
   //--- Tracking Variables
   double   HighestFastFAMA, LowestFastFAMA;
   double   HighestBidPrice, HighestAskPrice, LowestBidPrice, LowestAskPrice;
   double   LowestBuyStopLossLevel, HighestSellStopLossLevel;
   datetime StartCacheDateTime, LastEntryDateTime, LastLastEntryDateTime;

   //--- Tracking Helper Functions
   void UpdateHighestFastFAMA(void);
   void UpdateHighestBidPrice(void);
   void UpdateHighestAskPrice(void);
   void UpdateHighestSellStopLossLevel(void);
   
   void UpdateLowestFastFAMA(void);
   void UpdateLowestBidPrice(void);
   void UpdateLowestAskPrice(void);
   void UpdateLowestBuyStopLossLevel(void);
   
   void ResetHighestFastFAMA(void);
   void ResetHighestBidPrice(void);
   void ResetHighestAskPrice(void);
   void ResetHighestSellStopLossLevel(void);
   
   void ResetLowestFastFAMA(void);
   void ResetLowestBidPrice(void);
   void ResetLowestAskPrice(void);
   void ResetLowestBuyStopLossLevel(void);
   
   void UpdateStartCacheDateTime(void);
};

#endif