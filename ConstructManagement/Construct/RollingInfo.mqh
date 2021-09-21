#ifndef CONSTRUCT_ROLLING_INFO
#define CONSTRUCT_ROLLING_INFO

class ConstructRollingInfo
{
public:
   //--- Main Constructor
   ConstructRollingInfo(void);
   
   //--- Updaters
   void UpdateReleasedFreeMargin(const double NewReleasedFreeMargin);
   void UpdatePositiveSlippageInPrice(const double NewPositiveSlippageInPrice);
   void UpdatePositiveSlippageInPts(const int NewPositiveSlippageInPts);
   void UpdateValueAtRisk(const double NewValueAtRisk);
   void UpdateActiveStatus(const bool NewActiveStatus);
  
   //--- Getters
   double GetReleasedFreeMargin(void)      const;
   double GetPositiveSlippageInPrice(void) const;
   int    GetPositiveSlippageInPts(void)   const;
   double GetValueAtRisk(void)             const;
   bool   IsRiskFree(void)                 const;
   bool   HasCompleteLifeCycle(void)       const;
   
private:
   //--- Attributes
   double ReleasedFreeMargin;
   double PositiveSlippageInPrice;
   int    PositiveSlippageInPts;
   double ValueAtRisk;
   bool   ActiveStatus;
};

#endif