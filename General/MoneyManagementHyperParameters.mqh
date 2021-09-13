#ifndef MONEY_MANAGEMENT_HYPER_PARAMETERS_H
#define MONEY_MANAGEMENT_HYPER_PARAMETERS_H

#include "GlobalHelperFunctions.mqh"
#include "IndicatorProcessor.mqh"

#define MIN_FRACTIONAL_KELLY 0
#define MAX_FRACTIONAL_KELLY 1

#define MIN_COMMISSION_PER_STANDARD_LOT 0

class MoneyManagementHyperParameters
{
public:
   //--- Get Singleton Instance
   static MoneyManagementHyperParameters *GetInstance(void);
   
   //--- Setters And Validation
   bool LogTimidFractionalKelly(const double &InputTimidFractionalKelly);
   bool LogBoldFractionalKelly(const double &InputBoldFractionalKelly);
   bool LogCommissionPerStandardLot(const double &InputCommissionPerStandardLot);
   
   //--- Getters
   double GetTimidFractionalKelly(void);
   double GetBoldFractionalKelly(void);
   double GetCommisionCostInPrice(void);
   int    GetCommissionCostInPts(void);

private:
   IndicatorProcessor *IP;
   
   //--- Main Constructor --- Singleton
   MoneyManagementHyperParameters(void);
   
   //--- Hyperparameters
   double TimidFractionalKelly, BoldFractionalKelly;
   double CommissionPerStandardLot;
   
   static MoneyManagementHyperParameters *Instance;
   
   //--- Validation
   bool IsFractionalKellyValid(const double &InputFractionalKelly);
   bool IsCommissionPerStandardLotValid(const double &InputCommissionPerStandardLot);
   
   //--- Helper
   double GetPointValuePerStandardLot(void);
};

MoneyManagementHyperParameters* MoneyManagementHyperParameters::Instance = NULL;

#endif