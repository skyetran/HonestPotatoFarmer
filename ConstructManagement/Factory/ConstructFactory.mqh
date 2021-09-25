#ifndef CONSTRUCT_FACTORY_H
#define CONSTRUCT_FACTORY_H

#include "../Construct/Construct.mqh"
#include "../../General/GeneralSettings.mqh"
#include "../../General/PositionManagementHyperParameters.mqh"

class ConstructFactory
{
public:
   //--- Constructor
   ConstructFactory(void);
   
   //--- Operations
   virtual ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 = NULL;   //--- Computed By Hand
   virtual bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) = NULL;
   virtual Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   = NULL;

protected:
   //--- Other Entities
   GeneralSettings                   *GS;
   IndicatorProcessor                *IP;
   PositionManagementHyperParameters *PMHP;

   //--- Attributes
   ConstructType *Type;  
   
   //--- Helper Functions: Validate Operation
   bool IsAttributeValidFundamentally(ConstructParameters *InputParameters, const int InputEntryPositionID) const;
   
   bool IsNetLong(ConstructParameters *InputParameters)    const;
   bool IsNetShort(ConstructParameters *InputParameters)   const;
   
   bool IsTwoLevel(ConstructParameters *InputParameters)   const;
   bool IsThreeLevel(ConstructParameters *InputParameters) const;
   bool IsFourLevel(ConstructParameters *InputParameters)  const;
   bool IsFiveLevel(ConstructParameters *InputParameters)  const;
   bool IsSixLevel(ConstructParameters *InputParameters)   const;
   bool IsSevenLevel(ConstructParameters *InputParameters) const;
   
   //--- Helper Functions: Create Operation
   void   LogCoreInformation(Construct *NewConstruct, ConstructParameters *InputParameters, const int InputEntryPositionID);
   double GetNLevelPrice(ConstructParameters *InputParameters, const int Level);
   double GetSpreadOffsetBuyOrderPriceEntry(const double OriginalPriceEntry)         const;
   double GetStopLevelUpperOffsetPriceEntry(const double OriginalPriceEntry)         const;
   double GetStopLevelLowerOffsetPriceEntry(const double OriginalPriceEntry)         const;
   double GetStopLevelSlippageUpperOffsetPriceEntry(const double OriginalPriceEntry) const;
   double GetStopLevelSlippageLowerOffsetPriceEntry(const double OriginalPriceEntry) const;
   
   //--- Raw Base Entry Orders (Big Hedge)
   MqlTradeRequestWrapper *BuyRawMarketOrderRequest(const double volume);
   MqlTradeRequestWrapper *SellRawMarketOrderRequest(const double volume);
   
   //--- Base Entry Orders (Counter & Free Styling)
   MqlTradeRequestWrapper *BuyMarketOrderRequest(const double volume);
   MqlTradeRequestWrapper *SellMarketOrderRequest(const double volume);
   
   //--- Limit Entry Orders
   MqlTradeRequestWrapper *BuyLimitOrderRequest(const double volume, const double price);
   MqlTradeRequestWrapper *SellLimitOrderRequest(const double volume, const double price);
   
   //--- Stop Limit Entry Orders
   MqlTradeRequestWrapper *BuyStopLimitOrderRequest(const double volume, const double price, const double stoplimit);
   MqlTradeRequestWrapper *SellStopLimitOrderRequest(const double volume, const double price, const double stoplimit);
   
   //--- Stop Orders
   MqlTradeRequestWrapper *BuyStopOrderRequest(const double volume, const double price);
   MqlTradeRequestWrapper *SellStopOrderRequest(const double volume, const double price);
   
   virtual ConstructFullTradePool *CreateFullTradePool(ConstructParameters *InputParameters) = NULL;
   
private:
   //--- Helper Functions: IsAttributeValidFundamentally
   bool IsParametersValidFundamentally(ConstructParameters *InputParameters) const;
   bool IsEntryPositionIDValidFundamentally(const int InputEntryPositionID)  const;
   
   //--- Helper Functions: IsThreeLevel, IsFourLevel, IsFiveLevel, IsSixLevel, IsSevenLevel
   int    GetConstructLevel(ConstructParameters* InputParameters)         const;
   int    GetConstructHeightInPts(ConstructParameters *InputParameters)   const;
   double GetConstructHeightInPrice(ConstructParameters *InputParameters) const;
   
   //--- Classifier: Upper Construct (Counter & FreeStyling) Or Lower Construct (BigHedge)
   bool IsUpperConstruct(ConstructParameters *InputParameters) const;
   
   //--- Helper Functions: GetNLevelPrice
   double GetNLevelPriceUpperConstruct(ConstructParameters *InputParameters, const int Level);
   double GetNLevelPriceLowerConstruct(ConstructParameters *InputParameters, const int Level);
   double GetOutOfBoundPrice(ConstructParameters *InputParameters);
   
   //--- Helper Functions: BuyMarketOrderRequest & SellMarketOrderRequest
   double GetSlippageOffsetBuyOrderPriceEntry(const double OriginalPriceEntry)  const;
   double GetSlippageOffsetSellOrderPriceEntry(const double OriginalPriceEntry) const;
   
   //--- Other Auxilary Functions
   bool IsLevelValid(const int InputLevel)      const;
   bool IsLevelOutOfBound(const int InputLevel) const;
};

#endif