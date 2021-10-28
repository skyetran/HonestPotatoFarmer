//+------------------------------------------------------------------+
//|                                           HonestPotatoFarmer.mq5 |
//|                                   Copyright 2021, Skye Leblance. |
//|                        https://www.linkedin.com/in/skye-leblanc/ |
//+------------------------------------------------------------------+

#include "ConstructManagement/Construct/Construct.mqh"
#include "ConstructManagement/Factory/Counter/CounterFactory.mqh"
#include "General/GeneralSettings.mqh"
#include "General/MoneyManagementHyperParameters.mqh"
#include "General/PositionManagementHyperParameters.mqh"
#include "MarketState/Ranging.mqh"
#include "MarketWatcher.mqh"

#include <Trade\OrderInfo.mqh>
#include <Trade\DealInfo.mqh>

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
input  int              OutOfBoundBuffer                    = 40;
input  int              MinIntervalSize                     = 30;

extern string           Text5                               = "Execution Settings";
input  int              RateOfOperationsPerSecond           = 50;

extern string           Text6                               = "Expert Advisor ID Settings";
input  int              MagicNumber                         = 45723695;

//--- Global Variables
IndicatorProcessor *IP = IndicatorProcessor::GetInstance();
MarketWatcher *MW = new MarketWatcher(new Ranging());
GeneralSettings *GS = GeneralSettings::GetInstance();
MoneyManagementHyperParameters *MMHP = MoneyManagementHyperParameters::GetInstance();
PositionManagementHyperParameters *PMHP = PositionManagementHyperParameters::GetInstance(); 

