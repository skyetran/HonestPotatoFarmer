//+------------------------------------------------------------------+
//|                                           HonestPotatoFarmer.mq5 |
//|                                   Copyright 2021, Skye Leblance. |
//|                        https://www.linkedin.com/in/skye-leblanc/ |
//+------------------------------------------------------------------+

#include "ConstructManagement/Construct/Construct.mqh"
#include "General/MoneyManagementHyperParameters.mqh"
#include "General/PositionManagementHyperParameters.mqh"
#include "MarketState/Ranging.mqh"
#include "MarketWatcher.mqh"

extern string           Text1                               = "Indicators Settings";
input  double           FastMAMA_FastLimit                  = 0.5;
input  double           FastMAMA_SlowLimit                  = 0.5;
input  double           SlowMAMA_FastLimit                  = 0.5;
input  double           SlowMAMA_SlowLimit                  = 0.05;
input  int              SSB_AttenuationPeriod               = 10;
input  double           SSB_MarketAlpha                     = 0.08;
input  double           SSB_Beta                            = 0.95;
input  double           SSB_StopLossBeta                    = 0.98;

extern string           Text2                               = "Market Classification Settings (Points)";
input  int              InChannelBuffer                     = 10;
input  int              OutChannelBuffer                    = 30;
input  int              WiggleBuffer                        = 5;

extern string           Text3                               = "Money Management Settings";
input  double           TimidFractionalKelly                = 0.4;
input  double           BoldFractionalKelly                 = 0.8;
input  double           CommissionPerStandardLot            = 0.0;

extern string           Text4                               = "Trade Settings (Points)";
input  int              Slippage                            = 5;
input  int              IntervalSizeIncrement               = 5;
input  int              MinLevel                            = 3;
input  int              OutOfBoundBuffer                    = 40;

extern string           Text5                               = "Execution Settings";
input  int              RateOfOperationsPerSecond           = 50;

//--- Global Variables
IndicatorProcessor *IP = IndicatorProcessor::GetInstance();
MarketWatcher *MW = new MarketWatcher(new Ranging());
MoneyManagementHyperParameters *MMHP = MoneyManagementHyperParameters::GetInstance();
PositionManagementHyperParameters *PMHP = PositionManagementHyperParameters::GetInstance(); 

int OnInit()
{
   if (!InitIndicator() || !InitMarketWatcher() || !InitMoneyManagement() || !InitPositionManagement()) {
      return(INIT_FAILED);
   }
   return(INIT_SUCCEEDED);
}

//--- Set Hyperparameters To Indicators
bool InitIndicator(void) {
   if (IP.SetFastMAMAParameters(FastMAMA_FastLimit, FastMAMA_SlowLimit)                      &&
       IP.SetSlowMAMAParameters(SlowMAMA_FastLimit, SlowMAMA_SlowLimit)                      &&
       IP.SetSSBParameters(SSB_AttenuationPeriod, SSB_MarketAlpha, SSB_Beta)                 &&
       IP.SetSSBStopLossParameters(SSB_AttenuationPeriod, SSB_MarketAlpha, SSB_StopLossBeta)  ) {
      IP.FullInit();
      return true;
   }
   return false;
}

//--- Set Hyperparameters For Market Segmentation
bool InitMarketWatcher(void) {
   return MW.SetInChannelBuffer(InChannelBuffer)   &&
          MW.SetOutChannelBuffer(OutChannelBuffer) &&
          MW.SetWiggleBuffer(WiggleBuffer)          ;
}

//--- Set Hyperparameters For Money Management
bool InitMoneyManagement(void) {
   return MMHP.LogTimidFractionalKelly(TimidFractionalKelly)         &&
          MMHP.LogBoldFractionalKelly(BoldFractionalKelly)           &&
          MMHP.LogCommissionPerStandardLot(CommissionPerStandardLot)  ;
}

//--- Set Hyperparameter For Position Management
bool InitPositionManagement(void) {
   return PMHP.LogSlippage(Slippage)                           &&
          PMHP.LogIntervalSizeIncrement(IntervalSizeIncrement) &&
          PMHP.LogMinLevel(MinLevel)                           &&
          PMHP.LogOutOfBoundBuffer(OutOfBoundBuffer)            ;
}

void OnTick()
{
   Update();
   string DebugMsg;
   //DebugMsg += IP.GetDebugMessage() + "\n";
   //DebugMsg += MW.GetDebugMessage();
   Comment(DebugMsg);
}

//--- Run All OnTick Functions
void Update(void) {
   IP.Update();
   MW.MonitorStateTransition();
   MW.UpdateTrackingVariables();
}