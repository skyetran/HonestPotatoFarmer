#ifndef MONEY_MANAGEMENT_HYPER_PARAMETERS_H
#define MONEY_MANAGEMENT_HYPER_PARAMETERS_H

#define MIN_FRACTIONAL_KELLY 0
#define MAX_FRACTIONAL_KELLY 1

class MoneyManagementHyperParameters
{
public:
   //--- Get Singleton Instance
   static MoneyManagementHyperParameters *GetInstance(void);
   
   //--- Setters And Validation
   bool LogTimidFractionalKelly(const double &InputTimidFractionalKelly);
   bool LogBoldFractionalKelly(const double &InputBoldFractionalKelly);
   
   //--- Getters
   double GetTimidFractionalKelly(void);
   double GetBoldFractionalKelly(void);

private:
   //--- Main Constructor --- Singleton
   MoneyManagementHyperParameters(void);
   
   //--- Hyperparameters
   double TimidFractionalKelly, BoldFractionalKelly;
   
   static MoneyManagementHyperParameters *Instance;
   
   //--- Validation
   bool IsFractionalKellyValid(const double &InputFractionalKelly);
};

MoneyManagementHyperParameters* MoneyManagementHyperParameters::Instance = NULL;

#endif