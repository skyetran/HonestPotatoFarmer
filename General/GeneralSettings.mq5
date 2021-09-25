#property strict

#include "../General/GeneralSettings.mqh"

//--- Main Constructor
GeneralSettings::GeneralSettings(void) { }

//--- Get Singleton Instance
GeneralSettings *GeneralSettings::GetInstance(void) {
   if (!Instance) {
      Instance = new GeneralSettings();
   }
   return Instance;
}

//--- Setters And Validation
bool GeneralSettings::LogRateOfOperationsPerSecond(const int &InputRateOfOperationsPerSecond) {
   if (IsRateOfOperationsPerSecond(InputRateOfOperationsPerSecond)) {
      RateOfOperationsPerSecond = InputRateOfOperationsPerSecond;
      return true;
   }
   return false;
}

bool GeneralSettings::IsRateOfOperationsPerSecond(const int &InputRateOfOperationsPerSecond) const {
   return InputRateOfOperationsPerSecond > MIN_RATE_OF_OPERATIONS_PER_SECOND;
}

void GeneralSettings::LogMagicNumber(const int &InputMagicNumber) {
   MagicNumber = InputMagicNumber;
}

//--- Getters
int GeneralSettings::GetRateOfOperationsPerSecond(void) const { return RateOfOperationsPerSecond; }
int GeneralSettings::GetMagicNumber(void)               const { return MagicNumber;               }