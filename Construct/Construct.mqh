#ifndef CONSTRUCT_H
#define CONSTRUCT_H

#include "../Wrapper/MqlTradeRequestWrapper.mqh"

class Construct
{
public:
   //--- Default Constructor
   Construct(void);
   
   //--- Main Constructor
   Construct(double CapstoneLevel, double ApexLevel, double StopLossLevel);
   
   //--- Getters
   int GetCapstoneToApexInPts(void);
   int GetCapstonetoStopLossInPts(void);
   int GetMinIntervalSize(void);
   
   double GetMaxMarginRequirement(void);
   double GetReleasedFreeMargin(void);
   double GetPersistingMarginRequirement(void);
   
   double GetBreakEvenLevel(void);
   double GetOutOfBoundLevel(void);
   
   double GetMaxPotentialLoss(void);
   bool   IsRiskFree(void);
   
   int    GetPositiveSlippageInPts(void);
   double GetPositiveSlippageInPrice(void);
   
   //--- Add New Order Depends On Market Movement
   virtual void Monitor(void) = NULL;
   
   
protected:
   double CapstoneLevel;
   double ApexLevel;
   double StopLossLevel;
   int    IntervalSize;
   int    LevelCount;
   
   double MaxMarginRequirement;
   double ReleasedFreeMargin;
   double PersistingMarginRequirement;
   
   double BreakEvenLevel;
   double OutOfBoundLevel;
   
   double MaxPotentialLoss;
   
   int    PositiveSlippageInPts;
   double PositiveSlippageInPrice;
};

#endif