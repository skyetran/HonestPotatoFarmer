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

bool PositionManagementHyperParameters::LogOutOfBoundBuffer(const int &InputOutOfBoundBuffer) {
   if (IsOutOfBoundBufferValid(InputOutOfBoundBuffer)) {
      OutOfBoundBuffer = InputOutOfBoundBuffer;
      return true;
   }
   return false;
}

//--- Validation
bool PositionManagementHyperParameters::IsSlippageValid(const int &InputSlippage) const {
   return MIN_SLIPPAGE <= InputSlippage && InputSlippage <= MAX_SLIPPAGE;
}

bool PositionManagementHyperParameters::IsIntervalSizeIncrementValid(const int &InputIntervalSizeIncrement) const {
   return InputIntervalSizeIncrement >= MIN_INTERVAL_SIZE_INCREMENT;
}

bool PositionManagementHyperParameters::IsOutOfBoundBufferValid(const int &InputOutOfBoundBuffer) const {
   return InputOutOfBoundBuffer >= MIN_OUT_OF_BOUND_BUFFER;
}

//--- Getters
int    PositionManagementHyperParameters::GetSlippageInPts(void)           const { return Slippage;                          }
double PositionManagementHyperParameters::GetSlippageInPrice(void)         const { return PointToPriceCvt(Slippage);         }
int    PositionManagementHyperParameters::GetIntervalSizeIncrement(void)   const { return IntervalSizeIncrement;             }
int    PositionManagementHyperParameters::GetOutOfBoundBufferInPts(void)   const { return OutOfBoundBuffer;                  }
double PositionManagementHyperParameters::GetOutOfBoundBufferInPrice(void) const { return PointToPriceCvt(OutOfBoundBuffer); }