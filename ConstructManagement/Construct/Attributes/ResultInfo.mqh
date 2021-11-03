#ifndef CONSTRUCT_RESULT_INFO
#define CONSTRUCT_RESULT_INFO

class ConstructResultInfo
{
public:
   //--- Default Constructor
   ConstructResultInfo(void);
   
   //--- Main Constructor
   ConstructResultInfo(const double InputTotalRealizedProfit, const double InputMaxRisk);
   
   //--- Getters
   double GetTotalRealizedProfit(void) const;
   double GetMaxRisk(void) const;
   
   //--- Updaters
   void UpdateTotalRealizedProfit(const double NewTotalRealizedProfit);
   void UpdateMaxRisk(const double NewMaxRisk);
   
private:
   //--- Attributes
   double TotalRealizedProfit;
   double MaxRisk;
};

#endif