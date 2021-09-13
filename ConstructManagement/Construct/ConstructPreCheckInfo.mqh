#ifndef CONSTRUCT_PRE_CHECK_INFO
#define CONSTRUCT_PRE_CHECK_INFO

//+----------------------------------------------+
//| All Value Are Based On One Standard Lot Size |
//+----------------------------------------------+
class ConstructPreCheckInfo
{
public:
   //--- Default Constructor
   ConstructPreCheckInfo(void);
   
   //--- Main Constructor
   ConstructPreCheckInfo(const double &InputMaxMarginRequirement, const double &InputPersistingMarginRequirement, const double &InputMaxPotentialLoss);
   
   //--- Getters
   double GetMaxMarginRequirement(void)         const;
   double GetPersistingMarginRequirement(void)  const;
   double GetMaxPotentialLoss(void)             const;
   
private:
   //--- Attributes
   double MaxMarginRequirement;
   double PersistingMarginRequirement;
   double MaxPotentialLoss;
};

#endif