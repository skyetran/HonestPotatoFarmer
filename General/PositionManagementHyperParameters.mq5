#property strict

#include "../General/PositionManagementHyperParameters.mqh"

//--- Main Constructor
PositionManagementHyperParameters::PositionManagementHyperParameters(void) { }

//--- Get Singleton Instance
PositionManagementHyperParameters *PositionManagementHyperParameters::GetInstance(void) {
   if (!Instance) {
      Instance = new PositionManagementHyperParameters();
   }
   return Instance;
}

//--- Setter And Validation
bool PositionManagementHyperParameters::LogSlippage(const int &InputSlippage) {
   if (IsSlippageValid(InputSlippage)) {
      Slippage = InputSlippage;
      return true;
   }
   return false;
}

bool PositionManagementHyperParameters::LogIntervalSizeIncrement(const int &InputIntervalSizeIncrement) {
   if (IsIntervalSizeIncrementValid(InputIntervalSizeIncrement)) {
      IntervalSizeIncrement = InputIntervalSizeIncrement;
      return true;
   }
   return false;
}

bool PositionManagementHyperParameters::LogMinLevel(const int &InputMinLevel) {
   if (IsMinLevelValid(InputMinLevel)) {
      MinLevel = InputMinLevel;
      return true;
   }
   return false;
}

bool PositionManagementHyperParameters::LogOutOfBoundBuffer(const int &InputOutOfBoundBuffer) {
   if (IsOutOfBoundBufferValid(InputOutOfBoundBuffer)) {
      OutOfBoundBuffer = InputOutOfBoundBuffer;
      return true;
   }
   return false;
}

//--- Validation
bool PositionManagementHyperParameters::IsSlippageValid(const int &InputSlippage) {
   return MIN_SLIPPAGE <= InputSlippage && InputSlippage <= MAX_SLIPPAGE;
}

bool PositionManagementHyperParameters::IsIntervalSizeIncrementValid(const int &InputIntervalSizeIncrement) {
   return InputIntervalSizeIncrement >= MIN_INTERVAL_SIZE_INCREMENT;
}

bool PositionManagementHyperParameters::IsMinLevelValid(const int &InputMinLevel) {
   return InputMinLevel >= MIN_MIN_LEVEL;
}

bool PositionManagementHyperParameters::IsOutOfBoundBufferValid(const int &InputOutOfBoundBuffer) {
   return InputOutOfBoundBuffer >= MIN_OUT_OF_BOUND_BUFFER;
}

//--- Getters
int PositionManagementHyperParameters::GetSlippage(void)              { return Slippage;              }
int PositionManagementHyperParameters::GetIntervalSizeIncrement(void) { return IntervalSizeIncrement; }
int PositionManagementHyperParameters::GetMinLevel(void)              { return MinLevel;              }
int PositionManagementHyperParameters::GetOutOfBoundBuffer(void)      { return OutOfBoundBuffer;      }