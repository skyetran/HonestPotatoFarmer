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

bool MoneyManagementHyperParameters::LogBoldFractionalKelly(const double &InputBoldFractionalKelly) {
   if (IsFractionalKellyValid(InputBoldFractionalKelly)) {
      BoldFractionalKelly = InputBoldFractionalKelly;
      return true;
   }
   return false;
}

bool MoneyManagementHyperParameters::LogCommissionPerStandardLot(const double &InputCommissionPerStandardLot) {
   if (IsCommissionPerStandardLotValid(InputCommissionPerStandardLot)) {
      CommissionPerStandardLot = InputCommissionPerStandardLot;
      return true;
   }
   return false;
}

//--- Validation
bool MoneyManagementHyperParameters::IsFractionalKellyValid(const double &InputFractionalKelly) { 
   return MIN_FRACTIONAL_KELLY < InputFractionalKelly && InputFractionalKelly < MAX_FRACTIONAL_KELLY; 
}

bool MoneyManagementHyperParameters::IsCommissionPerStandardLotValid(const double &InputCommissionPerStandardLot) {
   return InputCommissionPerStandardLot >= MIN_COMMISSION_PER_STANDARD_LOT;
}

//--- Getters
double MoneyManagementHyperParameters::GetTimidFractionalKelly(void) { return TimidFractionalKelly; }
double MoneyManagementHyperParameters::GetBoldFractionalKelly(void)  { return BoldFractionalKelly;  }

int MoneyManagementHyperParameters::GetCommissionCostInPts(void) {
   return (int) MathCeil(CommissionPerStandardLot / GetPointValuePerStandardLot());
}

double MoneyManagementHyperParameters::GetPointValuePerStandardLot(void) {
   return (SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_VALUE) / SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_SIZE)) * SymbolInfoDouble(Symbol(), SYMBOL_POINT);
}