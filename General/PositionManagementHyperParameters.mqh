#ifndef POSITION_MANAGEMENT_HYPER_PARAMETERS_H
#define POSITION_MANAGEMENT_HYPER_PARAMETERS_H

#define MIN_SLIPPAGE                3
#define MAX_SLIPPAGE                20
#define MIN_INTERVAL_SIZE_INCREMENT 2
#define MIN_MIN_LEVEL               3

class PositionManagementHyperParameters
{
public:
   //--- Get Singleton Instance
   static PositionManagementHyperParameters *GetInstance(void);
   
   //--- Setters And Validation
   bool LogSlippage(const int &InputSlippage);
   bool LogIntervalSizeIncrement(const int &InputIntervalSizeIncrement);
   bool LogMinLevel(const int &InputMinLevel);

   //--- Getters
   int GetSlippage(void);
   int GetIntervalSizeIncrement(void);
   int GetMinLevel(void);

private:
   //--- Main Constructor --- Singleton
   PositionManagementHyperParameters(void);
   
   //--- Hyperparamenters
   int Slippage;
   int IntervalSizeIncrement;
   int MinLevel;
   
   static PositionManagementHyperParameters *Instance;
   
   //--- Validation
   bool IsSlippageValid(const int &InputSlippage);
   bool IsIntervalSizeIncrementValid(const int &InputIntervalSizeIncrement);
   bool IsMinLevelValid(const int &InputMinLevel);
};

PositionManagementHyperParameters* PositionManagementHyperParameters::Instance = NULL;

#endif