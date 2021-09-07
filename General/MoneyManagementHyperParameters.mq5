#property strict

#include "../General/MoneyManagementHyperParameters.mqh"

//--- Main Constructor
MoneyManagementHyperParameters::MoneyManagementHyperParameters(void) { }

//--- Get Singleton Instance
MoneyManagementHyperParameters* MoneyManagementHyperParameters::GetInstance(void) {
   if (!Instance) {
      Instance = new MoneyManagementHyperParameters();
   }
   return Instance;
}

//--- Setters And Validation
bool MoneyManagementHyperParameters::LogTimidFractionalKelly(const double &InputTimidFractionalKelly) {
   if (IsFractionalKellyValid(InputTimidFractionalKelly)) {
      TimidFractionalKelly = InputTimidFractionalKelly;
      return true;
   }
   return false;
}

bool MoneyManagementHyperParameters::LogBoldFractionalKelly(const double &InputBoldFractionalKelly) {
   if (IsFractionalKellyValid(InputBoldFractionalKelly)) {
      BoldFractionalKelly = InputBoldFractionalKelly;
      return true;
   }
   return false;
}

//--- Validation
bool MoneyManagementHyperParameters::IsFractionalKellyValid(const double &InputFractionalKelly) { 
   return MIN_FRACTIONAL_KELLY < InputFractionalKelly && InputFractionalKelly < MAX_FRACTIONAL_KELLY; 
}

//--- Getters
double MoneyManagementHyperParameters::GetTimidFractionalKelly(void) { return TimidFractionalKelly; }
double MoneyManagementHyperParameters::GetBoldFractionalKelly(void)  { return BoldFractionalKelly;  }