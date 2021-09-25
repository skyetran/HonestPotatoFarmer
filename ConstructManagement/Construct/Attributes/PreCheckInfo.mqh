#ifndef CONSTRUCT_PRE_CHECK_INFO
#define CONSTRUCT_PRE_CHECK_INFO

class ConstructPreCheckInfo
{
public:
   //--- Default Constructor
   ConstructPreCheckInfo(void);
   
   //--- Main Constructor
   ConstructPreCheckInfo(const double InputMaxLotSizeExposure, const double InputPersistingLotSizeExposure, const int InputMaxPotentialLossInMinLotPointValue);
   
   //--- Getters
   double GetMaxLotSizeExposure(void)                 const;
   double GetPersistingLotSizeExposure(void)          const;
   int    GetMaxPotentialLossInMinLotPointValue(void) const;
   
private:
   //--- Attributes
   double MaxLotSizeExposure;
   double PersistingLotSizeExposure;
   int    MaxPotentialLossInMinLotPointValue;
};

#endif