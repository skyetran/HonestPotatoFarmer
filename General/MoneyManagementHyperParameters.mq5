#property strict

#include "../General/MoneyManagementHyperParameters.mqh"

//--- Main Constructor
MoneyManagementHyperParameters::MoneyManagementHyperParameters(void) {
   IP = IndicatorProcessor::GetInstance();
}

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

//--- Setters And Validation
bool MoneyManagementHyperParameters::LogBoldFractionalKelly(const double &InputBoldFractionalKelly) {
   if (IsFractionalKellyValid(InputBoldFractionalKelly)) {
      BoldFractionalKelly = InputBoldFractionalKelly;
      return true;
   }
   return false;
}

//--- Setters And Validation
bool MoneyManagementHyperParameters::LogCommissionPerStandardLot(const double &InputCommissionPerStandardLot) {
   if (IsCommissionPerStandardLotValid(InputCommissionPerStandardLot)) {
      CommissionPerStandardLot = InputCommissionPerStandardLot;
      return true;
   }
   return false;
}

//--- Validation
bool MoneyManagementHyperParameters::IsFractionalKellyValid(const double &InputFractionalKelly) const { 
   return MIN_FRACTIONAL_KELLY < InputFractionalKelly && InputFractionalKelly < MAX_FRACTIONAL_KELLY; 
}

//--- Validation
bool MoneyManagementHyperParameters::IsCommissionPerStandardLotValid(const double &InputCommissionPerStandardLot) const {
   return InputCommissionPerStandardLot >= MIN_COMMISSION_PER_STANDARD_LOT;
}

//--- Getters
double MoneyManagementHyperParameters::GetTimidFractionalKelly(void) const { return TimidFractionalKelly; }
double MoneyManagementHyperParameters::GetBoldFractionalKelly(void)  const { return BoldFractionalKelly;  }

int MoneyManagementHyperParameters::GetCommissionCostInPts(void) const {
   return (int) MathCeil(CommissionPerStandardLot / GetPointValuePerStandardLot());
}

double MoneyManagementHyperParameters::GetPointValuePerStandardLot(void) const {
   return (SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_VALUE) / SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_SIZE)) * SymbolInfoDouble(Symbol(), SYMBOL_POINT);
}