int OnInit()
{
   if (!InitIndicator() || !InitMarketWatcher() || !InitMoneyManagement() || !InitPositionManagement() || !InitGeneralSettings()) {
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
          PMHP.LogOutOfBoundBuffer(OutOfBoundBuffer)           &&
          PMHP.LogMinIntervalSize(MinIntervalSize)              ;
}

//--- Set General Settings
bool InitGeneralSettings(void) {
   GS.LogMagicNumber(MagicNumber);
   return GS.LogRateOfOperationsPerSecond(RateOfOperationsPerSecond);
}

void OnTick()
{
   Update();
   string DebugMsg;
   //DebugMsg += IP.GetDebugMessage() + "\n";
   DebugMsg += MW.GetDebugMessage();

   //ConstructType         *TestType           = new ConstructType(BIG_HEDGE_LONG, FOUR_LEVEL);
   //ConstructParameters   *TestParameters     = new ConstructParameters(1, 1, 0.99700, 50);

   //Construct *Test = Construct::Create(TestType, TestParameters, 1);
   //ConstructFullTradePool *TestPool = Test.GetFullConstructTradePool();
   //CArrayList<MqlTradeRequestWrapper*> *RequestList = TestPool.GetRequest(1);
   //for (int i = 0; i < RequestList.Count(); i++) {
   //   MqlTradeRequestWrapper *Request;
   //   RequestList.TryGetValue(i, Request);
   //   DebugMsg += DoubleToString(Request.price) + " " + DoubleToString(Request.volume) + "\n";
   //}
   
   //ConstructPreCheckInfo *TestPreCheck = Construct::PreCheck(TestType, TestParameters);
   //DebugMsg += DoubleToString(TestPreCheck.GetMaxLotSizeExposure()) + "\n";
   //DebugMsg += DoubleToString(TestPreCheck.GetPersistingLotSizeExposure()) + "\n";
   //DebugMsg += IntegerToString(TestPreCheck.GetMaxPotentialLossInMinLotPointValue()) + "\n";
   
   static MqlTradeRequest request1 = {};
   static MqlTradeResult  result1  = {};
   static MqlTradeRequest request2 = {};
   static MqlTradeResult  result2  = {};
   static MqlTradeRequest request3 = {};
   static MqlTradeResult  result3  = {};
   static MqlTradeRequest request4 = {};
   static MqlTradeResult  result4  = {};
   static MqlTradeRequest request5 = {};
   static MqlTradeResult  result5  = {};
   static MqlTradeRequest request6 = {};
   static MqlTradeResult  result6  = {};
   
   static bool     OneTime = true;
   static datetime Start;
   if (OneTime) {
      OneTime = false;
      Start = TimeCurrent();
      
      request1.action    = TRADE_ACTION_PENDING;
      request1.magic     = GS.GetMagicNumber();
      request1.symbol    = Symbol();
      request1.deviation = PMHP.GetSlippageInPts();
      request1.type      = ORDER_TYPE_BUY_STOP_LIMIT;
      
      request1.volume    = 1;
      request1.price     = NormalizeDouble(IP.GetBidPrice(CURRENT_BAR) + 0.0003, Digits());
      request1.stoplimit = NormalizeDouble(IP.GetBidPrice(CURRENT_BAR), Digits());
      
      request2.action    = TRADE_ACTION_PENDING;
      request2.magic     = GS.GetMagicNumber();
      request2.symbol    = Symbol();
      request2.deviation = PMHP.GetSlippageInPts();
      request2.type      = ORDER_TYPE_SELL_LIMIT;
      
      request2.volume    = 1;
      request2.price     = NormalizeDouble(IP.GetBidPrice(CURRENT_BAR) + 0.0003, Digits());
      
      request3.action    = TRADE_ACTION_PENDING;
      request3.magic     = GS.GetMagicNumber();
      request3.symbol    = Symbol();
      request3.deviation = PMHP.GetSlippageInPts();
      request3.type      = ORDER_TYPE_BUY_STOP;
      
      request3.volume    = 1;
      request3.price     = NormalizeDouble(IP.GetBidPrice(CURRENT_BAR) + 0.0003, Digits());
      
      request4.action    = TRADE_ACTION_PENDING;
      request4.magic     = GS.GetMagicNumber();
      request4.symbol    = Symbol();
      request4.deviation = PMHP.GetSlippageInPts();
      request4.type      = ORDER_TYPE_SELL_STOP_LIMIT;
      
      request4.volume    = 1;
      request4.price     = NormalizeDouble(IP.GetBidPrice(CURRENT_BAR) - 0.0003, Digits());
      request4.stoplimit = NormalizeDouble(IP.GetBidPrice(CURRENT_BAR), Digits());
      
      request5.action    = TRADE_ACTION_PENDING;
      request5.magic     = GS.GetMagicNumber();
      request5.symbol    = Symbol();
      request5.deviation = PMHP.GetSlippageInPts();
      request5.type      = ORDER_TYPE_BUY_LIMIT;
      
      request5.volume    = 1;
      request5.price     = NormalizeDouble(IP.GetBidPrice(CURRENT_BAR) - 0.0003, Digits());
      
      request6.action    = TRADE_ACTION_DEAL;
      request6.magic     = GS.GetMagicNumber();
      request6.symbol    = Symbol();
      request6.deviation = PMHP.GetSlippageInPts();
      request6.type      = ORDER_TYPE_BUY;
      
      request6.volume    = 1;
      request6.price     = SymbolInfoDouble(Symbol(), SYMBOL_ASK);
      
      //OrderSend(request1, result1);
      //OrderSend(request2, result2);
      //OrderSend(request3, result3);
      //OrderSend(request4, result4);
      //OrderSend(request5, result5);
      //OrderSend(request6, result6);
   }
   ulong deal_ticket;            // deal ticket
   ulong order_ticket;           // ticket of the order the deal was executed on
   datetime transaction_time;    // time of a deal execution 
   long deal_type ;              // type of a trade operation
   long position_ID;             // position ID
   string deal_description;      // operation description
   double volume;                // operation volume
   string symbol;                // symbol of the deal
   datetime from_date=0;         
   datetime to_date=TimeCurrent();

   HistorySelect(from_date,to_date);

   int deals=HistoryDealsTotal();
//--- now process each trade
   for(int i=0;i<deals;i++)
     {
      deal_ticket=               HistoryDealGetTicket(i);
      volume=                    HistoryDealGetDouble(deal_ticket,DEAL_VOLUME);
      transaction_time=(datetime)HistoryDealGetInteger(deal_ticket,DEAL_TIME);
      order_ticket=              HistoryDealGetInteger(deal_ticket,DEAL_ORDER);
      deal_type=                 HistoryDealGetInteger(deal_ticket,DEAL_TYPE);
      symbol=                    HistoryDealGetString(deal_ticket,DEAL_SYMBOL);
      position_ID=               HistoryDealGetInteger(deal_ticket,DEAL_POSITION_ID);
      //--- perform fine formatting for the deal number
      string print_index=StringFormat("% 3d",i);
      //--- show information on the deal
      //Print(print_index+": deal #",deal_ticket," at ",position_ID);
     }
   
   //DebugMsg += HistoryOrderSelect(result6.order) + "\n";
   //DebugMsg += HistoryOrderGetDouble(result6.order, ORDER_VOLUME_INITIAL) + "\n";
   //DebugMsg += HistoryOrderGetDouble(result6.order, ORDER_VOLUME_CURRENT) + "\n";
   
   Comment(DebugMsg);
}

//--- Run All OnTick Functions
void Update(void) {
   IP.Update();
   MW.Monitor();
}