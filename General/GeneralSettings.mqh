#ifndef GENERAL_SETTINGS_H
#define GENERAL_SETTINGS_H

#define MIN_RATE_OF_OPERATIONS_PER_SECOND 0

class GeneralSettings
{
public:
   //--- Get Singleton Instance
   static GeneralSettings *GetInstance(void);
   
   //--- Setters And Validation
   bool LogRateOfOperationsPerSecond(const int &InputRateOfOperationsPerSecond);
   void LogMagicNumber(const int &InputMagicNumber);

   //--- Getters
   int GetRateOfOperationsPerSecond(void) const;
   int GetMagicNumber(void)               const;

private:
   //--- Main Constructor --- Singleton
   GeneralSettings(void);
   
   //--- Hyperparamenters
   int RateOfOperationsPerSecond;
   int MagicNumber;
   
   static GeneralSettings *Instance;
   
   //--- Validation
   bool IsRateOfOperationsPerSecond(const int &InputRateOfOperationsPerSecond) const;
};

GeneralSettings* GeneralSettings::Instance = NULL;

#endif